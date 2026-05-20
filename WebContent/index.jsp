<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.steelballrun.model.Runner, com.steelballrun.model.Person, com.steelballrun.model.User" %>
<%
    List<Runner>         listRunnersTop = (List<Runner>)         request.getAttribute("listRunnersTop");
    Map<Integer, Person> personMap      = (Map<Integer, Person>) request.getAttribute("personMap");
    User loggedUser = (User) (session != null ? session.getAttribute("loggedUser") : null);
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
<body>
    <div class="main-banner">
        <% if (loggedUser == null) { %>
            <a class="btn-register btn" href="inscription">Registrarse</a>
        <% } %>
        <img class="banner-logo" src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo">
    </div>

    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="index">Inicio</a></li>
                <li><a href="about.jsp">Acerca de</a></li>
                <li><a href="runners">Corredores</a></li>
                <li><a href="sponsors">Patrocinadores</a></li>
                <li><a href="stages">Etapas</a></li>
                <% if (loggedUser != null) { %>
                    <li class="header-user-info">
                        <a href="<%= "admin".equals(loggedUser.getRole()) ? "admin" : "profile" %>" class="header-user-link">
                            <span class="header-user-name"><%= loggedUser.getUsername() %></span>
                        </a>
                    </li>
                    <li><a href="logout" class="btn btn-logout-nav">Cerrar sesión</a></li>
                <% } else { %>
                    <li><a href="login">Iniciar sesión</a></li>
                    <li><a href="inscription">Inscripción</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <h2>Top <%= listRunnersTop != null ? listRunnersTop.size() : 0 %></h2>

    <% if (request.getAttribute("message") != null) { %>
        <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("message") %>
        </p>
    <% } %>

    <% if (listRunnersTop != null && !listRunnersTop.isEmpty()) { %>
        <table class="sbr-table">
            <tr>
                <th>Dorsal</th><th>Nombre</th><th>País</th><th>Puntos</th><th>Km</th>
            </tr>
            <% for (Runner r : listRunnersTop) {
                Person p = personMap != null ? personMap.get(r.getIdPerson()) : null;
            %>
                <tr>
                    <td><%= r.getBib() %></td>
                    <td><%= p != null ? p.getName()    : "-" %></td>
                    <td><%= p != null ? p.getCountry() : "-" %></td>
                    <td><%= r.getPoints() != null ? r.getPoints() : 0 %></td>
                    <td><%= r.getKm()     != null ? r.getKm()     : 0 %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p><strong>No hay corredores registrados.</strong></p>
    <% } %>

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
