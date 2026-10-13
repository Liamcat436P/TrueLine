<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String usuarioLogueado = (String) sesion.getAttribute("usuarioLogueado");
    ArrayList<String[]> listaSolicitudes = (ArrayList<String[]>) request.getAttribute("listaSolicitudes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Proyectos - TrueLine [Diseño]</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">

    <style>
        .container-gestion {
            max-width: 1100px;
            margin: 30px auto;
            color: #ffffff;
        }
        .gestion-header {
            background-color: #2b2b2e;
            padding: 30px;
            border-radius: 20px;
            text-align: center;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .gestion-header h1 {
            font-size: 2rem;
            margin: 0;
            text-transform: uppercase;
        }
        .gestion-header p {
            color: #8b5cf6;
            font-weight: 600;
            margin-top: 5px;
        }
        /* Barra de filtros y búsqueda */
        .filter-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .filter-input, .filter-select {
            flex: 1;
            min-width: 250px;
            padding: 12px 18px;
            border-radius: 15px;
            border: 1px solid #404045;
            background-color: #2b2b2e;
            color: #ffffff;
            font-family: 'Poppins', sans-serif;
            font-size: 0.95rem;
        }
        .filter-input:focus, .filter-select:focus {
            outline: none;
            border-color: #8b5cf6;
        }
        /* Selector de estado específico para cada tarjeta */
        .estado-select {
            padding: 8px 12px;
            border-radius: 10px;
            border: 1px solid #404045;
            background-color: #1e1e21;
            color: #8b5cf6;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
        }
        .estado-select:focus {
            outline: none;
            border-color: #8b5cf6;
        }
        /* Tarjetas de proyectos */
        .proyecto-card {
            background-color: #2b2b2e;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            border-left: 5px solid #8b5cf6;
            transition: transform 0.2s ease;
        }
        .proyecto-card:hover {
            transform: translateY(-2px);
        }
        .proyecto-info {
            flex: 1;
            min-width: 300px;
        }
        .proyecto-info h3 {
            margin: 0 0 8px 0;
            color: #d8b4fe;
            font-size: 1.25rem;
        }
        .proyecto-info p {
            margin: 5px 0;
            font-size: 0.9rem;
            color: #cbd5e1;
        }
        .proyecto-info p span {
            color: #ffffff;
            font-weight: 600;
        }
        .proyecto-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 12px;
        }
        .badge-servicio {
            background-color: #6c5ce7;
            color: white;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        /* Formulario de carga de archivos */
        .upload-form {
            display: flex;
            gap: 8px;
            align-items: center;
            background-color: #1e1e21;
            padding: 8px 12px;
            border-radius: 12px;
            border: 1px solid #404045;
        }
        .upload-input {
            font-size: 0.8rem;
            color: #cbd5e1;
            width: 190px;
        }
        .btn-upload {
            background-color: #8b5cf6;
            color: #ffffff;
            border: none;
            padding: 8px 14px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.85rem;
            transition: background-color 0.2s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .btn-upload:hover {
            background-color: #7c3aed;
        }
        .alert-success {
            background-color: #059669;
            color: white;
            padding: 12px;
            border-radius: 12px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
        }
        .empty-state {
            text-align: center;
            background-color: #2b2b2e;
            padding: 50px;
            border-radius: 20px;
            color: #a1a1aa;
        }
        .empty-state i {
            font-size: 3.5rem;
            color: #8b5cf6;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="container header-content">
            <a href="panel_diseno.jsp" class="logo-container" style="text-decoration: none;">
                <img src="IMAGENES/logo de proyecto.png" alt="Logo TrueLine" class="logo-img">
                <span class="logo-text">TrueLine [Diseño]</span>
            </a>
            <nav class="top-nav">
                <a href="panel_diseno.jsp" class="btn-nav"><i class="fas fa-arrow-left"></i> Volver al Panel</a>
            </nav>
        </div>
    </header>

    <main class="main-container container">
        <div class="container-gestion">
            
            <div class="gestion-header">
                <h1>Panel Central de Proyectos</h1>
                <p>Busca, filtra y gestiona todas las solicitudes enviadas por los clientes</p>
            </div>

            <% if ("true".equals(request.getParameter("subido"))) { %>
                <div class="alert-success">
                    <i class="fas fa-check-circle"></i> Archivo subido con éxito. El cliente lo verá reflejado en sus notificaciones.
                </div>
            <% } else if ("true".equals(request.getParameter("estadoActualizado"))) { %>
                <div class="alert-success">
                    <i class="fas fa-sync-alt"></i> Estado actualizado con éxito.
                </div>
            <% } %>

            <!-- Controles de Búsqueda y Filtro -->
            <div class="filter-bar">
                <input type="text" id="inputBusqueda" class="filter-input" placeholder="🔍 Buscar por cliente, correo o negocio..." onkeyup="filtrarProyectos()">
                
                <select id="filtroServicio" class="filter-select" onchange="filtrarProyectos()">
                    <option value="">📂 Todos los servicios</option>
                    <option value="Branding y Marca">Branding y Marca</option>
                    <option value="Redes Sociales">Redes Sociales</option>
                    <option value="Consultoría Marketing">Consultoría Marketing</option>
                    <option value="Creación Web">Creación Web</option>
                </select>
            </div>

            <!-- Contenedor de la lista de solicitudes -->
            <div id="listaProyectos">
                <% if (listaSolicitudes != null && !listaSolicitudes.isEmpty()) { %>
                    <% for (String[] sol : listaSolicitudes) { %>
                        <div class="proyecto-card" data-servicio="<%= sol[3] %>">
                            <div class="proyecto-info">
                                <h3><i class="fas fa-briefcase"></i> <%= sol[4] %></h3>
                                <p><i class="fas fa-user"></i> Cliente: <span><%= sol[2] %></span> (<%= sol[1] %>)</p>
                                <p><i class="far fa-calendar-alt"></i> Fecha de solicitud: <span><%= sol[5] %></span></p>
                            </div>
                            <div class="proyecto-actions">
                                <span class="badge-servicio"><%= sol[3] %></span>
                                
                                <!-- Formulario para actualizar el estado del proyecto -->
                                <form action="ActualizarEstadoServlet" method="POST" style="display: flex; gap: 8px; align-items: center;">
                                    <input type="hidden" name="solicitudId" value="<%= sol[0] %>">
                                    <label style="font-size: 0.85rem; color: #cbd5e1; font-weight: 500;">Estado:</label>
                                    <select name="nuevoEstado" class="estado-select" onchange="this.form.submit()">
                                        <option value="Pendiente" <%= "Pendiente".equalsIgnoreCase(sol[6]) ? "selected" : "" %>>Pendiente</option>
                                        <option value="En Proceso" <%= "En Proceso".equalsIgnoreCase(sol[6]) ? "selected" : "" %>>En Proceso</option>
                                        <option value="En Revisión" <%= "En Revisión".equalsIgnoreCase(sol[6]) ? "selected" : "" %>>En Revisión</option>
                                        <option value="Completado" <%= "Completado".equalsIgnoreCase(sol[6]) ? "selected" : "" %>>Completado</option>
                                    </select>
                                </form>

                                <!-- Formulario multipart para adjuntar archivos directamente a esta solicitud -->
                                <form action="SubirArchivoServlet" method="POST" enctype="multipart/form-data" class="upload-form">
                                    <input type="hidden" name="solicitudId" value="<%= sol[0] %>">
                                    <input type="hidden" name="correoCliente" value="<%= sol[1] %>">
                                    <input type="file" name="archivo" class="upload-input" required>
                                    <button type="submit" class="btn-upload">
                                        <i class="fas fa-upload"></i> Subir
                                    </button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-folder-open"></i>
                        <h3>No hay solicitudes en este momento</h3>
                        <p>Los proyectos enviados por los clientes aparecerán listados aquí automáticamente.</p>
                    </div>
                <% } %>
            </div>

        </div>
    </main>

    <footer class="footer">
        <div class="container footer-content">
            <p class="copyright">&copy; TrueLine. Todos los derechos reservados.</p>
        </div>
    </footer>

    <!-- Script de filtrado instantáneo -->
    <script>
        function filtrarProyectos() {
            let query = document.getElementById("inputBusqueda").value.toLowerCase();
            let servicioSeleccionado = document.getElementById("filtroServicio").value.toLowerCase();
            let cards = document.getElementsByClassName("proyecto-card");

            for (let i = 0; i < cards.length; i++) {
                let textoCompleto = cards[i].innerText.toLowerCase();
                let servicioCard = cards[i].getAttribute("data-servicio").toLowerCase();

                let coincideBusqueda = textoCompleto.includes(query);
                let coincideServicio = (servicioSeleccionado === "" || servicioCard.includes(servicioSeleccionado));

                if (coincideBusqueda && coincideServicio) {
                    cards[i].style.display = "";
                } else {
                    cards[i].style.display = "none";
                }
            }
        }
    </script>

</body>
</html>