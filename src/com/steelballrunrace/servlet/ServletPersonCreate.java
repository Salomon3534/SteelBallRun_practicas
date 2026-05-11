package com.steelballrunrace.servlet;

import com.steelballrunrace.dao.PersonDAO;
import com.steelballrunrace.model.Person;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/insertCharacter")
public class ServletPersonCreate extends HttpServlet {

	private PersonDAO personDAO;

	@Override
	public void init() throws ServletException {
		personDAO = new PersonDAO();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String name = request.getParameter("name");
		String surnames = request.getParameter("surnames");
		String age = request.getParameter("age");
		String dni = request.getParameter("dni");
		

		try {
			int parsedAge = Integer.parseInt(age);

			// ID is auto-incremental in database, use 0 as placeholder
			Person p = new Person(0, name, surnames, parsedAge, dni);

			boolean success = personDAO.insertPerson(p);

			if (success) {
				response.sendRedirect("listPersons");
				return;
			} else {
				request.setAttribute("message", "Error when inserting a new person");
				request.setAttribute("type", "error");
			}

		} catch (NumberFormatException e) {
			request.setAttribute("message", "Error in the number's format");
			request.setAttribute("type", "error");
		} catch (Exception e) {
			request.setAttribute("message", "Error: " + e.getMessage());
			request.setAttribute("type", "error");
		}

		request.getRequestDispatcher("/insertPerson.jsp").forward(request, response);
	}
}
