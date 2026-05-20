package com.steelballrun.servlet;

import java.io.IOException;
import java.util.*;
import com.steelballrun.dao.MountDAO;
import com.steelballrun.dao.PersonDAO;
import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Mount;
import com.steelballrun.model.Person;
import com.steelballrun.model.Runner;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/runners")
public class ServletRunnersLoad extends HttpServlet {

    private RunnerDAO runnerDAO;
    private PersonDAO personDAO;
    private MountDAO mountDAO;

    @Override
    public void init() {
        runnerDAO = new RunnerDAO();
        personDAO = new PersonDAO();
        mountDAO  = new MountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        List<Runner> runners = runnerDAO.listRunners();
        Map<Integer, Person> personMap = new HashMap<>();
        Map<Integer, Mount>  mountMap  = new HashMap<>();
        for (Runner r : runners) {
            if (!personMap.containsKey(r.getIdPerson())) {
                Person p = personDAO.getPersonByID(r.getIdPerson());
                if (p != null) personMap.put(r.getIdPerson(), p);
            }
            if (!mountMap.containsKey(r.getIdMount())) {
                Mount m = mountDAO.getMountByID(r.getIdMount());
                if (m != null) mountMap.put(r.getIdMount(), m);
            }
        }
        req.setAttribute("runners",   runners);
        req.setAttribute("personMap", personMap);
        req.setAttribute("mountMap",  mountMap);
        req.getRequestDispatcher("/runners.jsp").forward(req, res);
    }
}
