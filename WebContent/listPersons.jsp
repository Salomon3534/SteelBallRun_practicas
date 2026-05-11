<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.steelballrun.model.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de personajes</title>
    <link rel="stylesheet" href="assets/css/styles.css">
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
    	@SuppressWarnings("unchecked")
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
