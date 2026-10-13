<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || !"admin".equalsIgnoreCase((String) sesion.getAttribute("rol"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String usuarioLogueado = (String) sesion.getAttribute("usuarioLogueado");

    int totalClientes = (int) request.getAttribute("totalClientes");
    int totalDisenadores = (int) request.getAttribute("totalDisenadores");
    int totalSolicitudes = (int) request.getAttribute("totalSolicitudes");
    int completados = (int) request.getAttribute("completados");

    ArrayList<String[]> listaSolicitudes = (ArrayList<String[]>) request.getAttribute("listaSolicitudes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración - TrueLine</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">

    <style>
        .admin-container {
            max-width: 1200px;
            margin: 30px auto;
            color: #ffffff;
        }
        .admin-header {
            background-color: #2b2b2e;
            padding: 30px;
            border-radius: 20px;
            text-align: center;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .admin-header h1 {
            font-size: 2rem;
            margin: 0;
            text-transform: uppercase;
        }
        .admin-header p {
            color: #8b5cf6;
            font-weight: 600;
            margin-top: 5px;
        }
        /* Grid de Métricas */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .metric-card {
            background-color: #2b2b2e;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 20px;
            border-left: 5px solid #8b5cf6;
        }
        .metric-icon {
            font-size: 2.5rem;
            color: #8b5cf6;
        }
        .metric-info h3 {
            margin: 0;
            font-size: 1.8rem;
            color: #ffffff;
        }
        .metric-info p {
            margin: 2px 0 0 0;
            font-size: 0.85rem;
            color: #cbd5e1;
        }
        /* Botones de navegación principal */
        .crud-nav {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }
        .btn-crud {
            background-color: #6c5ce7;
            color: white;
            padding: 12px 25px;
            border-radius: 15px;
            text-decoration: none;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: background-color 0.2s ease;
        }
        .btn-crud:hover {
            background-color: #5b4bc4;
        }
        /* Tabla de Solicitudes */
        .table-card {
            background-color: #2b2b2e;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .table-card h2 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #d8b4fe;
            font-size: 1.3rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            color: #cbd5e1;
            font-size: 0.9rem;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #404045;
        }
        th {
            color: #8b5cf6;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.8rem;
        }
        tr:hover {
            background-color: #353539;
        }
        .badge-status {
            padding: 4px 10px;
            border-radius: 10px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            background-color: #3b82f6;
            color: white;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="container header-content">
            <a href="AdminDashboardServlet" class="logo-container" style="text-decoration: none;">
                <img src="IMAGENES/logo de proyecto.png" alt="Logo TrueLine" class="logo-img">
                <span class="logo-text">TrueLine [Admin]</span>
            </a>
            <nav class="top-nav">
                <a href="consultar" class="btn-nav"><i class="fas fa-users-cog"></i> Gestión de Usuarios (CRUD)</a>
                <a href="index_visitantes.html" class="btn-nav btn-accent"><i class="fas fa-sign-out-alt"></i> Salir</a>
            </nav>
        </div>
    </header>

    <main class="main-container container">
        <div class="admin-container">
            
            <div class="admin-header">
                <h1>Panel de Control Administrador</h1>
                <p>Bienvenido, <%= usuarioLogueado %> — Resumen general de la plataforma TrueLine</p>
            </div>

            <!-- Métricas -->
            <div class="metrics-grid">
                <div class="metric-card">
                    <i class="fas fa-user-friends metric-icon"></i>
                    <div class="metric-info">
                        <h3><%= totalClientes %></h3>
                        <p>Clientes Registrados</p>
                    </div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-paint-brush metric-icon"></i>
                    <div class="metric-info">
                        <h3><%= totalDisenadores %></h3>
                        <p>Diseñadores Activos</p>
                    </div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-folder-open metric-icon"></i>
                    <div class="metric-info">
                        <h3><%= totalSolicitudes %></h3>
                        <p>Total de Solicitudes</p>
                    </div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-check-circle metric-icon"></i>
                    <div class="metric-info">
                        <h3><%= completados %></h3>
                        <p>Proyectos Finalizados</p>
                    </div>
                </div>
            </div>

            <!-- Botones de Navegación del Admin -->
            <div class="crud-nav">
                <a href="consultar" class="btn-crud">
                    <i class="fas fa-user-edit"></i> Administrar Cuentas de Usuario (CRUD)
                </a>
            </div>

            <!-- Registro Global de Solicitudes -->
            <div class="table-card">
                <h2><i class="fas fa-list-alt"></i> Control Global de Solicitudes</h2>
                <% if (listaSolicitudes != null && !listaSolicitudes.isEmpty()) { %>
                    <table>
                        <thead>
                            <tr>
                                <th># ID</th>
                                <th>Cliente</th>
                                <th>Correo</th>
                                <th>Servicio</th>
                                <th>Fecha</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (String[] sol : listaSolicitudes) { %>
                                <tr>
                                    <td>#<%= sol[0] %></td>
                                    <td><strong><%= sol[2] %></strong></td>
                                    <td><%= sol[1] %></td>
                                    <td><%= sol[3] %></td>
                                    <td><%= sol[5] %></td>
                                    <td><span class="badge-status"><%= sol[6] %></span></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p style="text-align: center; color: #a1a1aa;">No hay solicitudes registradas en el sistema.</p>
                <% } %>
            </div>

        </div>
    </main>

    <footer class="footer">
        <div class="container footer-content">
            <p class="copyright">&copy; TrueLine. Panel de Administración.</p>
        </div>
    </footer>

</body>
</html>