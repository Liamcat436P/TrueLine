<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String usuarioLogueado = (String) sesion.getAttribute("usuarioLogueado");
    ArrayList<String[]> listaArchivos = (ArrayList<String[]>) request.getAttribute("listaArchivos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notificaciones y Archivos - TrueLine</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">

    <style>
        .notif-container {
            max-width: 900px;
            margin: 30px auto;
            color: #ffffff;
        }
        .notif-header {
            background-color: #2b2b2e;
            padding: 30px;
            border-radius: 20px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .notif-header h1 {
            font-size: 2rem;
            margin: 0;
            text-transform: uppercase;
        }
        .notif-header p {
            color: #8b5cf6;
            font-weight: 600;
            margin-top: 5px;
        }
        .notif-card {
            background-color: #2b2b2e;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            border-left: 5px solid #10b981;
        }
        .notif-info h3 {
            margin: 0 0 8px 0;
            color: #d8b4fe;
            font-size: 1.2rem;
        }
        .notif-info p {
            margin: 4px 0;
            font-size: 0.9rem;
            color: #cbd5e1;
        }
        .notif-info span {
            color: #ffffff;
            font-weight: 600;
        }
        .btn-download {
            background-color: #10b981;
            color: white;
            padding: 10px 20px;
            border-radius: 15px;
            text-decoration: none;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background-color 0.2s ease;
        }
        .btn-download:hover {
            background-color: #059669;
        }
        .empty-notif {
            text-align: center;
            background-color: #2b2b2e;
            padding: 40px;
            border-radius: 20px;
            color: #a1a1aa;
        }
        .empty-notif i {
            font-size: 3rem;
            color: #8b5cf6;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="container header-content">
            <a href="index_cliente.jsp" class="logo-container" style="text-decoration: none;">
                <img src="IMAGENES/logo de proyecto.png" alt="Logo TrueLine" class="logo-img">
                <span class="logo-text">TrueLine</span>
            </a>
            <nav class="top-nav">
                <a href="index_cliente.jsp" class="btn-nav"><i class="fas fa-arrow-left"></i> Volver al Panel</a>
            </nav>
        </div>
    </header>

    <main class="main-container container">
        <div class="notif-container">
            
            <div class="notif-header">
                <h1>Notificaciones y Entregas</h1>
                <p>Archivos y recursos compartidos por el equipo de diseño para tus proyectos</p>
            </div>

            <% if (listaArchivos != null && !listaArchivos.isEmpty()) { %>
                <% for (String[] arch : listaArchivos) { %>
                    <div class="notif-card">
                        <div class="notif-info">
                            <h3><i class="fas fa-file-alt"></i> <%= arch[1] %></h3>
                            <p><span>Servicio:</span> <%= arch[3] %> (<%= arch[4] %>)</p>
                            <p><i class="far fa-clock"></i> Recibido el: <span><%= arch[2] %></span></p>
                        </div>
                        <div>
                            <!-- Enlace para descargar o abrir el archivo desde la carpeta uploads del servidor -->
                            <a href="uploads/<%= arch[1] %>" download="<%= arch[1] %>" class="btn-download">
                                <i class="fas fa-download"></i> Descargar Archivo
                            </a>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="empty-notif">
                    <i class="fas fa-bell-slash"></i>
                    <h3>No tienes notificaciones ni archivos nuevos</h3>
                    <p>Cuando el diseñador suba entregables para tus solicitudes, aparecerán aquí.</p>
                </div>
            <% } %>

        </div>
    </main>

    <footer class="footer">
        <div class="container footer-content">
            <p class="copyright">&copy; TrueLine. Todos los derechos reservados.</p>
        </div>
    </footer>

</body>
</html>