package com.steelballrun.servlet;

import java.io.IOException;
import com.steelballrun.dao.StageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/stages")
public class ServletStagesLoad extends HttpServlet {

    private StageDAO stageDAO;

    @Override
    public void init() {
        stageDAO = new StageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        req.setAttribute("stages", stageDAO.listStages());
        req.getRequestDispatcher("/stages.jsp").forward(req, res);
    }
}
