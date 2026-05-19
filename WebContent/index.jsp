<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.steelballrun.model.Runner" %>
<%
    //recuperamos la lista de corredores del alcance de la solicitud
    List<Runner> listRunnersTop = (List<Runner>) request.getAttribute("listRunnersTop");
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

    <div class="main-banner">
        <a class="btn-register btn" href="inscryption.jsp">Registrarse</a>
        <img class="banner-logo" src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo">
    </div>

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

    <h2>Top <%= (listRunnersTop != null) ? listRunnersTop.size() : 0 %></h2>
    
    <% if (request.getAttribute("message") != null) { %>
        <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
            ${message}
        </p>
    <% } %>

    <% if (listRunnersTop != null && !listRunnersTop.isEmpty()) { %>
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
            <% for (Runner r : listRunnersTop) { 
                pageContext.setAttribute("r", r); 
            %>
                <tr>
                    <td>${r.id}</td>
                    <td>${r.name}</td>
                    <td>${r.surnames}</td>
                    <td>${r.age}</td>
                    <td>${r.nationality}</td>
                    <td>${r.bib}</td>
                    <td>${r.currentPlace}</td>
                    <td>${r.totalPoints}</td>
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