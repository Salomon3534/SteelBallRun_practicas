package com.steelballrun.servlet;

import java.io.IOException;
import java.util.List;

import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Runner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/listRunners")
public class ServletRunnerList extends HttpServlet {

	private RunnerDAO runnerDAO;

	@Override
	public void init() throws ServletException {
		runnerDAO = new RunnerDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		List<Runner> listRunners = runnerDAO.listRunners();
		request.setAttribute("listRunners", listRunners);

		request.getRequestDispatcher("/listRunners.jsp").forward(request, response);
	}
}
