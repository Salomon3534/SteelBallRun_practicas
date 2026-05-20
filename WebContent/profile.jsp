<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.steelballrun.model.User, com.steelballrun.model.Runner, com.steelballrun.model.Person, com.steelballrun.model.Mount" %>
<%
    User loggedUser  = (User)   request.getAttribute("loggedUser");
    Runner runner    = (Runner) request.getAttribute("runner");
    Person person    = (Person) request.getAttribute("person");
    Mount  mount     = (Mount)  request.getAttribute("mount");
    Integer rank     = (Integer) request.getAttribute("rank");
    Integer total    = (Integer) request.getAttribute("totalRunners");
    if (loggedUser == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR — Mi Perfil</title>
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
                <li class="header-user-info">
                    <span class="header-user-icon">🤠</span>
                    <span class="header-user-name"><%= loggedUser.getUsername() %></span>
                </li>
                <li><a href="logout" class="btn btn-logout-nav">Cerrar sesión</a></li>
            </ul>
        </nav>
    </header>

    <main class="profile-page">
        <h1>Mi Perfil</h1>

        <% if (runner != null && person != null) { %>
        <!-- Hero con imagen y datos básicos -->
        <div class="profile-hero">
            <% if (runner.getImage() != null && runner.getImage().length > 0) { %>
                <img class="profile-avatar-img" src="runnerImage?bib=<%= runner.getBib() %>" alt="Foto de perfil">
            <% } else { %>
                <div class="profile-avatar">🤠</div>
            <% } %>
            <div class="profile-name">
                <h2><%= person.getName() %></h2>
                <p><%= person.getCountry() %></p>
            </div>
            <span class="profile-role-badge role-user">Participante</span>
        </div>

        <!-- Puntos y ranking -->
        <div class="points-display">
            <div class="points-icon">🏅</div>
            <div class="points-info">
                <div class="points-num"><%= runner.getPoints() != null ? runner.getPoints() : 0 %></div>
                <div class="points-label">Puntos acumulados</div>
            </div>
            <div class="points-rank">
                <div class="rank-num">#<%= rank != null ? rank : "—" %></div>
                <div class="rank-label">de <%= total != null ? total : "—" %> corredores</div>
            </div>
        </div>

        <!-- Datos del corredor -->
        <div class="profile-card">
            <h3>📋 Datos del Corredor</h3>
            <div class="profile-data-grid">
                <div class="profile-data-item">
                    <label>Nombre</label>
                    <span><%= person.getName() %></span>
                </div>
                <div class="profile-data-item">
                    <label>Edad</label>
                    <span><%= person.getAge() %> años</span>
                </div>
                <div class="profile-data-item">
                    <label>País</label>
                    <span><%= person.getCountry() %></span>
                </div>
                <div class="profile-data-item">
                    <label>DNI</label>
                    <span><%= person.getDni() %></span>
                </div>
                <div class="profile-data-item">
                    <label>Dorsal</label>
                    <span>#<%= runner.getBib() %></span>
                </div>
                <div class="profile-data-item">
                    <label>Km recorridos</label>
                    <span><%= runner.getKm() != null ? runner.getKm() : 0 %> km</span>
                </div>
            </div>
        </div>

        <!-- Montura -->
        <% if (mount != null) { %>
        <div class="profile-card">
            <h3>🐴 Montura</h3>
            <div class="profile-data-grid">
                <div class="profile-data-item">
                    <label>Nombre</label>
                    <span><%= mount.getName() %></span>
                </div>
                <div class="profile-data-item">
                    <label>Tipo</label>
                    <span><%= mount.getType() %></span>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Estadísticas de carrera -->
        <div class="profile-card">
            <h3>📊 Estadísticas de Carrera</h3>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-num"><%= runner.getPoints() != null ? runner.getPoints() : 0 %></div>
                    <div class="stat-label">Puntos totales</div>
                </div>
                <div class="stat-card">
                    <div class="stat-num"><%= runner.getKm() != null ? runner.getKm() : 0 %> km</div>
                    <div class="stat-label">Distancia recorrida</div>
                </div>
                <div class="stat-card">
                    <div class="stat-num">#<%= rank != null ? rank : "—" %></div>
                    <div class="stat-label">Posición en clasificación</div>
                </div>
                <div class="stat-card">
                    <div class="stat-num"><%= runner.getIdStage() != null ? "Etapa " + runner.getIdStage() : "—" %></div>
                    <div class="stat-label">Etapa actual</div>
                </div>
            </div>
        </div>

        <% } else { %>
            <div class="profile-card" style="text-align:center;padding:40px;">
                <p>No hay datos de corredor asociados a tu cuenta.</p>
            </div>
        <% } %>

        <div style="text-align:center;margin:30px 0;">
            <a href="logout" class="btn btn-logout-nav" style="padding:12px 32px;font-size:1.1rem;">
                🚪 Cerrar sesión
            </a>
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
