package com.steelballrun.servlet;

import com.steelballrun.dao.PersonDAO;
import com.steelballrun.model.Person;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/insertCharacter")
public class ServletPersonCreate extends HttpServlet {

    private PersonDAO personDAO;

    @Override
    public void init() throws ServletException {
        personDAO = new PersonDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name     = request.getParameter("name");
        String surnames = request.getParameter("surnames");
        String age      = request.getParameter("age");
        String dni      = request.getParameter("dni");

        try {
            int parsedAge = Integer.parseInt(age);

            // person.id es PK sin AUTO_INCREMENT: lo calculamos
            int nextId = personDAO.getNextId();

            Person p = new Person(nextId, name, surnames, parsedAge, dni);
            boolean success = personDAO.insertPerson(p);

            if (success) {
                response.sendRedirect("listRunners");
                return;
            } else {
                request.setAttribute("message", "Error al insertar la persona");
                request.setAttribute("type", "error");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error en el formato del número");
            request.setAttribute("type", "error");
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("type", "error");
        }

        request.getRequestDispatcher("/insertRunner.jsp").forward(request, response);
    }
}
