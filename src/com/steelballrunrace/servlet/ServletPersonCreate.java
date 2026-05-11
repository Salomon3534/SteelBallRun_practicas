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

		String id = request.getParameter("id");  // no estoy muy seguro de que pilla y por que
		String name = request.getParameter("nombre");
		String surnames = request.getParameter("apellidos");
		String age = request.getParameter("edad");
		String dni = request.getParameter("dni");
		

		try {
			int parsedId = Integer.parseInt(id);
			int parsedAge = Integer.parseInt(age);

			Person p = new Person(parsedId, name, surnames, parsedAge, dni);

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
