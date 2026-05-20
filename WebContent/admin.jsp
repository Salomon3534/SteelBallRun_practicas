<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.steelballrun.model.*" %>
<%
    User loggedAdmin   = (User)    (session != null ? session.getAttribute("loggedUser") : null);
    if (loggedAdmin == null || !"admin".equals(loggedAdmin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login"); return;
    }
    List<Runner>  runners  = (List<Runner>)  request.getAttribute("runners");
    List<Person>  persons  = (List<Person>)  request.getAttribute("persons");
    List<Mount>   mounts   = (List<Mount>)   request.getAttribute("mounts");
    List<Sponsor> sponsors = (List<Sponsor>) request.getAttribute("sponsors");
    List<Stage>   stages   = (List<Stage>)   request.getAttribute("stages");
    List<User>    users    = (List<User>)    request.getAttribute("users");
    Map<Integer,Person> personMap = (Map<Integer,Person>) request.getAttribute("personMap");
    Map<Integer,Mount>  mountMap  = (Map<Integer,Mount>)  request.getAttribute("mountMap");
    String adminMsg   = (String) request.getAttribute("adminMsg");
    String adminError = (String) request.getAttribute("adminError");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR Admin — Panel</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body>
    <header class="main-header">
        <img src="assets/web_images/Logo_Steel_Ball_Run.png" alt="Steel Ball Run Logo" class="logo">
        <nav>
            <ul>
                <li><a href="index">← Sitio público</a></li>
                <li style="color:gold;font-weight:bold;">⚙ Admin: <%= loggedAdmin.getUsername() %></li>
                <li><a href="logout" class="btn btn-logout-nav">Cerrar sesión</a></li>
            </ul>
        </nav>
    </header>

    <div class="admin-layout">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <span class="sidebar-section-label">General</span>
            <button class="sidebar-btn active" onclick="showSection('dashboard')" id="sb-dashboard">
                <span class="icon">📊</span> Dashboard
            </button>
            <span class="sidebar-section-label">Gestión</span>
            <button class="sidebar-btn" onclick="showSection('corredores')" id="sb-corredores">
                <span class="icon">🏇</span> Corredores
            </button>
            <button class="sidebar-btn" onclick="showSection('personas')" id="sb-personas">
                <span class="icon">👤</span> Personas
            </button>
            <button class="sidebar-btn" onclick="showSection('monturas')" id="sb-monturas">
                <span class="icon">🐴</span> Monturas
            </button>
            <button class="sidebar-btn" onclick="showSection('patrocinadores')" id="sb-patrocinadores">
                <span class="icon">💰</span> Patrocinadores
            </button>
            <button class="sidebar-btn" onclick="showSection('usuarios')" id="sb-usuarios">
                <span class="icon">🔑</span> Usuarios
            </button>
            <div class="sidebar-logout">
                <a href="logout"><button>🚪 Cerrar sesión</button></a>
            </div>
        </aside>

        <!-- Main content -->
        <main class="admin-content">

            <!-- MSG / ERROR -->
            <% if (adminMsg != null) { %>
                <div class="form-message success" style="margin-bottom:16px;"><%= adminMsg %></div>
            <% } %>
            <% if (adminError != null) { %>
                <div class="form-message error" style="margin-bottom:16px;"><%= adminError %></div>
            <% } %>

            <!-- DASHBOARD -->
            <section class="admin-section active" id="sec-dashboard">
                <h2>Dashboard</h2>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-num"><%= runners  != null ? runners.size()  : 0 %></div>
                        <div class="stat-label">Corredores</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-num"><%= persons  != null ? persons.size()  : 0 %></div>
                        <div class="stat-label">Personas registradas</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-num"><%= mounts   != null ? mounts.size()   : 0 %></div>
                        <div class="stat-label">Monturas</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-num"><%= sponsors != null ? sponsors.size() : 0 %></div>
                        <div class="stat-label">Patrocinadores</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-num"><%= stages   != null ? stages.size()   : 0 %></div>
                        <div class="stat-label">Etapas</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-num"><%= users    != null ? users.size()    : 0 %></div>
                        <div class="stat-label">Usuarios</div>
                    </div>
                </div>
            </section>

            <!-- CORREDORES -->
            <section class="admin-section" id="sec-corredores">
                <h2>Gestión de Corredores</h2>
                <button class="add-row-btn" onclick="toggleForm('form-corredor')">+ Nuevo Corredor</button>

                <div class="admin-form-box" id="form-corredor" style="display:none;">
                    <h3>Crear Corredor</h3>
                    <form action="admin" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="entity" value="runner">
                        <input type="hidden" name="action" value="create">
                        <div class="field">
                            <label>Persona</label>
                            <select name="r_personId" required>
                                <% if (persons != null) for (Person p : persons) { %>
                                    <option value="<%= p.getId() %>"><%= p.getName() %> (ID <%= p.getId() %>)</option>
                                <% } %>
                            </select>
                        </div>
                        <div class="field">
                            <label>Montura</label>
                            <select name="r_mountId" required>
                                <% if (mounts != null) for (Mount m : mounts) { %>
                                    <option value="<%= m.getId() %>"><%= m.getName() %> (ID <%= m.getId() %>)</option>
                                <% } %>
                            </select>
                        </div>
                        <div class="field-group">
                            <div class="field"><label>Puntos</label><input type="number" name="r_points" value="0" min="0"></div>
                            <div class="field"><label>Km</label><input type="number" name="r_km" value="0" min="0"></div>
                        </div>
                        <div class="field"><label>Etapa (ID)</label><input type="number" name="r_stage" min="1"></div>
                        <div class="field"><label>Foto (PNG)</label><input type="file" name="r_image" accept=".png,image/png"></div>
                        <div class="form-actions">
                            <input type="submit" value="Crear" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="toggleForm('form-corredor')">Cancelar</button>
                        </div>
                    </form>
                </div>

                <table class="admin-table">
                    <thead><tr><th>Dorsal</th><th>Corredor</th><th>Montura</th><th>Puntos</th><th>Km</th><th>Etapa</th><th>Acciones</th></tr></thead>
                    <tbody>
                    <% if (runners != null) for (Runner r : runners) {
                        Person p = personMap != null ? personMap.get(r.getIdPerson()) : null;
                        Mount  m = mountMap  != null ? mountMap.get(r.getIdMount())   : null;
                    %>
                        <tr>
                            <td>#<%= r.getBib() %></td>
                            <td><%= p != null ? p.getName() : "—" %></td>
                            <td><%= m != null ? m.getName() : "—" %></td>
                            <td><%= r.getPoints() != null ? r.getPoints() : 0 %></td>
                            <td><%= r.getKm() != null ? r.getKm() : 0 %></td>
                            <td><%= r.getIdStage() != null ? r.getIdStage() : "—" %></td>
                            <td>
                                <div class="actions">
                                    <button class="btn-sm btn-edit" onclick="editRunner(<%= r.getBib() %>, <%= r.getPoints() != null ? r.getPoints() : 0 %>, <%= r.getKm() != null ? r.getKm() : 0 %>, '<%= r.getIdStage() != null ? r.getIdStage() : "" %>')">Editar</button>
                                    <form action="admin" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar corredor #<%= r.getBib() %>?')">
                                        <input type="hidden" name="entity" value="runner">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="r_bib" value="<%= r.getBib() %>">
                                        <button type="submit" class="btn-sm btn-del">Eliminar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>

                <!-- Edit runner modal -->
                <div class="admin-form-box" id="form-edit-corredor" style="display:none;">
                    <h3>Editar Corredor</h3>
                    <form action="admin" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="entity" value="runner">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="r_bib" id="edit-r-bib">
                        <div class="field-group">
                            <div class="field"><label>Puntos</label><input type="number" name="r_points" id="edit-r-points" min="0"></div>
                            <div class="field"><label>Km</label><input type="number" name="r_km" id="edit-r-km" min="0"></div>
                        </div>
                        <div class="field"><label>Etapa (ID)</label><input type="number" name="r_stage" id="edit-r-stage" min="1"></div>
                        <div class="field"><label>Nueva foto (opcional)</label><input type="file" name="r_image" accept=".png,image/png"></div>
                        <div class="form-actions">
                            <input type="submit" value="Guardar" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="document.getElementById('form-edit-corredor').style.display='none'">Cancelar</button>
                        </div>
                    </form>
                </div>
            </section>

            <!-- PERSONAS -->
            <section class="admin-section" id="sec-personas">
                <h2>Gestión de Personas</h2>
                <button class="add-row-btn" onclick="toggleForm('form-persona')">+ Nueva Persona</button>
                <div class="admin-form-box" id="form-persona" style="display:none;">
                    <h3>Crear Persona</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="person">
                        <input type="hidden" name="action" value="create">
                        <div class="field-group">
                            <div class="field"><label>Nombre</label><input type="text" name="p_name" required></div>
                            <div class="field"><label>Edad</label><input type="number" name="p_age" min="16" required></div>
                        </div>
                        <div class="field-group">
                            <div class="field"><label>País</label><input type="text" name="p_country" required></div>
                            <div class="field"><label>DNI</label><input type="text" name="p_dni" required></div>
                        </div>
                        <div class="form-actions">
                            <input type="submit" value="Crear" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="toggleForm('form-persona')">Cancelar</button>
                        </div>
                    </form>
                </div>
                <table class="admin-table">
                    <thead><tr><th>ID</th><th>Nombre</th><th>Edad</th><th>País</th><th>DNI</th><th>Acciones</th></tr></thead>
                    <tbody>
                    <% if (persons != null) for (Person p : persons) { %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getName() %></td>
                            <td><%= p.getAge() %></td>
                            <td><%= p.getCountry() %></td>
                            <td><%= p.getDni() %></td>
                            <td>
                                <div class="actions">
                                    <button class="btn-sm btn-edit" onclick="editPerson(<%= p.getId() %>,'<%= p.getName().replace("'","\'") %>',<%= p.getAge() %>,'<%= p.getCountry() %>','<%= p.getDni() %>')">Editar</button>
                                    <form action="admin" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar persona?')">
                                        <input type="hidden" name="entity" value="person">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="p_id" value="<%= p.getId() %>">
                                        <button type="submit" class="btn-sm btn-del">Eliminar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <div class="admin-form-box" id="form-edit-persona" style="display:none;">
                    <h3>Editar Persona</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="person">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="p_id" id="edit-p-id">
                        <div class="field-group">
                            <div class="field"><label>Nombre</label><input type="text" name="p_name" id="edit-p-name" required></div>
                            <div class="field"><label>Edad</label><input type="number" name="p_age" id="edit-p-age" min="16" required></div>
                        </div>
                        <div class="field-group">
                            <div class="field"><label>País</label><input type="text" name="p_country" id="edit-p-country" required></div>
                            <div class="field"><label>DNI</label><input type="text" name="p_dni" id="edit-p-dni" required></div>
                        </div>
                        <div class="form-actions">
                            <input type="submit" value="Guardar" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="document.getElementById('form-edit-persona').style.display='none'">Cancelar</button>
                        </div>
                    </form>
                </div>
            </section>

            <!-- MONTURAS -->
            <section class="admin-section" id="sec-monturas">
                <h2>Gestión de Monturas</h2>
                <button class="add-row-btn" onclick="toggleForm('form-montura')">+ Nueva Montura</button>
                <div class="admin-form-box" id="form-montura" style="display:none;">
                    <h3>Crear Montura</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="mount">
                        <input type="hidden" name="action" value="create">
                        <div class="field-group">
                            <div class="field"><label>Nombre</label><input type="text" name="m_name" required></div>
                            <div class="field"><label>Tipo</label><input type="text" name="m_type" required></div>
                        </div>
                        <div class="form-actions">
                            <input type="submit" value="Crear" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="toggleForm('form-montura')">Cancelar</button>
                        </div>
                    </form>
                </div>
                <table class="admin-table">
                    <thead><tr><th>ID</th><th>Nombre</th><th>Tipo</th><th>Acciones</th></tr></thead>
                    <tbody>
                    <% if (mounts != null) for (Mount m : mounts) { %>
                        <tr>
                            <td><%= m.getId() %></td>
                            <td><%= m.getName() %></td>
                            <td><%= m.getType() %></td>
                            <td>
                                <div class="actions">
                                    <button class="btn-sm btn-edit" onclick="editMount(<%= m.getId() %>,'<%= m.getName() %>','<%= m.getType() %>')">Editar</button>
                                    <form action="admin" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar montura?')">
                                        <input type="hidden" name="entity" value="mount">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="m_id" value="<%= m.getId() %>">
                                        <button type="submit" class="btn-sm btn-del">Eliminar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <div class="admin-form-box" id="form-edit-montura" style="display:none;">
                    <h3>Editar Montura</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="mount">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="m_id" id="edit-m-id">
                        <div class="field-group">
                            <div class="field"><label>Nombre</label><input type="text" name="m_name" id="edit-m-name" required></div>
                            <div class="field"><label>Tipo</label><input type="text" name="m_type" id="edit-m-type" required></div>
                        </div>
                        <div class="form-actions">
                            <input type="submit" value="Guardar" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="document.getElementById('form-edit-montura').style.display='none'">Cancelar</button>
                        </div>
                    </form>
                </div>
            </section>

            <!-- PATROCINADORES -->
            <section class="admin-section" id="sec-patrocinadores">
                <h2>Gestión de Patrocinadores</h2>
                <button class="add-row-btn" onclick="toggleForm('form-sponsor')">+ Nuevo Patrocinador</button>
                <div class="admin-form-box" id="form-sponsor" style="display:none;">
                    <h3>Crear Patrocinador</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="sponsor">
                        <input type="hidden" name="action" value="create">
                        <div class="field"><label>Nombre</label><input type="text" name="sp_name" required></div>
                        <div class="form-actions">
                            <input type="submit" value="Crear" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="toggleForm('form-sponsor')">Cancelar</button>
                        </div>
                    </form>
                </div>
                <table class="admin-table">
                    <thead><tr><th>ID</th><th>Nombre</th><th>Acciones</th></tr></thead>
                    <tbody>
                    <% if (sponsors != null) for (Sponsor sp : sponsors) { %>
                        <tr>
                            <td><%= sp.getId() %></td>
                            <td><%= sp.getName() %></td>
                            <td>
                                <div class="actions">
                                    <button class="btn-sm btn-edit" onclick="editSponsor(<%= sp.getId() %>,'<%= sp.getName() %>')">Editar</button>
                                    <form action="admin" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar patrocinador?')">
                                        <input type="hidden" name="entity" value="sponsor">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="sp_id" value="<%= sp.getId() %>">
                                        <button type="submit" class="btn-sm btn-del">Eliminar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <div class="admin-form-box" id="form-edit-sponsor" style="display:none;">
                    <h3>Editar Patrocinador</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="sponsor">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="sp_id" id="edit-sp-id">
                        <div class="field"><label>Nombre</label><input type="text" name="sp_name" id="edit-sp-name" required></div>
                        <div class="form-actions">
                            <input type="submit" value="Guardar" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="document.getElementById('form-edit-sponsor').style.display='none'">Cancelar</button>
                        </div>
                    </form>
                </div>
            </section>

            <!-- USUARIOS -->
            <section class="admin-section" id="sec-usuarios">
                <h2>Gestión de Usuarios</h2>
                <button class="add-row-btn" onclick="toggleForm('form-user')">+ Nuevo Usuario</button>
                <div class="admin-form-box" id="form-user" style="display:none;">
                    <h3>Crear Usuario</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="user">
                        <input type="hidden" name="action" value="create">
                        <div class="field-group">
                            <div class="field"><label>Username</label><input type="text" name="u_username" required></div>
                            <div class="field">
                                <label>Rol</label>
                                <select name="u_role">
                                    <option value="user">user</option>
                                    <option value="admin">admin</option>
                                </select>
                            </div>
                        </div>
                        <div class="field"><label>Passkey (texto plano)</label><input type="text" name="u_passkey" required placeholder="Se guardará como hash SHA-256"></div>
                        <div class="field"><label>Dorsal corredor (opcional)</label><input type="number" name="u_runnerId" min="1"></div>
                        <div class="form-actions">
                            <input type="submit" value="Crear" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="toggleForm('form-user')">Cancelar</button>
                        </div>
                    </form>
                </div>
                <table class="admin-table">
                    <thead><tr><th>ID</th><th>Username</th><th>Rol</th><th>Corredor</th><th>Acciones</th></tr></thead>
                    <tbody>
                    <% if (users != null) for (User u : users) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getUsername() %></td>
                            <td><span class="badge <%= "admin".equals(u.getRole()) ? "badge-ok" : "badge-pending" %>"><%= u.getRole() %></span></td>
                            <td><%= u.getRunnerId() != null ? "#" + u.getRunnerId() : "—" %></td>
                            <td>
                                <div class="actions">
                                    <button class="btn-sm btn-edit" onclick="editUser(<%= u.getId() %>,'<%= u.getUsername() %>','<%= u.getRole() %>','<%= u.getRunnerId() != null ? u.getRunnerId() : "" %>')">Editar</button>
                                    <form action="admin" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar usuario?')">
                                        <input type="hidden" name="entity" value="user">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="u_id" value="<%= u.getId() %>">
                                        <button type="submit" class="btn-sm btn-del">Eliminar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <div class="admin-form-box" id="form-edit-user" style="display:none;">
                    <h3>Editar Usuario</h3>
                    <form action="admin" method="post">
                        <input type="hidden" name="entity" value="user">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="u_id" id="edit-u-id">
                        <div class="field-group">
                            <div class="field"><label>Username</label><input type="text" name="u_username" id="edit-u-username" required></div>
                            <div class="field">
                                <label>Rol</label>
                                <select name="u_role" id="edit-u-role">
                                    <option value="user">user</option>
                                    <option value="admin">admin</option>
                                </select>
                            </div>
                        </div>
                        <div class="field"><label>Nueva passkey (vacío = no cambiar)</label><input type="text" name="u_passkey" placeholder="Dejar vacío para mantener la actual"></div>
                        <div class="field"><label>Dorsal corredor (opcional)</label><input type="number" name="u_runnerId" id="edit-u-runnerId" min="1"></div>
                        <div class="form-actions">
                            <input type="submit" value="Guardar" class="btn btn-save">
                            <button type="button" class="btn btn-reset" onclick="document.getElementById('form-edit-user').style.display='none'">Cancelar</button>
                        </div>
                    </form>
                </div>
            </section>

        </main>
    </div>

    <script>
        function showSection(name) {
            document.querySelectorAll('.admin-section').forEach(s => s.classList.remove('active'));
            document.querySelectorAll('.sidebar-btn').forEach(b => b.classList.remove('active'));
            document.getElementById('sec-' + name).classList.add('active');
            document.getElementById('sb-' + name).classList.add('active');
        }

        function toggleForm(id) {
            const el = document.getElementById(id);
            el.style.display = el.style.display === 'none' ? 'block' : 'none';
        }

        // Runner edit
        function editRunner(bib, points, km, stage) {
            document.getElementById('edit-r-bib').value    = bib;
            document.getElementById('edit-r-points').value = points;
            document.getElementById('edit-r-km').value     = km;
            document.getElementById('edit-r-stage').value  = stage;
            document.getElementById('form-edit-corredor').style.display = 'block';
            document.getElementById('form-edit-corredor').scrollIntoView({behavior:'smooth'});
        }

        // Person edit
        function editPerson(id, name, age, country, dni) {
            document.getElementById('edit-p-id').value      = id;
            document.getElementById('edit-p-name').value    = name;
            document.getElementById('edit-p-age').value     = age;
            document.getElementById('edit-p-country').value = country;
            document.getElementById('edit-p-dni').value     = dni;
            document.getElementById('form-edit-persona').style.display = 'block';
            document.getElementById('form-edit-persona').scrollIntoView({behavior:'smooth'});
        }

        // Mount edit
        function editMount(id, name, type) {
            document.getElementById('edit-m-id').value   = id;
            document.getElementById('edit-m-name').value = name;
            document.getElementById('edit-m-type').value = type;
            document.getElementById('form-edit-montura').style.display = 'block';
            document.getElementById('form-edit-montura').scrollIntoView({behavior:'smooth'});
        }

        // Sponsor edit
        function editSponsor(id, name) {
            document.getElementById('edit-sp-id').value   = id;
            document.getElementById('edit-sp-name').value = name;
            document.getElementById('form-edit-sponsor').style.display = 'block';
            document.getElementById('form-edit-sponsor').scrollIntoView({behavior:'smooth'});
        }

        // User edit
        function editUser(id, username, role, runnerId) {
            document.getElementById('edit-u-id').value       = id;
            document.getElementById('edit-u-username').value = username;
            document.getElementById('edit-u-role').value     = role;
            document.getElementById('edit-u-runnerId').value = runnerId;
            document.getElementById('form-edit-user').style.display = 'block';
            document.getElementById('form-edit-user').scrollIntoView({behavior:'smooth'});
        }

        // Auto-show section from URL hash if present
        const hash = window.location.hash.replace('#','');
        if (hash) { try { showSection(hash); } catch(e) {} }
    </script>
</body>
</html>
