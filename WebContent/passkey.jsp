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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="assets/js/sbr-pdf.js"></script>
    <style>
        .passkey-page { max-width: 600px; margin: 60px auto; text-align: center; padding: 0 20px; }
        .passkey-box { background: #fdf6e3; border: 3px solid #8b6914; border-radius: 12px; padding: 40px; margin: 30px 0; }
        .passkey-box h2 { color: #5a3a00; margin-bottom: 10px; }
        .passkey-code { font-family: monospace; font-size: 1.3rem; background: #fff8e1; border: 2px dashed #c9a227; border-radius: 8px; padding: 18px 24px; letter-spacing: 2px; color: #2c1a00; word-break: break-all; margin: 20px 0; }
        .passkey-warning { color: #8b0000; font-weight: bold; font-size: 0.95rem; margin-bottom: 24px; }
        .btn-pdf { background: #8b6914; color: #fff; border: none; padding: 14px 32px; font-size: 1.1rem; border-radius: 8px; cursor: pointer; margin: 8px; text-decoration: none; display: inline-block; }
        .btn-pdf:hover { background: #5a3a00; }
        .btn-home { background: #3a5a00; color: #fff; border: none; padding: 14px 32px; font-size: 1.1rem; border-radius: 8px; cursor: pointer; margin: 8px; text-decoration: none; display: inline-block; }
        .btn-home:hover { background: #1e3a00; }
    </style>
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

    <script>
        const NOMBRE   = "<%= nombre   != null ? nombre.replace("\"", "\\\"")   : "Corredor" %>";
        const PASSKEY  = "<%= passkey  != null ? passkey.replace("\"", "\\\"")  : "" %>";
        const USERNAME = "<%= username != null ? username.replace("\"", "\\\"") : "" %>";
    </script>
</body>
</html>