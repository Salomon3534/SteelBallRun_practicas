<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.steelballrun.model.Runner" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Corredores</title>
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
                <li><a href="etapas.jsp">Etapas</a></li>
                <li><a href="acerca.jsp">Acerca de</a></li>
                <li><a href="patrocinadores.jsp">Patrocinadores</a></li>
                <li><a href="login.jsp">Iniciar sesion</a></li>
            </ul>
        </nav>
    </header>

    <div class="content">
        <h2>Listado de Corredores</h2>

        <% if (request.getAttribute("message") != null) { %>
            <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
                <%= request.getAttribute("message") %>
            </p>
        <% } %>

        <%
        	@SuppressWarnings("unchecked")
            List<Runner> listRunners = (List<Runner>) request.getAttribute("listRunners");
        %>

        <% if (listRunners != null && !listRunners.isEmpty()) { %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Edad</th>
                    <th>Nacionalidad</th>
                    <th>Montura ID</th>
                    <th>Dorsal</th>
                    <th>Puesto</th>
                    <th>Puntos</th>
                    <th>Acciones</th>
                </tr>
                <% for (Runner r : listRunners) { %>
                    <tr>
                        <td><%= r.getId() %></td>
                        <td><%= r.getName() %></td>
                        <td><%= r.getSurnames() %></td>
                        <td><%= r.getAge() %></td>
                        <td><%= r.getNationality() %></td>
                        <td><%= r.getMountId() %></td>
                        <td><%= r.getBib() %></td>
                        <td><%= r.getCurrentPlace() %></td>
                        <td><%= r.getTotalPoints() %></td>
                        <td>
                            <a class="btn btn-modificar" href="modifyRunner?id=<%= r.getId() %>">Modificar</a>
                            <a class="btn btn-borrar" href="deleteRunner?id=<%= r.getId() %>"
                               onclick="return confirm('¿Está seguro de que desea borrar este corredor?');">Borrar</a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p><strong>No hay corredores registrados.</strong></p>
        <% } %>

        <div class="acciones">
            <a class="btn btn-insertar" href="insertRunner.jsp">Insertar Nuevo Corredor</a>
        </div>
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
