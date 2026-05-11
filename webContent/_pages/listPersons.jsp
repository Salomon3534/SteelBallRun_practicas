<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.steelballrunrace.model.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de personajes</title>
    <style>
        table {
            border-collapse: collapse;
            width: 90%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        h1, h2, p {
            text-align: center;
        }
        .btn {
            padding: 5px 12px;
            margin: 2px;
            border: none;
            cursor: pointer;
            border-radius: 3px;
            font-size: 13px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-modificar {
            background-color: #2196F3;
            color: white;
        }
        .btn-modificar:hover {
            background-color: #1976D2;
        }
        .btn-borrar {
            background-color: #f44336;
            color: white;
        }
        .btn-borrar:hover {
            background-color: #d32f2f;
        }
        .btn-insertar {
            background-color: #4CAF50;
            color: white;
            padding: 10px 25px;
            font-size: 15px;
        }
        .btn-insertar:hover {
            background-color: #388E3C;
        }
        .acciones {
            text-align: center;
            margin: 20px;
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
    </style>
</head>
<body>
    <h1>Sistema de gestión de personajes</h1>
    <h2>Listado de personajes</h2>

    <% if (request.getAttribute("message") != null) { %>
        <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
            <%= request.getAttribute("message") %>
        </p>
    <% } %>

    <%
        List<Person> listPersons = (List<Person>) request.getAttribute("listPersons");
    %>

    <% if (listPersons != null) { %>
        <table>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Edad</th>
                <th>DNI</th>
            </tr>
            <% for (Person p : listPersons) { %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getSurnames() %></td>
                    <td><%= p.getAge() %></td>
                    <td><%= p.getDni() %></td>
                    <td>
                        <a class="btn btn-modificar" href="modificarEstudiantes?id=<%= p.getId() %>">Modificar</a>
                        <a class="btn btn-borrar" href="deletePerson?id=<%= p.getId() %>"
                           onclick="return confirm('¿Está seguro de que desea borrar este personaje?');">Borrar</a>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p><strong>No hay personajes registrados.</strong></p>
    <% } %>

    <div class="acciones">
        <a class="btn btn-insertar" href="insertPerson.jsp">Insertar Nuevo personaje</a>
    </div>
</body>
</html>
