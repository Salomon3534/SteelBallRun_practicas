<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="corredores.jsp" style="text-decoration:underline">Corredores</a></li>
                <li><a href="etapas.jsp">Etapas</a></li>
                <li><a href="patrocinadores.jsp">Patrocinadores</a></li>
                <li><a href="acerca.jsp">Acerca de</a></li>
                <li id="session-nav-item">
                    <a href="login.jsp" class="header-session-btn" id="session-btn">Iniciar sesion</a>
                </li>
            </ul>
        </nav>
    </header>

    <main class="runners-page">
        <h1>Corredores</h1>
        <div class="runners-grid" id="runnersGrid">
            <% if (${runners} != null && !${runners}.isEmpty()) { %>
                <% for (Runner r : runners) { %>
                    <div class="runner-card">
                        <div class="runner-img-container">
                            <img
                                src="assets/characters/<%= (r.getName() != null) ? (r.getSurnames() != null ? r.getName().toLowerCase().replaceAll(" ", "_") + "_" + r.getSurnames().toLowerCase().replaceAll(" ", "_") : r.getName().toLowerCase().replaceAll(" ", "_")) : "" %>.webp"
                                alt="<%= r.getName() %>"
                                onerror="this.src='assets/web_images/sbr_logo.png'">
                        </div>
                        <div class="runner-stats">
                            <h3>
                                <%= r.getName() %>
                                <%= r.getSurnames() != null ? r.getSurnames() : "" %>
                                &nbsp;#<%= r.getBib() %>
                            </h3>
                            <div class="runner-meta">
                                <span><strong>Origen:</strong> <%= r.getNationality() %></span>
                                <span><strong>Puesto:</strong> <%= r.getCurrentPlace() %></span>
                                <span><strong>Puntos:</strong> <%= r.getTotalPoints() %></span>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
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

    <script>
        const isAdmin = sessionStorage.getItem('sbr_admin_auth') === 'true';
        const isUser  = sessionStorage.getItem('sbr_user_auth') === 'true';
        const btn = document.getElementById('session-btn');
        if (btn && (isAdmin || isUser)) {
            btn.href = 'perfil.jsp';
            btn.textContent = 'Mi perfil';
        }
    </script>
</body>
</html>
