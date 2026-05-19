package com.steelballrun.servlet;

import java.io.IOException;
import java.util.List;

import com.steelballrun.dao.MountDAO;
import com.steelballrun.dao.PersonDAO;
import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Runner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/inscription")
public class ServletInscription extends HttpServlet {

    private RunnerDAO runnerDAO;
    private PersonDAO personDAO;
    private MountDAO mountDAO;

    @Override
    public void init() throws ServletException {
        runnerDAO = new RunnerDAO();
        personDAO = new PersonDAO();
        mountDAO = new MountDAO();
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //procesar formularios aquí si es necesario
    }
}