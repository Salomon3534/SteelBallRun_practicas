<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Registro de Corredor</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body>
    <%@ include file="WEB-INF/nav.jspf" %>

    <main class="register-page">
        <h1>Registro de corredor</h1>
        <% String msg  = (String) request.getAttribute("message");
           String type = (String) request.getAttribute("type");
           if (msg != null) { %>
               <div class="form-message <%= type != null ? type : "info" %>"><%= msg %></div>
        <% } %>

        <div class="register-layout">
            <div class="inscryption-guy">
                <img src="assets/web_images/staff_register.jpg" alt="Personaje de registro">
            </div>
            <p class="bubble">Ehh... rellena los campos y pulsa el botón de registro</p>
            <div class="inscryption-form">
                <form action="inscription" method="post" enctype="multipart/form-data" class="sbr-form">
                    <fieldset>
                        <legend>Datos Personales</legend>
                        <hr><br>
                        <div class="field">
                            <label for="runner-name">Nombre</label>
                            <input type="text" id="runner-name" name="runner-name" required>
                        </div>
                        <div class="field">
                            <label for="runner-country">País</label>
                            <input type="text" id="runner-country" name="runner-country" required>
                        </div>
                        <div class="field">
                            <label for="user-file">Foto de perfil</label>
                            <input type="file" id="user-file" name="user-file" accept=".png, image/png" required>
                        </div>
                        <div class="field-group">
                            <div class="field">
                                <label for="runner-age">Edad</label>
                                <input type="number" id="runner-age" name="runner-age" min="16" required>
                            </div>
                            <div class="field">
                                <label for="runner-dni">DNI</label>
                                <input type="text" id="runner-dni" name="runner-dni" required>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>Datos de montura</legend>
                        <hr><br>
                        <div class="field">
                            <label for="horse-name">Nombre</label>
                            <input type="text" id="horse-name" name="horse-name" required>
                        </div>
                        <div class="field">
                            <label for="horse-type">Tipo de montura</label>
                            <input type="text" id="horse-type" name="horse-type" required>
                        </div>
                    </fieldset>
                    <div class="form-actions">
                        <input type="submit" value="Registrarse" class="btn btn-save">
                        <input type="reset" value="Limpiar formulario" class="btn btn-reset">
                    </div>
                </form>
            </div>
        </div>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
    </footer>
</body>
</html>
