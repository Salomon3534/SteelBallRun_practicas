package com.steelballrunrace.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.steelballrunrace.dao.PersonDAO;

@WebServlet("/borrarEstudiante")
public class ServletCharacterDelete extends HttpServlet {

	private PersonDAO estudianteDAO;

	@Override
	public void init() throws ServletException {
		estudianteDAO = new PersonDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idStr = request.getParameter("id");

		try {
			int id = Integer.parseInt(idStr);
			estudianteDAO.eliminarEstudiante(id);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		response.sendRedirect("listarEstudiantes");
	}
}
