<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.steelballrun.model.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modificar Personaje - Sistema de Gestión de Personajes</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
    <h1>Sistema de gestión de personajes</h1>
    <h2>Modificar Personaje</h2>

    <% if (request.getAttribute("message") != null) { %>
        <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("message") %>
        </p>
    <% } %>

    <%
        Person person = (Person) request.getAttribute("person");
        if (person != null) {
    %>

    <form action="modificarEstudiantes" method="post">
        <input type="hidden" name="id" value="<%= person.getId() %>">

        <fieldset>
            <legend>Datos Personales</legend>

            <label for="name">Nombre:</label><br>
            <input type="text" id="name" name="name" value="<%= person.getName() %>" required><br><br>

            <label for="surnames">Apellidos:</label><br>
            <input type="text" id="surnames" name="surnames" value="<%= person.getSurnames() %>" required><br><br>

            <label for="age">Edad:</label><br>
            <input type="number" id="age" name="age" min="16" value="<%= person.getAge() %>" required><br><br>

            <label for="dni">DNI:</label><br>
            <input type="text" id="dni" name="dni" value="<%= person.getDni() %>" required><br><br>
        </fieldset>

        <br>

        <input type="submit" value="Guardar Cambios">
    </form>

    <% } else { %>
        <p class="mensaje-error">No se encontró el personaje solicitado.</p>
    <% } %>

    <a class="volver" href="listPersons">← Volver al listado</a>
</body>
</html>
