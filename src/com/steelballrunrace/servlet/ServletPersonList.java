package com.steelballrunrace.servlet;

import com.steelballrunrace.dao.PersonDAO;
import com.steelballrunrace.model.Person;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/listPersons")
public class ServletPersonList extends HttpServlet {

	private PersonDAO personDAO;

	@Override
	public void init() throws ServletException {
		personDAO = new PersonDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		List<Person> listPersons = personDAO.listPersons();
		request.setAttribute("listPersons", listPersons);

		request.getRequestDispatcher("/listPersons.jsp").forward(request, response);
	}
}
