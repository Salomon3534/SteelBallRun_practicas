<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insertar personaje</title>
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
    <h1>Sistema de gestión de personajes</h1>
    <h2>Insertar nuevo personaje</h2>

    <% if (request.getAttribute("mensaje") != null) { %>
        <p class="<%= "succes".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("messge") %>
        </p>
    <% } %>

    <form action="createPerson" method="post">
        <fieldset>
            <legend>Datos personales</legend>

            <label for="name">Nombre:</label><br>
            <input type="text" id="name" name="name" required><br><br>
            
             <label for="surnames">Apellidos:</label><br>
            <input type="text" id="surnames" name="surnames" required><br><br>

            <label for="age">Edad:</label><br>
            <input type="number" id="age" name="age" min="16" required><br><br>

            <label for="dni">DNI:</label><br>
            <input type="text" id="dni" name="dni" required><br><br>
        </fieldset>
        <br>

        <input type="submit" value="Insertar personaje">
        <input type="reset" value="Limpiar">
    </form>

    <a class="volver" href="listPersons">Volver al listado</a>
</body>
</html>
