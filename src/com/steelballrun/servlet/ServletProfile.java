package com.steelballrun.servlet;

import java.io.IOException;
import com.steelballrun.dao.MountDAO;
import com.steelballrun.dao.PersonDAO;
import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.model.Mount;
import com.steelballrun.model.Person;
import com.steelballrun.model.Runner;
import com.steelballrun.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/profile")
public class ServletProfile extends HttpServlet {

    private RunnerDAO runnerDAO;
    private PersonDAO personDAO;
    private MountDAO  mountDAO;

    @Override
    public void init() {
        runnerDAO = new RunnerDAO();
        personDAO = new PersonDAO();
        mountDAO  = new MountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        req.setAttribute("loggedUser", user);

        if ("user".equals(user.getRole()) && user.getRunnerId() != null) {
            Runner runner = runnerDAO.getRunnerByBib(user.getRunnerId());
            if (runner != null) {
                req.setAttribute("runner", runner);
                Person person = personDAO.getPersonByID(runner.getIdPerson());
                req.setAttribute("person", person);
                Mount mount = mountDAO.getMountByID(runner.getIdMount());
                req.setAttribute("mount", mount);

                // Calculate ranking
                java.util.List<Runner> all = runnerDAO.listRunnersTop(9999);
                int rank = 1;
                for (Runner r : all) {
                    if (r.getBib() == runner.getBib()) break;
                    rank++;
                }
                req.setAttribute("rank", rank);
                req.setAttribute("totalRunners", all.size());
            }
        }

        req.getRequestDispatcher("/profile.jsp").forward(req, res);
    }
}
