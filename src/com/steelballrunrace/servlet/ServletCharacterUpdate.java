package com.steelballrunrace.servlet;

import com.steelballrunrace.dao.EstudianteDAO;
import com.steelballrunrace.model.Estudiante;
import com.steelballrunrace.model.Persona;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/modificarEstudiantes")
public class ServletCharacterUpdate extends HttpServlet {

	private EstudianteDAO estudianteDAO;

	@Override
	public void init() throws ServletException {
		estudianteDAO = new EstudianteDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String idStr = request.getParameter("id");

		try {
			int id = Integer.parseInt(idStr);
			Estudiante estudiante = estudianteDAO.obtenerEstudiantePorId(id);

			if (estudiante != null) {
				request.setAttribute("estudiante", estudiante);
				request.getRequestDispatcher("/modificar.jsp").forward(request, response);
			} else {
				request.setAttribute("mensaje", "No se encontró el estudiante con ID: " + id);
				request.setAttribute("tipo", "error");
				response.sendRedirect("listarEstudiantes");
			}

		} catch (NumberFormatException e) {
			response.sendRedirect("listarEstudiantes");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String idStr = request.getParameter("id");
		String nombre = request.getParameter("nombre");
		String edadStr = request.getParameter("edad");
		String dni = request.getParameter("dni");
		String carrera = request.getParameter("carrera");
		String promedioStr = request.getParameter("promedio");

		try {
			int id = Integer.parseInt(idStr);
			int edad = Integer.parseInt(edadStr);
			double promedio = Double.parseDouble(promedioStr);

			Persona persona = new Persona(id, nombre, edad, dni);
			Estudiante estudiante = new Estudiante(id, carrera, promedio);
			estudiante.setPersona(persona);

			boolean exito = estudianteDAO.actualizarEstudiante(persona, estudiante);

			if (exito) {
				response.sendRedirect("listarEstudiantes");
			} else {
				request.setAttribute("mensaje", "Error al modificar el estudiante");
				request.setAttribute("tipo", "error");
				request.setAttribute("estudiante", estudiante);
				request.getRequestDispatcher("/modificar.jsp").forward(request, response);
			}

		} catch (NumberFormatException e) {
			request.setAttribute("mensaje", "Error en el formato de los datos numéricos");
			request.setAttribute("tipo", "error");
			request.getRequestDispatcher("/modificar.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("mensaje", "Error: " + e.getMessage());
			request.setAttribute("tipo", "error");
			request.getRequestDispatcher("/modificar.jsp").forward(request, response);
		}
	}
}
