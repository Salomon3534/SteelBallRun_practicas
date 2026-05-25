<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String nombre   = (String) session.getAttribute("registeredName");
    String passkey  = (String) session.getAttribute("registeredPasskey");
    String username = (String) session.getAttribute("registeredUsername");
    if (passkey == null) { response.sendRedirect("inscription"); return; }
    session.removeAttribute("registeredPasskey");
    session.removeAttribute("registeredName");
    session.removeAttribute("registeredUsername");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Registro Completado</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body>
    <%@ include file="WEB-INF/nav.jspf" %>

    <main class="passkey-page">
        <h1>¡Registro Completado!</h1>
        <div class="passkey-box">
            <h2>¡Bienvenido/a, <%= nombre != null ? nombre : "Corredor" %>!</h2>
            <% if (username != null) { %>
                <p>Tu nombre de usuario es: <strong><%= username %></strong></p>
            <% } %>
            <p>Tu clave de acceso personal (passkey) es:</p>
            <div class="passkey-code" id="passkeyCode"><%= passkey %></div>
            <p class="passkey-warning">Guarda esta clave. No la podrás recuperar después.</p>
            <p style="color:#3a5a00;margin-bottom:10px;">Has iniciado sesión automáticamente como <strong><%= username != null ? username : nombre %></strong></p>
            <button class="btn-pdf" onclick="generarPDF(NOMBRE, USERNAME, PASSKEY)">Descargar PDF verificador</button>
            <a class="btn-home" href="profile">Ver mi perfil</a>
        </div>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>

    <%-- 1. Variables primero --%>
    <script>
        const NOMBRE   = "<%= nombre   != null ? nombre.replace("\"", "\\\"")   : "Corredor" %>";
        const PASSKEY  = "<%= passkey  != null ? passkey.replace("\"", "\\\"")  : "" %>";
        const USERNAME = "<%= username != null ? username.replace("\"", "\\\"") : "" %>";
    </script>
    <%-- 2. jsPDF (window.jspdf) --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <%-- 3. sbr-pdf.js que usa ambos --%>
    <script src="<%= request.getContextPath() %>/assets/sbr-pdf.js"></script>

</body>
</html>
