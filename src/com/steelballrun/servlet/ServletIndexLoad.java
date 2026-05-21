package com.steelballrun.servlet;

import java.io.IOException;
import java.util.*;
import com.steelballrun.dao.PersonDAO;
import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Person;
import com.steelballrun.model.Runner;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/index")
public class ServletIndexLoad extends HttpServlet {

	private RunnerDAO runnerDAO;
	private PersonDAO personDAO;

	@Override
	public void init() {
		runnerDAO = new RunnerDAO();
		personDAO = new PersonDAO();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		List<Runner> top = runnerDAO.listRunnersTop(25);

		// listar personajes de los corredores
		Map<Integer, Person> personMap = new HashMap<>();
		for (Runner r : top) {
			if (!personMap.containsKey(r.getIdPerson())) {
				Person p = personDAO.getPersonByID(r.getIdPerson());
				if (p != null)
					personMap.put(r.getIdPerson(), p);
			}
		}
		req.setAttribute("listRunnersTop", top);
		req.setAttribute("personMap", personMap);
		req.getRequestDispatcher("/index.jsp").forward(req, res);
	}
}
