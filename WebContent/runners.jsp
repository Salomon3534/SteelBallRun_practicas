<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.steelballrun.model.Runner, com.steelballrun.model.Person, com.steelballrun.model.Mount" %>
<%
    List<Runner>         runners   = (List<Runner>)         request.getAttribute("runners");
    Map<Integer, Person> personMap = (Map<Integer, Person>) request.getAttribute("personMap");
    Map<Integer, Mount>  mountMap  = (Map<Integer, Mount>)  request.getAttribute("mountMap");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Corredores</title>
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
    <link rel="stylesheet" href="sbrstyles.css">
</head>
<body>
    <%@ include file="WEB-INF/nav.jspf" %>

    <main class="runners-page">
        <h1>Corredores</h1>

        <% if (request.getAttribute("message") != null) { %>
            <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
                <%= request.getAttribute("message") %>
            </p>
        <% } %>

        <div class="runners-grid">
            <% if (runners != null && !runners.isEmpty()) {
                for (Runner r : runners) {
                    Person p = personMap != null ? personMap.get(r.getIdPerson()) : null;
                    Mount  m = mountMap  != null ? mountMap.get(r.getIdMount())   : null;
            %>
                <div class="runner-card">
                    <div class="runner-img-container">
                        <% if (r.getImage() != null && r.getImage().length > 0) { %>
                            <img src="data:image/png;base64,<%= java.util.Base64.getEncoder().encodeToString(r.getImage()) %>" alt="Foto corredor">
                        <% } else { %>
                            <img src="assets/web_images/sbr_logo.png" alt="Sin foto">
                        <% } %>
                    </div>
                    <div class="runner-stats">
                        <h3><%= p != null ? p.getName() : "Desconocido" %> &nbsp;#<%= r.getBib() %></h3>
                        <div class="runner-meta">
                            <span><strong>País:</strong>    <%= p != null ? p.getCountry() : "-" %></span>
                            <span><strong>Edad:</strong>    <%= p != null ? p.getAge()     : "-" %></span>
                            <span><strong>Montura:</strong> <%= m != null ? m.getName()    : "-" %></span>
                            <span><strong>Tipo:</strong>    <%= m != null ? m.getType()    : "-" %></span>
                            <span><strong>Puntos:</strong>  <%= r.getPoints() != null ? r.getPoints() : 0 %></span>
                            <span><strong>Km:</strong>      <%= r.getKm()     != null ? r.getKm()     : 0 %></span>
                        </div>
                    </div>
                </div>
            <% } } else { %>
                <p>No se encontraron corredores en la base de datos.</p>
            <% } %>
        </div>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>
</body>
</html>
