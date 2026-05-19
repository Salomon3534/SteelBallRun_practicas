package com.steelballrun.servlet;

import java.io.IOException;
import java.util.List;

import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.dao.SponsorDAO;
import com.steelballrun.model.Runner;
import com.steelballrun.model.Sponsor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sponsors")
public class ServletSponsorsLoad extends HttpServlet {

    private SponsorDAO sponsorDAO;

    @Override
    public void init() throws ServletException {
        sponsorDAO = new SponsorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            //obtener la lista de los sponsors desde el DAO
            List<Sponsor> listSponsors = sponsorDAO.listSponsors();

            //adjuntar la lista a la petición con la clave "listSponsors"
            request.setAttribute("listSponsors", listSponsors);

        } catch (Exception e) {
            request.setAttribute("message", "Error al cargar los patrocinadores: " + e.getMessage());
            request.setAttribute("type", "error");
        }

        //despachar el control a la vista
        request.getRequestDispatcher("/sponsors.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //procesar formularios aquí si es necesario
    }
}