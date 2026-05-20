package com.steelballrun.servlet;

import java.io.IOException;
import com.steelballrun.dao.UserDAO;
import com.steelballrun.model.User;
import com.steelballrun.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/login")
public class ServletLogin extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() { userDAO = new UserDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // If already logged in, redirect appropriately
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            User u = (User) session.getAttribute("loggedUser");
            res.sendRedirect(req.getContextPath() +
                    ("admin".equals(u.getRole()) ? "/admin" : "/profile"));
            return;
        }
        req.getRequestDispatcher("/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String passkey  = req.getParameter("passkey");

        if (isBlank(username) || isBlank(passkey)) {
            req.setAttribute("error", "Por favor rellena todos los campos.");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        String hash = AuthUtil.sha256(passkey.trim());
        User user = userDAO.findByCredentials(username.trim(), hash);

        if (user == null) {
            req.setAttribute("error", "Usuario o passkey incorrectos.");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("loggedUser", user);
        session.setMaxInactiveInterval(60 * 60); // 1 hour

        String redirect = "admin".equals(user.getRole()) ? "/admin" : "/profile";
        res.sendRedirect(req.getContextPath() + redirect);
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
