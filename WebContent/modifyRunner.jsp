<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.steelballrun.model.Runner" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Corredor</title>
    <link rel="stylesheet" href="sbrstyles.css">
</head>
<body>
    <!-- Banner principal -->
    <div class="main-banner">
        <a class="btn-register btn" href="inscryption.html">Registrarse</a>
        <img class="banner-logo" src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo">
    </div>

    <!-- Header -->
    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="listRunners">Corredores</a></li>
                <li><a href="etapas.jsp">Etapas</a></li>
                <li><a href="acerca.jsp">Acerca de</a></li>
                <li><a href="patrocinadores.jsp">Patrocinadores</a></li>
            </ul>
        </nav>
    </header>

    <div class="content">
        <h2>Modificar Corredor</h2>

        <% if (request.getAttribute("message") != null) { %>
            <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
                <%= request.getAttribute("message") %>
            </p>
        <% } %>

        <%
            Runner runner = (Runner) request.getAttribute("runner");
            if (runner == null) {
                out.println("<p>Error: No se encontró el corredor.</p>");
            } else {
        %>

        <form method="post" action="modifyRunner">
            <label for="id">ID:</label>
            <input type="number" id="id" name="id" value="<%= runner.getId() %>" readonly>

            <label for="name">Nombre:</label>
            <input type="text" id="name" name="name" value="<%= runner.getName() %>" required>

            <label for="surnames">Apellidos:</label>
            <input type="text" id="surnames" name="surnames" value="<%= runner.getSurnames() %>" required>

            <label for="age">Edad:</label>
            <input type="number" id="age" name="age" value="<%= runner.getAge() %>" required>

            <label for="nationality">Nacionalidad:</label>
            <input type="text" id="nationality" name="nationality" value="<%= runner.getNationality() %>" required>

            <label for="mountId">ID de Montura:</label>
            <input type="number" id="mountId" name="mountId" value="<%= runner.getMountId() %>" required>

            <label for="currentPlace">Puesto Actual:</label>
            <input type="number" id="currentPlace" name="currentPlace" value="<%= runner.getCurrentPlace() %>" required>

            <label for="totalPoints">Puntos Totales:</label>
            <input type="number" id="totalPoints" name="totalPoints" value="<%= runner.getTotalPoints() %>" required>

            <button type="submit" class="btn btn-enviar">Actualizar Corredor</button>
            <a href="listRunners" class="btn btn-cancelar">Cancelar</a>
        </form>

        <%
            }
        %>
    </div>

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
