<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.steelballrun.model.User, com.steelballrun.model.Runner, com.steelballrun.model.Person, com.steelballrun.model.Mount, com.steelballrun.model.Stage, java.util.List, java.util.Map, java.util.Base64" %>
<%
    User    loggedUser  = (User)    request.getAttribute("loggedUser");
    Runner  runner      = (Runner)  request.getAttribute("runner");
    Person  person      = (Person)  request.getAttribute("person");
    Mount   mount       = (Mount)   request.getAttribute("mount");
    Stage   currentStage= (Stage)   request.getAttribute("currentStage");
    Integer rank        = (Integer) request.getAttribute("rank");
    Integer total       = (Integer) request.getAttribute("totalRunners");
    List<Map<String,Object>> medicalChecks = (List<Map<String,Object>>) request.getAttribute("medicalChecks");
    String profilePasskey  = (String) request.getAttribute("profilePasskey");
    String profileUsername = (String) request.getAttribute("profileUsername");
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
                    <a href="profile" class="header-user-link">
                        <span class="header-user-name"><%= loggedUser.getUsername() %></span>
                    </a>
                </li>
                <li><a href="logout" class="btn-logout-nav">Cerrar sesión</a></li>
            </ul>
        </nav>
    </header>

    <main class="profile-page">
        <h1>Mi Perfil</h1>

        <% if (runner != null && person != null) { %>
        <div class="profile-hero">
            <% if (runner.getImage() != null && runner.getImage().length > 0) { 
                String base64Image = Base64.getEncoder().encodeToString(runner.getImage());
            %>
                <img class="profile-avatar-img" src="data:image/png;base64,<%= base64Image %>" alt="Foto de perfil">
            <% } %>
            <div class="profile-name">
                <h2><%= person.getName() %></h2>
                <p><%= person.getCountry() %></p>
            </div>
            <span class="profile-role-badge role-user">Participante</span>
        </div>

        <% if (profilePasskey != null) { %>
        <div style="text-align:right;margin-bottom:8px;">
            <button class="btn-pdf-profile" onclick="generarPDF(SBR_NOMBRE, SBR_USERNAME, SBR_PASSKEY)">📄 Descargar certificado PDF</button>
        </div>
        <% } %>

        <div class="points-display">
            <div class="points-info">
                <div class="points-num"><%= runner.getPoints() != null ? runner.getPoints() : 0 %></div>
                <div class="points-label">Puntos acumulados</div>
            </div>
            <div class="points-rank">
                <div class="rank-num">#<%= rank != null ? rank : "—" %></div>
                <div class="rank-label">de <%= total != null ? total : "—" %> corredores</div>
            </div>
        </div>

        <div class="profile-card">
            <h3>Datos del Corredor</h3>
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

        <% if (mount != null) { %>
        <div class="profile-card">
            <h3>Montura</h3>
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

        <div class="profile-card">
            <h3>🗺️ Etapa Actual</h3>
            <% if (currentStage != null) { %>
                <div class="profile-data-grid">
                    <div class="profile-data-item">
                        <label>Etapa</label>
                        <span>#<%= currentStage.getId() %> — <%= currentStage.getName() %></span>
                    </div>
                    <div class="profile-data-item">
                        <label>Localización</label>
                        <span><%= currentStage.getLocation() != null ? currentStage.getLocation() : "—" %></span>
                    </div>
                    <div class="profile-data-item">
                        <label>Estado</label>
                        <span>
                            <% if (currentStage.isCompleted()) { %>
                                <span class="badge badge-ok">Completada</span>
                            <% } else { %>
                                <span class="badge badge-pending">En curso</span>
                            <% } %>
                        </span>
                    </div>
                </div>
            <% } else { %>
                <p style="color:#7a5a2a;font-size:0.95rem;">No hay etapa asignada aún.</p>
            <% } %>
        </div>

        <div class="profile-card">
            <h3>📊 Estadísticas de Carrera</h3>
            <div class="stats-grid">
                <div class="stat-card">
                    <span class="stat-num"><%= runner.getPoints() != null ? runner.getPoints() : 0 %></span>
                    <div class="stat-label">Puntos totales</div>
                </div>
                <div class="stat-card">
                    <span class="stat-num"><%= runner.getKm() != null ? runner.getKm() : 0 %> km</span>
                    <div class="stat-label">Distancia recorrida</div>
                </div>
                <div class="stat-card">
                    <span class="stat-num">#<%= rank != null ? rank : "—" %></span>
                    <div class="stat-label">Posición en clasificación</div>
                </div>
                <div class="stat-card">
                    <span class="stat-num"><%= runner.getIdStage() != null ? "Etapa " + runner.getIdStage() : "—" %></span>
                    <div class="stat-label">Etapa actual</div>
                </div>
            </div>
        </div>

        <div class="profile-card">
            <h3>🩺 Chequeos Médicos</h3>
            <% if (medicalChecks != null && !medicalChecks.isEmpty()) { %>
                <table class="sbr-table" style="width:100%;margin-top:0;">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Resultado</th>
                            <th>Notas</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String,Object> check : medicalChecks) {
                               boolean passed = Boolean.TRUE.equals(check.get("passed"));
                               Object dateObj = check.get("checkDate");
                               String dateStr = dateObj != null ? dateObj.toString().substring(0, 10) : "—";
                               String notes   = check.get("notes") != null ? (String) check.get("notes") : "—";
                        %>
                        <tr>
                            <td><%= dateStr %></td>
                            <td>
                                <% if (passed) { %>
                                    <span class="badge badge-ok">✔ Apto</span>
                                <% } else { %>
                                    <span class="badge badge-fail">✖ No apto</span>
                                <% } %>
                            </td>
                            <td><%= notes %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p style="color:#7a5a2a;font-size:0.95rem;">No hay chequeos médicos registrados.</p>
            <% } %>
        </div>

        <% } else { %>
            <div class="profile-card" style="text-align:center;padding:40px;">
                <p>No hay datos de corredor asociados a tu cuenta.</p>
            </div>
        <% } %>

    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>

    <%-- Las variables JS se definen ANTES de cargar el script que las usa --%>
    <script>
        const SBR_NOMBRE   = "<%= person != null ? person.getName().replace("\"", "\\\"") : "Corredor" %>";
        const SBR_USERNAME = "<%= profileUsername != null ? profileUsername.replace("\"", "\\\"") : "" %>";
        const SBR_PASSKEY  = "<%= profilePasskey  != null ? profilePasskey.replace("\"", "\\\"")  : "" %>";
    </script>
    <%-- jsPDF debe cargarse ANTES que sbr-pdf.js, que depende de window.jspdf --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/sbr-pdf.js"></script>

</body>
</html>
