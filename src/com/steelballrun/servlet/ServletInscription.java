package com.steelballrun.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.UUID;

import com.steelballrun.dao.MountDAO;
import com.steelballrun.dao.PersonDAO;
import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.dao.UserDAO;
import com.steelballrun.model.Mount;
import com.steelballrun.model.Person;
import com.steelballrun.model.Runner;
import com.steelballrun.model.User;
import com.steelballrun.util.AuthUtil;
import com.steelballrun.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/inscription")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class ServletInscription extends HttpServlet {

	private PersonDAO personDAO;
	private RunnerDAO runnerDAO;
	private MountDAO  mountDAO;
	private UserDAO   userDAO;

	@Override
	public void init() {
		personDAO = new PersonDAO();
		runnerDAO = new RunnerDAO();
		mountDAO  = new MountDAO();
		userDAO   = new UserDAO();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		req.getRequestDispatcher("/inscription.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String name      = req.getParameter("runner-name");
		String country   = req.getParameter("runner-country");
		String ageStr    = req.getParameter("runner-age");
		String dni       = req.getParameter("runner-dni");
		String mountName = req.getParameter("mount-name");
		String mountType = req.getParameter("mount-type");
		Part   filePart  = req.getPart("user-file");

		if (isBlank(name) || isBlank(country) || isBlank(dni) || isBlank(mountName) || isBlank(mountType)) {
			error(req, res, "Todos los campos son requeridos.");
			return;
		}

		int age;
		try {
			age = Integer.parseInt(ageStr);
			if (age < 16) { error(req, res, "La edad mínima es 16 años."); return; }
		} catch (NumberFormatException e) {
			error(req, res, "La edad debe ser un número válido."); return;
		}

		byte[] imageData = null;
		if (filePart != null && filePart.getSize() > 0) {
			try (InputStream is = filePart.getInputStream()) {
				imageData = is.readAllBytes();
			}
		}

		// Passkey: contraseña en texto plano que se muestra una vez al usuario.
		// Se guarda HASHEADA en user.passkey. NO se guarda en runner.
		String passkey = UUID.randomUUID().toString();

		try (Connection conn = DatabaseConnection.getConnection()) {
			conn.setAutoCommit(false);
			try {
				int personId = personDAO.insertPersonAndGetId(new Person(0, name, age, country, dni), conn);
				int mountId  = mountDAO.insertMountAndGetId(new Mount(0, mountName, mountType), conn);

				Runner runner = new Runner();
				runner.setIdPerson(personId);
				runner.setIdMount(mountId);
				runner.setImage(imageData);
				runner.setPoints(0);
				runner.setKm(0);
				runner.setStatus("active");

				runnerDAO.insertRunner(runner, conn);
				conn.commit();

				// Obtener el dorsal del corredor recién insertado
				java.util.List<Runner> allRunners = runnerDAO.listRunners();
				int newBib = allRunners.isEmpty() ? -1 : allRunners.get(allRunners.size() - 1).getBib();

				// Crear usuario: passkey hasheada en user, nunca en runner
				String username = name.toLowerCase().replaceAll("[^a-z0-9]", "_") + "_" + newBib;
				User newUser = new User(0, username, AuthUtil.sha256(passkey), "user", newBib);
				userDAO.insert(newUser);

				// Iniciar sesión automáticamente
				User createdUser = userDAO.findByCredentials(username, AuthUtil.sha256(passkey));
				HttpSession session = req.getSession(true);
				session.setAttribute("loggedUser", createdUser);
				session.setMaxInactiveInterval(60 * 60);

				// Pasar datos a passkey.jsp para mostrarlos UNA sola vez
				session.setAttribute("registeredName",     name);
				session.setAttribute("registeredPasskey",  passkey);   // texto plano, solo en sesión
				session.setAttribute("registeredUsername", username);
				res.sendRedirect(req.getContextPath() + "/passkey.jsp");

			} catch (Exception e) {
				conn.rollback();
				error(req, res, "Error durante el registro: " + e.getMessage());
			}
		} catch (Exception e) {
			error(req, res, "Error al conectar con la base de datos: " + e.getMessage());
		}
	}

	private static boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }

	private void error(HttpServletRequest req, HttpServletResponse res, String msg)
			throws ServletException, IOException {
		req.setAttribute("message", msg);
		req.setAttribute("type", "error");
		req.getRequestDispatcher("/inscription.jsp").forward(req, res);
	}
}
