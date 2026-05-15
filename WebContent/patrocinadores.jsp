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
    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="corredores.jsp">Corredores</a></li>
                <li><a href="etapas.jsp">Etapas</a></li>
                <li><a href="patrocinadores.jsp" style="text-decoration:underline">Patrocinadores</a></li>
                <li><a href="acerca.jsp">Acerca de</a></li>
            <li id="session-nav-item"><a href="admin_login.jsp" class="header-session-btn" id="session-btn">Iniciar sesion</a></li>
            </ul>
        </nav>
    </header>

    <div class="sponsors-square">
        <div class="sponsors-list">
            <h1>SPONSORS</h1>
            <h4>Estos son los patrocinadores oficiales de Steel Ball Run</h4>
            <h3>East and West Tribune</h3>
            <h3>B &amp; C Meat Company</h3>
            <h3>Horizontal Continental Railway Company</h3>
            <h3>Speedwagon Oil Company</h3>
        </div>
    </div>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>
    <script>
        const _isAdmin = sessionStorage.getItem('sbr_admin_auth') === 'true';
        const _isUser  = sessionStorage.getItem('sbr_user_auth') === 'true';
        const _btn = document.getElementById('session-btn');
        if (_btn && (_isAdmin || _isUser)) {
            _btn.href = 'perfil.jsp';
            _btn.textContent = 'Mi perfil';
        }
    </script>
</body>
</html>
