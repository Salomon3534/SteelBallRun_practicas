package com.steelballrun.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import com.steelballrun.dao.*;
import com.steelballrun.model.*;
import com.steelballrun.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/register")
public class ServletRegister extends HttpServlet {

    private RunnerDAO runnerDAO;
    private PersonDAO personDAO;
    private MountDAO  mountDAO;
    private StageDAO  stageDAO;

    @Override
    public void init() {
        runnerDAO = new RunnerDAO();
        personDAO = new PersonDAO();
        mountDAO  = new MountDAO();
        stageDAO  = new StageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        loadData(req);
        req.getRequestDispatcher("/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String bibStr     = req.getParameter("runner-bib");
        String stageIdStr = req.getParameter("stage-id");

        if (isBlank(bibStr) || isBlank(stageIdStr)) {
            error(req, "Debes seleccionar un corredor y una etapa.");
            forward(req, res); return;
        }

        int bib, stageId;
        try {
            bib     = Integer.parseInt(bibStr);
            stageId = Integer.parseInt(stageIdStr);
        } catch (NumberFormatException e) {
            error(req, "Valores inválidos."); forward(req, res); return;
        }

        Runner runner = runnerDAO.getRunnerByBib(bib);
        Stage  stage  = stageDAO.getStageByID(stageId);

        if (runner == null) { error(req, "Corredor no encontrado."); forward(req, res); return; }
        if (stage  == null) { error(req, "Etapa no encontrada.");    forward(req, res); return; }
        if (stage.isCompleted()) { error(req, "La etapa ya está completada."); forward(req, res); return; }
        if (runner.getIdStage() != null && runner.getIdStage() == stageId) {
            error(req, "El corredor ya está inscrito en esa etapa."); forward(req, res); return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE runner SET id_stage = ? WHERE bib = ?")) {
            ps.setInt(1, stageId);
            ps.setInt(2, bib);
            ps.executeUpdate();
            req.setAttribute("message", "¡Corredor #" + bib + " inscrito en \"" + stage.getName() + "\" correctamente!");
            req.setAttribute("type", "success");
        } catch (SQLException e) {
            error(req, "Error en la base de datos: " + e.getMessage());
        }

        forward(req, res);
    }

    private void loadData(HttpServletRequest req) {
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
        req.setAttribute("stages",    stageDAO.listStages());
    }

    private void error(HttpServletRequest req, String msg) {
        req.setAttribute("message", msg);
        req.setAttribute("type", "error");
    }

    private void forward(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        loadData(req);
        req.getRequestDispatcher("/register.jsp").forward(req, res);
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
