<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.steelballrun.model.Sponsor" %>
<%
    List<Sponsor> listSponsors = (List<Sponsor>) request.getAttribute("listSponsors");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Patrocinadores</title>
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
    <link rel="stylesheet" href="sbrstyles.css">
</head>
<body>
    <%@ include file="WEB-INF/nav.jspf" %>

    <div class="sponsors-square">
        <div class="sponsors-list">
            <h1>SPONSORS</h1>
            <h4>Estos son los patrocinadores oficiales de Steel Ball Run</h4>
            <% if (listSponsors != null && !listSponsors.isEmpty()) {
                for (Sponsor s : listSponsors) { %>
                    <h3><%= s.getName() %></h3>
            <% } } else { %>
                <p>No hay patrocinadores registrados.</p>
            <% } %>
        </div>
    </div>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>
</body>
</html>
