package com.steelballrun.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.steelballrun.dao.PersonDAO;

@SuppressWarnings("serial")
@WebServlet("/deletePerson")
public class ServletPersonDelete extends HttpServlet {

	private PersonDAO personDAO;

	@Override
	public void init() throws ServletException {
		personDAO = new PersonDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("id");

		try {
			int parsedId = Integer.parseInt(id);
			personDAO.deletePerson(parsedId);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		response.sendRedirect("listPersons");
	}
}
