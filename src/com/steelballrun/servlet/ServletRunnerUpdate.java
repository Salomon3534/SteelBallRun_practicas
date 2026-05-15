package com.steelballrun.servlet;

import java.io.IOException;

import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Runner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/modifyRunner")
public class ServletRunnerUpdate extends HttpServlet {

	private RunnerDAO runnerDAO;

	@Override
	public void init() throws ServletException {
		runnerDAO = new RunnerDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String idStr = request.getParameter("id");

		try {
			int id = Integer.parseInt(idStr);
			Runner runner = runnerDAO.getRunnerByID(id);

			if (runner != null) {
				request.setAttribute("runner", runner);
				request.getRequestDispatcher("/modifyRunner.jsp").forward(request, response);
			} else {
				request.setAttribute("message", "There was no found match for a runner with the ID: " + id);
				request.setAttribute("type", "error");
				response.sendRedirect("listRunners");
			}

		} catch (NumberFormatException e) {
			response.sendRedirect("listRunners");
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
		String nationality = request.getParameter("nationality");
		String mountId = request.getParameter("mountId");
		String currentPlace = request.getParameter("currentPlace");
		String totalPoints = request.getParameter("totalPoints");

		try {
			int parsedId = Integer.parseInt(id);
			int parsedAge = Integer.parseInt(age);
			int parsedMountId = Integer.parseInt(mountId);
			int parsedCurrentPlace = Integer.parseInt(currentPlace);
			int parsedTotalPoints = Integer.parseInt(totalPoints);

			Runner runner = new Runner(parsedId, name, surnames, parsedAge, nationality, parsedMountId, 0, parsedCurrentPlace, parsedTotalPoints);

			boolean success = runnerDAO.updateRunner(runner);

			if (success) {
				response.sendRedirect("listRunners");
			} else {
				request.setAttribute("message", "Error when updating the runner with ID: " + id);
				request.setAttribute("type", "error");
				request.setAttribute("runner", runner);
				request.getRequestDispatcher("/modifyRunner.jsp").forward(request, response);
			}

		} catch (NumberFormatException e) {
			request.setAttribute("message", "Error in the number's format");
			request.setAttribute("type", "error");
			request.getRequestDispatcher("/modifyRunner.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("message", "Error: " + e.getMessage());
			request.setAttribute("type", "error");
			request.getRequestDispatcher("/modifyRunner.jsp").forward(request, response);
		}
	}
}
