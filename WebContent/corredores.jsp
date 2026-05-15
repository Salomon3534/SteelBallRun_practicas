<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.steelballrun.model.Runner" %>
<%@ page import="com.steelballrun.dao.RunnerDAO" %>
<%
    List<Runner> listRunners = (List<Runner>) request.getAttribute("listRunners");
    if (listRunners == null) {
        RunnerDAO runnerDAO = new RunnerDAO();
        listRunners = runnerDAO.listRunners();
        request.setAttribute("listRunners", listRunners);
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Corredores</title>
    <link rel="icon" type="image/png" href="../web_images/sbr_logo.png">
    <link rel="stylesheet" href="sbrstyles.css">
</head>

<body>
    <header class="main-header">
        <img src="../web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" style="height: 50px;">
        <nav>
            <ul>
                <li><a href="index.html">Inicio</a></li>
                <li><a href="corredores.html" style="text-decoration:underline">Corredores</a></li>
                <li><a href="etapas.html">Etapas</a></li>
                <li><a href="patrocinadores.html">Patrocinadores</a></li>
                <li><a href="acerca.html">Acerca de</a></li>
                <li id="session-nav-item"><a href="admin_login.html" id="session-btn">Iniciar sesion</a></li>
            </ul>
        </nav>
    </header>

    <main class="runners-page">
        <h1>Corredores</h1>
        <% if (request.getAttribute("message") != null) { %>
            <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
                <%= request.getAttribute("message") %>
            </p>
        <% } %>
        
        <% if (listRunners != null && !listRunners.isEmpty()) { %>
            <div class="runners-container">
                <% for (Runner r : listRunners) { %>
                    <div class="runner-card">
                        <div class="runner-img-container">
                            <img src="../web_images/characters/<%= r.getName() %>.webp" alt="<%= r.getName() %>">
                        </div>
                        <div class="runner-stats">
                            <h3>#<%= r.getNum() %> <%= r.getName() %> <%= r.getSurname() %></h3>
                            <div class="runner-meta">
                                <span><strong>Origen:</strong> <%= r.getOrigin() %></span>
                                <span><strong>Montura:</strong> <%= r.getHorse() %></span>
                                <span><strong>Última posición:</strong> <%= r.getLastPos() %></span>
                            </div>
                            <span class="runner-badge status-<%= r.getStatus() %>"><%= r.getStatus() %></span>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
    </footer>
</body>
</html>