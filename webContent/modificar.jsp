<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.steelballrunrace.model.Estudiante" %>
<%@ page import="com.steelballrunrace.model.Persona" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modificar Estudiante - Gestión de Escuela</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1, h2 {
            text-align: center;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
        }
        fieldset {
            padding: 15px;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            padding: 8px 20px;
            margin-right: 10px;
            cursor: pointer;
            background-color: #2196F3;
            color: white;
            border: none;
            border-radius: 3px;
            font-size: 14px;
        }
        input[type="submit"]:hover {
            background-color: #1976D2;
        }
        .mensaje-exito {
            color: green;
            text-align: center;
            font-weight: bold;
        }
        .mensaje-error {
            color: red;
            text-align: center;
            font-weight: bold;
        }
        .volver {
            display: block;
            text-align: center;
            margin: 20px;
        }
    </style>
</head>
<body>
    <h1>Sistema de Gestión de Estudiantes</h1>
    <h2>Modificar Estudiante</h2>

    <% if (request.getAttribute("mensaje") != null) { %>
        <p class="<%= "exito".equals(request.getAttribute("tipo")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("mensaje") %>
        </p>
    <% } %>

    <%
        Estudiante estudiante = (Estudiante) request.getAttribute("estudiante");
        if (estudiante != null && estudiante.getPersona() != null) {
            Persona persona = estudiante.getPersona();
    %>

    <form action="modificarEstudiante" method="post">
        <input type="hidden" name="id" value="<%= persona.getId() %>">

        <fieldset>
            <legend>Datos Personales</legend>

            <label for="nombre">Nombre:</label><br>
            <input type="text" id="nombre" name="nombre" value="<%= persona.getNombre() %>" required><br><br>

            <label for="edad">Edad:</label><br>
            <input type="number" id="edad" name="edad" min="0" max="120" value="<%= persona.getEdad() %>" required><br><br>

            <label for="dni">DNI:</label><br>
            <input type="text" id="dni" name="dni" value="<%= persona.getDni() %>" required><br><br>
        </fieldset>

        <br>

        <fieldset>
            <legend>Datos Académicos</legend>

            <label for="carrera">Carrera:</label><br>
            <input type="text" id="carrera" name="carrera" value="<%= estudiante.getCarrera() %>" required><br><br>

            <label for="promedio">Promedio de Notas (0-10):</label><br>
            <input type="number" id="promedio" name="promedio" step="0.01" min="0" max="10" value="<%= estudiante.getPromedioNotas() %>" required><br><br>
        </fieldset>

        <br>

        <input type="submit" value="Guardar Cambios">
    </form>

    <% } else { %>
        <p class="mensaje-error">No se encontró el estudiante solicitado.</p>
    <% } %>

    <a class="volver" href="listarEstudiantes">← Volver al listado</a>
</body>
</html>
