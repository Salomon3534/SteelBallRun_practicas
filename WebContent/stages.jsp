<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Base64, com.steelballrun.model.Stage" %>
<%
    List<Stage> stages = (List<Stage>) request.getAttribute("stages");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Etapas</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body>
    <%@ include file="WEB-INF/nav.jspf" %>

    <main class="stages-page">
        <h1>Etapas de la Carrera</h1>

        <div class="stages-intro">
            La <strong>Steel Ball Run</strong> atraviesa el continente americano de costa a costa —
            desde <em>San Diego, California</em> hasta <em>Nueva York</em> —
            a lo largo de más de <strong>6.000 millas</strong> divididas en nueve etapas épicas. Año 1890.
        </div>

        <% if (stages == null || stages.isEmpty()) { %>
            <p>No hay etapas registradas en la base de datos.</p>
        <% } else { %>
        <div class="stages-timeline">
            <% for (Stage s : stages) {
                String statusClass = s.isCompleted() ? "status-completed" : "status-upcoming";
                String statusText  = s.isCompleted() ? "Completada" : "Próxima";
                byte[] img = s.getImage();
            %>
            <div class="stage-item">
                <div class="stage-card">
                    <span class="stage-status <%= statusClass %>"><%= statusText %></span>
                    <h3><%= s.getName() %></h3>
                    <div class="stage-route"><%= s.getLocation() != null ? s.getLocation() : "" %></div>
                </div>
                <div class="stage-number"><%= s.getId() %></div>
                <div class="stage-image-box">
                    <% if (img != null && img.length > 0) { %>
                        <img src="data:image/png;base64,<%= Base64.getEncoder().encodeToString(img) %>" alt="Etapa <%= s.getId() %>">
                    <% } else { %>
                        <img src="assets/web_images/sbr_logo.png" alt="Sin imagen">
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>
</body>
</html>