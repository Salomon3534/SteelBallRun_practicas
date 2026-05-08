package com.steelballrunrace.servlet;

import com.steelballrunrace.dao.EstudianteDAO;
import com.steelballrunrace.model.Estudiante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/listarEstudiantes")
public class ListarEstudiantesServlet extends HttpServlet {

    private EstudianteDAO estudianteDAO;

    @Override
    public void init() throws ServletException {
        estudianteDAO = new EstudianteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        List<Estudiante> listaEstudiantes = estudianteDAO.listarEstudiantes();
        request.setAttribute("listaEstudiantes", listaEstudiantes);

        request.getRequestDispatcher("/listar.jsp").forward(request, response);
    }
}
