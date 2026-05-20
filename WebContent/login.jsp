<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.steelballrun.model.User" %>
<%
    HttpSession s = request.getSession(false);
    if (s != null && s.getAttribute("loggedUser") != null) {
        User u = (User) s.getAttribute("loggedUser");
        response.sendRedirect(request.getContextPath() + ("admin".equals(u.getRole()) ? "/admin" : "/profile"));
        return;
    }
    String errorMsg = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR — Iniciar Sesión</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body>
    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="index">Inicio</a></li>
                <li><a href="about.jsp">Acerca de</a></li>
                <li><a href="runners">Corredores</a></li>
                <li><a href="sponsors">Patrocinadores</a></li>
                <li><a href="stages">Etapas</a></li>
                <li><a href="inscription">Inscripción</a></li>
            </ul>
        </nav>
    </header>

    <main class="login-wrapper">
        <div class="login-title">
            <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="SBR Logo" style="height:80px;margin-bottom:12px;">
            <h1>Steel Ball Run</h1>
        </div>

        <div class="login-box">
            <h2>Iniciar Sesión</h2>

            <% if (errorMsg != null) { %>
                <div class="login-error visible"><%= errorMsg %></div>
            <% } %>

            <form action="login" method="post" class="sbr-form">
                <div class="field">
                    <label for="username">Usuario</label>
                    <input type="text" id="username" name="username" required autocomplete="username"
                           placeholder="tu_nombre_123">
                </div>
                <div class="field">
                    <label for="passkey">Passkey</label>
                    <input type="password" id="passkey" name="passkey" required autocomplete="current-password"
                           placeholder="xxxxxxxx-xxxx-xxxx-...">
                </div>
                <button type="submit" class="btn-login-submit">Entrar</button>
            </form>

            <div class="login-divider">¿Aún no estás inscrito?</div>
            <a href="inscription" class="login-back">Inscríbete</a>
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
