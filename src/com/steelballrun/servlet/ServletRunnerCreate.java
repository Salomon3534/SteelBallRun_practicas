package com.steelballrun.servlet;

import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Runner;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/insertRunner")
public class ServletRunnerCreate extends HttpServlet {

    private RunnerDAO runnerDAO;

    @Override
    public void init() throws ServletException {
        runnerDAO = new RunnerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name        = request.getParameter("name");
        String surnames    = request.getParameter("surnames");
        String age         = request.getParameter("age");
        String nationality = request.getParameter("nationality");
        String mountId     = request.getParameter("mountId");
        String currentPlace  = request.getParameter("currentPlace");
        String totalPoints   = request.getParameter("totalPoints");

        try {
            int parsedAge          = Integer.parseInt(age);
            int parsedMountId      = Integer.parseInt(mountId);
            int parsedCurrentPlace = Integer.parseInt(currentPlace);
            int parsedTotalPoints  = Integer.parseInt(totalPoints);

            // El ID de runner NO es AUTO_INCREMENT en la BD, lo calculamos aquí
            int nextId = runnerDAO.getNextId();

            // bib es AUTO_INCREMENT en la BD: se pasa 0 y la BD lo asigna
            Runner runner = new Runner(nextId, name, surnames, parsedAge, nationality,
                                       parsedMountId, 0, parsedCurrentPlace, parsedTotalPoints);

            boolean success = runnerDAO.insertRunner(runner);

            if (success) {
                response.sendRedirect("listRunners");
                return;
            } else {
                request.setAttribute("message", "Error al insertar el nuevo corredor");
                request.setAttribute("type", "error");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error en el formato de los números");
            request.setAttribute("type", "error");
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("type", "error");
        }

        request.getRequestDispatcher("/insertRunner.jsp").forward(request, response);
    }
}
