package com.steelballrunrace.servlet;

import com.steelballrunrace.dao.PersonDAO;
import com.steelballrunrace.model.Estudiante;
import com.steelballrunrace.model.Persona;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/insertarEstudiante")
public class ServletPersonCreate extends HttpServlet {

	private PersonDAO estudianteDAO;

	@Override
	public void init() throws ServletException {
		estudianteDAO = new PersonDAO();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String nombre = request.getParameter("nombre");
		String edadStr = request.getParameter("edad");
		String dni = request.getParameter("dni");
		String carrera = request.getParameter("carrera");
		String promedioStr = request.getParameter("promedio");

		try {
			int edad = Integer.parseInt(edadStr);
			double promedio = Double.parseDouble(promedioStr);

			Persona persona = new Persona(nombre, edad, dni);
			Estudiante estudiante = new Estudiante(carrera, promedio);

			boolean exito = estudianteDAO.insertarEstudiante(persona, estudiante);

			if (exito) {
				response.sendRedirect("listarEstudiantes");
				return;
			} else {
				request.setAttribute("mensaje", "Error al insertar el estudiante");
				request.setAttribute("tipo", "error");
			}

		} catch (NumberFormatException e) {
			request.setAttribute("mensaje", "Error en el formato de los datos numericos");
			request.setAttribute("tipo", "error");
		} catch (Exception e) {
			request.setAttribute("mensaje", "Error: " + e.getMessage());
			request.setAttribute("tipo", "error");
		}

		request.getRequestDispatcher("/insertar.jsp").forward(request, response);
	}
}
