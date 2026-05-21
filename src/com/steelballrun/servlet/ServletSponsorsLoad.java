package com.steelballrun.servlet;

import java.io.IOException;
import com.steelballrun.dao.SponsorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/sponsors")
public class ServletSponsorsLoad extends HttpServlet {

	private SponsorDAO sponsorDAO;

	@Override
	public void init() {
		sponsorDAO = new SponsorDAO();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		req.setAttribute("listSponsors", sponsorDAO.listSponsors());
		req.getRequestDispatcher("/sponsors.jsp").forward(req, res);
	}
}
