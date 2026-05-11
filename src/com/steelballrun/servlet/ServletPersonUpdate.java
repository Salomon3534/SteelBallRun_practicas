package com.steelballrun.servlet;

import com.steelballrun.dao.PersonDAO;
import com.steelballrun.model.Person;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/modificarEstudiantes")
public class ServletPersonUpdate extends HttpServlet {

	private PersonDAO personDAO;

	@Override
	public void init() throws ServletException {
		personDAO = new PersonDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String idStr = request.getParameter("id");

		try {
			int id = Integer.parseInt(idStr);
			Person p = personDAO.getPersonByID(id);

			if (p != null) {
				request.setAttribute("person", p);
				request.getRequestDispatcher("/modifyPerson.jsp").forward(request, response);
			} else {
				request.setAttribute("message", "There was no found match for a person with the ID: " + id);
				request.setAttribute("type", "error");
				response.sendRedirect("listPersons");
			}

		} catch (NumberFormatException e) {
			response.sendRedirect("listPersons");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String surnames = request.getParameter("surnames");
		String age = request.getParameter("age");
		String dni = request.getParameter("dni");

		try {
			int parsedId = Integer.parseInt(id);
			int parsedAge = Integer.parseInt(age);

			Person p = new Person(parsedId, name, surnames, parsedAge, dni);

			boolean exito = personDAO.updatePerson(p);

			if (exito) {
				response.sendRedirect("listPersons");
			} else {
				request.setAttribute("message", "Error when updating the person with ID: " + id);
				request.setAttribute("type", "error");
				request.setAttribute("person", p);
				request.getRequestDispatcher("/modifyPerson.jsp").forward(request, response);
			}

		} catch (NumberFormatException e) {
			request.setAttribute("message", "Error in the number's format");
			request.setAttribute("type", "error");
			request.getRequestDispatcher("/modifyPerson.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("message", "Error: " + e.getMessage());
			request.setAttribute("type", "error");
			request.getRequestDispatcher("/modifyPerson.jsp").forward(request, response);
		}
	}
}
