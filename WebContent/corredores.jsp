<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.steelballrun.model.Runner" %>
<%@ page import="com.steelballrun.dao.RunnerDAO" %>
<%
    // Recupera la lista desde el request (si viene de un Servlet) o la consulta directamente a la BBDD
    List<Runner> listRunners = (List<Runner>) request.getAttribute("listRunners");
    if (listRunners == null) {
        RunnerDAO runnerDAO = new RunnerDAO();
        listRunners = runnerDAO.listRunners();
        request.setAttribute("listRunners", listRunners);
    }

    // Mapas para gestionar las etiquetas y clases de los estados dinámicamente
    Map<String, String> statusLabel = new HashMap<>();
    statusLabel.put("active", "En carrera");
    statusLabel.put("dq", "Descalificado");
    statusLabel.put("retired", "Retirado");

    Map<String, String> statusBadge = new HashMap<>();
    statusBadge.put("active", "badge-active");
    statusBadge.put("dq", "badge-dq");
    statusBadge.put("retired", "badge-retired");
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
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="corredores.jsp" style="text-decoration:underline">Corredores</a></li>
                <li><a href="etapas.jsp">Etapas</a></li>
                <li><a href="patrocinadores.jsp">Patrocinadores</a></li>
                <li><a href="acerca.jsp">Acerca de</a></li>
                <li id="session-nav-item"><a href="admin_login.html" id="session-btn">Iniciar sesion</a></li>
            </ul>
        </nav>
    </header>

    <main class="runners-page">
        <h1>Corredores</h1>
        <div class="runners-grid" id="runnersGrid">
            <% if (listRunners != null && !listRunners.isEmpty()) { %>
                <% for (Runner r : listRunners) { %>
                    <div class="runner-card">
                        <div class="runner-img-container">
                            <img src="../_SOURCE/characters/<%= r.getName%>.webp" alt="<%= r.getName() %>">
                        </div>
                        <div class="runner-stats">
                            <h3><%= r.getName() %> <%= r.getSurname() %> #<%= r.getNum() %></h3>
                            <div class="runner-meta">
                                <span><strong>Origen:</strong> <%= r.getNationality() %></span>
                                <span><strong>Montura:</strong> <%= r.getMountId %></span>
                            </div>
                            <span class="runner-badge <%= statusBadge.getOrDefault(r.getStatus(), "badge-retired") %>">
                                <%= statusLabel.getOrDefault(r.getStatus(), "Desconocido") %>
                            </span>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <p>No se encontraron corredores en la base de datos.</p>
            <% } %>
        </div>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
    </footer>
</body>

</html>