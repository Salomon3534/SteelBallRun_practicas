<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insertar personaje</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="assets/img/logo.png" alt="Logo Sistema" id="main-logo" style="height: 50px;">
        </div>
        <h1>Sistema de gestión de personajes</h1>
    </header>

    <main>
        <h2>Insertar nuevo personaje</h2>

        <% if (request.getAttribute("message") != null) { %>
            <p class="<%= "success".equals(request.getAttribute("type")) ? "mensaje-exito" : "mensaje-error" %>">
                <%= request.getAttribute("message") %>
            </p>
        <% } %>

        <form action="insertCharacter" method="post">
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
    </main>

    <footer style="margin-top: 20px; border-top: 1px solid #ccc; padding-top: 10px; text-align: center;">
        <p>&copy; 1890 Steel Ball Run Race</p>
        <nav>
            <a href=".jsp">Privacidad</a>
        </nav>
        <div class="footer-image" style="margin-top: 10px;">
            <img src="assets/web_images/assistant_footer.png" alt="Footer Icon" style="width: 30px;">
        </div>
    </footer>
</body>
</html>