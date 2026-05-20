package com.steelballrun.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.*;
import com.steelballrun.dao.*;
import com.steelballrun.model.*;
import com.steelballrun.util.AuthUtil;
import com.steelballrun.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/admin")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class ServletAdmin extends HttpServlet {

    private RunnerDAO  runnerDAO;
    private PersonDAO  personDAO;
    private MountDAO   mountDAO;
    private SponsorDAO sponsorDAO;
    private StageDAO   stageDAO;
    private UserDAO    userDAO;

    @Override
    public void init() {
        runnerDAO  = new RunnerDAO();
        personDAO  = new PersonDAO();
        mountDAO   = new MountDAO();
        sponsorDAO = new SponsorDAO();
        stageDAO   = new StageDAO();
        userDAO    = new UserDAO();
    }

    /* ── Guard ───────────────────────────────────────────── */
    private boolean requireAdmin(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("loggedUser") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        User u = (User) s.getAttribute("loggedUser");
        if (!"admin".equals(u.getRole())) {
            res.sendRedirect(req.getContextPath() + "/index");
            return false;
        }
        return true;
    }

    /* ── GET — load admin panel ──────────────────────────── */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!requireAdmin(req, res)) return;

        loadAllData(req);
        req.getRequestDispatcher("/admin.jsp").forward(req, res);
    }

    /* ── POST — dispatch by action ──────────────────────── */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!requireAdmin(req, res)) return;
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String entity = req.getParameter("entity");

        try {
            if      ("runner".equals(entity))    handleRunner(action, req, res);
            else if ("person".equals(entity))    handlePerson(action, req, res);
            else if ("mount".equals(entity))     handleMount(action, req, res);
            else if ("sponsor".equals(entity))   handleSponsor(action, req, res);
            else if ("user".equals(entity))      handleUser(action, req, res);
        } catch (Exception e) {
            req.setAttribute("adminError", "Error: " + e.getMessage());
        }

        loadAllData(req);
        req.getRequestDispatcher("/admin.jsp").forward(req, res);
    }

    /* ── Data loaders ───────────────────────────────────── */
    private void loadAllData(HttpServletRequest req) {
        req.setAttribute("runners",  runnerDAO.listRunners());
        req.setAttribute("persons",  personDAO.listPersons());
        req.setAttribute("mounts",   mountDAO.listMounts());
        req.setAttribute("sponsors", sponsorDAO.listSponsors());
        req.setAttribute("stages",   stageDAO.listStages());
        req.setAttribute("users",    userDAO.listAll());

        // Build personMap for runner table
        Map<Integer, Person> pm = new HashMap<>();
        for (Person p : personDAO.listPersons()) pm.put(p.getId(), p);
        req.setAttribute("personMap", pm);
        Map<Integer, Mount> mm = new HashMap<>();
        for (Mount m : mountDAO.listMounts()) mm.put(m.getId(), m);
        req.setAttribute("mountMap", mm);
    }

    /* ── Runner CRUD ────────────────────────────────────── */
    private void handleRunner(String action, HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        switch (action) {
            case "create": {
                int personId  = Integer.parseInt(req.getParameter("r_personId"));
                int mountId   = Integer.parseInt(req.getParameter("r_mountId"));
                int points    = Integer.parseInt(req.getParameter("r_points"));
                int km        = Integer.parseInt(req.getParameter("r_km"));
                String stageS = req.getParameter("r_stage");
                Integer stageId = (stageS != null && !stageS.isEmpty()) ? Integer.parseInt(stageS) : null;

                byte[] img = null;
                Part fp = req.getPart("r_image");
                if (fp != null && fp.getSize() > 0) {
                    try (InputStream is = fp.getInputStream()) { img = is.readAllBytes(); }
                }

                String passkey = java.util.UUID.randomUUID().toString();
                Runner r = new Runner();
                r.setIdPerson(personId); r.setIdMount(mountId);
                r.setPoints(points); r.setKm(km); r.setIdStage(stageId);
                r.setImage(img); r.setPasskey(passkey);

                try (Connection conn = DatabaseConnection.getConnection()) {
                    conn.setAutoCommit(false);
                    runnerDAO.insertRunner(r, conn);

                    // create user for this runner
                    Person p = personDAO.getPersonByID(personId);
                    String username = (p != null ? p.getName().toLowerCase().replaceAll("\\s+","_") : "runner") + "_" + System.currentTimeMillis() % 10000;
                    User u = new User(0, username, AuthUtil.sha256(passkey), "user", null);
                    conn.commit();

                    // get bib of inserted runner
                    List<Runner> all = runnerDAO.listRunners();
                    int bib = all.isEmpty() ? -1 : all.get(all.size()-1).getBib();
                    u.setRunnerId(bib);
                    userDAO.insert(u);
                }
                req.setAttribute("adminMsg", "Corredor creado. Passkey: " + passkey);
                break;
            }
            case "update": {
                int bib    = Integer.parseInt(req.getParameter("r_bib"));
                int points = Integer.parseInt(req.getParameter("r_points"));
                int km     = Integer.parseInt(req.getParameter("r_km"));
                String stageS = req.getParameter("r_stage");
                Integer stageId = (stageS != null && !stageS.isEmpty()) ? Integer.parseInt(stageS) : null;

                Runner existing = runnerDAO.getRunnerByBib(bib);
                if (existing != null) {
                    existing.setPoints(points);
                    existing.setKm(km);
                    existing.setIdStage(stageId);

                    Part fp = req.getPart("r_image");
                    if (fp != null && fp.getSize() > 0) {
                        try (InputStream is = fp.getInputStream()) { existing.setImage(is.readAllBytes()); }
                    }
                    runnerDAO.updateRunner(existing);
                }
                req.setAttribute("adminMsg", "Corredor actualizado.");
                break;
            }
            case "delete": {
                int bib = Integer.parseInt(req.getParameter("r_bib"));
                runnerDAO.deleteRunner(bib);
                req.setAttribute("adminMsg", "Corredor eliminado.");
                break;
            }
        }
    }

    /* ── Person CRUD ────────────────────────────────────── */
    private void handlePerson(String action, HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        switch (action) {
            case "create": {
                String name    = req.getParameter("p_name");
                int age        = Integer.parseInt(req.getParameter("p_age"));
                String country = req.getParameter("p_country");
                String dni     = req.getParameter("p_dni");
                try (Connection conn = DatabaseConnection.getConnection()) {
                    conn.setAutoCommit(true);
                    personDAO.insertPersonAndGetId(new Person(0, name, age, country, dni), conn);
                }
                req.setAttribute("adminMsg", "Persona creada.");
                break;
            }
            case "update": {
                int id         = Integer.parseInt(req.getParameter("p_id"));
                String name    = req.getParameter("p_name");
                int age        = Integer.parseInt(req.getParameter("p_age"));
                String country = req.getParameter("p_country");
                String dni     = req.getParameter("p_dni");
                try (Connection conn = DatabaseConnection.getConnection();
                     java.sql.PreparedStatement ps = conn.prepareStatement(
                         "UPDATE person SET name=?,age=?,country=?,dni=? WHERE id=?")) {
                    ps.setString(1,name); ps.setInt(2,age);
                    ps.setString(3,country); ps.setString(4,dni); ps.setInt(5,id);
                    ps.executeUpdate();
                }
                req.setAttribute("adminMsg", "Persona actualizada.");
                break;
            }
            case "delete": {
                int id = Integer.parseInt(req.getParameter("p_id"));
                try (Connection conn = DatabaseConnection.getConnection();
                     java.sql.PreparedStatement ps = conn.prepareStatement("DELETE FROM person WHERE id=?")) {
                    ps.setInt(1, id); ps.executeUpdate();
                }
                req.setAttribute("adminMsg", "Persona eliminada.");
                break;
            }
        }
    }

    /* ── Mount CRUD ─────────────────────────────────────── */
    private void handleMount(String action, HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        switch (action) {
            case "create": {
                String name = req.getParameter("m_name");
                String type = req.getParameter("m_type");
                try (Connection conn = DatabaseConnection.getConnection()) {
                    conn.setAutoCommit(true);
                    mountDAO.insertMountAndGetId(new Mount(0, name, type), conn);
                }
                req.setAttribute("adminMsg", "Montura creada.");
                break;
            }
            case "update": {
                int id      = Integer.parseInt(req.getParameter("m_id"));
                String name = req.getParameter("m_name");
                String type = req.getParameter("m_type");
                try (Connection conn = DatabaseConnection.getConnection();
                     java.sql.PreparedStatement ps = conn.prepareStatement(
                         "UPDATE mount SET name=?,type=? WHERE id=?")) {
                    ps.setString(1,name); ps.setString(2,type); ps.setInt(3,id);
                    ps.executeUpdate();
                }
                req.setAttribute("adminMsg", "Montura actualizada.");
                break;
            }
            case "delete": {
                int id = Integer.parseInt(req.getParameter("m_id"));
                try (Connection conn = DatabaseConnection.getConnection();
                     java.sql.PreparedStatement ps = conn.prepareStatement("DELETE FROM mount WHERE id=?")) {
                    ps.setInt(1,id); ps.executeUpdate();
                }
                req.setAttribute("adminMsg", "Montura eliminada.");
                break;
            }
        }
    }

    /* ── Sponsor CRUD ───────────────────────────────────── */
    private void handleSponsor(String action, HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        switch (action) {
            case "create":
                sponsorDAO.insertSponsor(new Sponsor(0, req.getParameter("sp_name")));
                req.setAttribute("adminMsg", "Patrocinador creado.");
                break;
            case "update":
                sponsorDAO.updateSponsor(new Sponsor(
                    Integer.parseInt(req.getParameter("sp_id")), req.getParameter("sp_name")));
                req.setAttribute("adminMsg", "Patrocinador actualizado.");
                break;
            case "delete":
                sponsorDAO.deleteSponsor(Integer.parseInt(req.getParameter("sp_id")));
                req.setAttribute("adminMsg", "Patrocinador eliminado.");
                break;
        }
    }

    /* ── User CRUD ──────────────────────────────────────── */
    private void handleUser(String action, HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        switch (action) {
            case "create": {
                String username = req.getParameter("u_username");
                String passkey  = req.getParameter("u_passkey");
                String role     = req.getParameter("u_role");
                String runnerS  = req.getParameter("u_runnerId");
                Integer runnerId = (runnerS != null && !runnerS.isEmpty()) ? Integer.parseInt(runnerS) : null;
                User u = new User(0, username, AuthUtil.sha256(passkey), role, runnerId);
                userDAO.insert(u);
                req.setAttribute("adminMsg", "Usuario creado.");
                break;
            }
            case "update": {
                int id          = Integer.parseInt(req.getParameter("u_id"));
                String username = req.getParameter("u_username");
                String role     = req.getParameter("u_role");
                String runnerS  = req.getParameter("u_runnerId");
                Integer runnerId = (runnerS != null && !runnerS.isEmpty()) ? Integer.parseInt(runnerS) : null;
                String newPass  = req.getParameter("u_passkey");
                // Load existing to preserve hash if no new pass
                User existing = userDAO.listAll().stream().filter(u -> u.getId() == id).findFirst().orElse(null);
                if (existing != null) {
                    existing.setUsername(username);
                    existing.setRole(role);
                    existing.setRunnerId(runnerId);
                    if (newPass != null && !newPass.trim().isEmpty())
                        existing.setPasskey(AuthUtil.sha256(newPass.trim()));
                    userDAO.update(existing);
                }
                req.setAttribute("adminMsg", "Usuario actualizado.");
                break;
            }
            case "delete": {
                int id = Integer.parseInt(req.getParameter("u_id"));
                userDAO.delete(id);
                req.setAttribute("adminMsg", "Usuario eliminado.");
                break;
            }
        }
    }
}
