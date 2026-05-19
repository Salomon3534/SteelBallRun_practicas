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

@WebServlet("/index")
public class ServletIndexLoad extends HttpServlet {

    private RunnerDAO runnerDAO;

    @Override
    public void init() throws ServletException {
        runnerDAO = new RunnerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            //obtener la lista de los 25 mejores desde el DAO
            List<Runner> listRunnersTop = runnerDAO.listRunnersTop(25);

            //adjuntar la lista a la petición con la clave "listRunnersTop"
            request.setAttribute("listRunnersTop", listRunnersTop);

        } catch (Exception e) {
            request.setAttribute("message", "Error al cargar los corredores: " + e.getMessage());
            request.setAttribute("type", "error");
        }

        //despachar el control a la vista
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //procesar formularios aquí si es necesario
    }
}