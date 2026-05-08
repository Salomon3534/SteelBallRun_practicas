<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insertar Estudiante - Gestión de Escuela</title>
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
        input[type="submit"], input[type="reset"] {
            padding: 8px 20px;
            margin-right: 10px;
            cursor: pointer;
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
    <h2>Insertar Nuevo Estudiante</h2>

    <% if (request.getAttribute("mensaje") != null) { %>
        <p class="<%= "exito".equals(request.getAttribute("tipo")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("mensaje") %>
        </p>
    <% } %>

    <form action="insertarEstudiante" method="post">
        <fieldset>
            <legend>Datos Personales</legend>

            <label for="nombre">Nombre:</label><br>
            <input type="text" id="nombre" name="nombre" required><br><br>

            <label for="edad">Edad:</label><br>
            <input type="number" id="edad" name="edad" min="0" max="120" required><br><br>

            <label for="dni">DNI:</label><br>
            <input type="text" id="dni" name="dni" required><br><br>
        </fieldset>

        <br>

        <fieldset>
            <legend>Datos Académicos</legend>

            <label for="carrera">Carrera:</label><br>
            <input type="text" id="carrera" name="carrera" required><br><br>

            <label for="promedio">Promedio de Notas (0-10):</label><br>
            <input type="number" id="promedio" name="promedio" step="0.01" min="0" max="10" required><br><br>
        </fieldset>

        <br>

        <input type="submit" value="Insertar Estudiante">
        <input type="reset" value="Limpiar">
    </form>

    <a class="volver" href="listarEstudiantes">← Volver al listado</a>
</body>
</html>
