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
    <title>Steel Ball Run</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body max-width="100%" crop-to-fit="cover">

    <!-- Banner principal -->
    <div class="main-banner">
        <a class="btn-register btn" href="inscryption.jsp">Registrarse</a>
        <img class="banner-logo" src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo">
    </div>

    <!-- Header -->
    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="corredores.jsp">Corredores</a></li>
                <li><a href="etapas.jsp">Etapas</a></li>
                <li><a href="acerca.jsp">Acerca de</a></li>
                <li><a href="patrocinadores.jsp">Patrocinadores</a></li>
                <li><a href="login.jsp">Iniciar sesion</a></li>
            </ul>
        </nav>
    </header>

    <!-- Tabla de Corredores -->
    <h2>Corredores</h2>
   <% if (request.getAttribute("message") != null) { %>
        <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("message") %>
        </p>
    <% } %>

    <% if (listRunners != null && !listRunners.isEmpty()) { %>
        <table class="sbr-table">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Edad</th>
                <th>Nacionalidad</th>
                <th>Dorsal</th>
                <th>Puesto</th>
                <th>Puntos</th>
            </tr>
            <% for (Runner r : listRunners) { %>
                <tr>
                    <td><%= r.getId() %></td>
                    <td><%= r.getName() %></td>
                    <td><%= r.getSurnames() %></td>
                    <td><%= r.getAge() %></td>
                    <td><%= r.getNationality() %></td>
                    <td><%= r.getBib() %></td>
                    <td><%= r.getCurrentPlace() %></td>
                    <td><%= r.getTotalPoints() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p><strong>No hay corredores registrados.</strong></p>
    <% } %>

    <!-- Spacer decorativo -->
    <div class="spacer-big">
        <img class="assistants-table" src="assets/web_images/assistants.png" alt="Asistentes">
    </div>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>
</body>
</html>
