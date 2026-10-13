<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ArrayList<String[]> listaSolicitudes = (ArrayList<String[]>) request.getAttribute("listaSolicitudes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de Solicitudes - TrueLine</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">

    <style>
        .historial-container {
            max-width: 900px;
            margin: 30px auto;
            color: #ffffff;
        }
        .historial-header {
            background-color: #2b2b2e;
            padding: 30px;
            border-radius: 20px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .historial-header h1 {
            font-size: 2rem;
            margin: 0;
            text-transform: uppercase;
        }
        .historial-header p {
            color: #8b5cf6;
            font-weight: 600;
            margin-top: 5px;
        }
        .solicitud-card {
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
            border-left: 5px solid #8b5cf6;
        }
        .solicitud-info h3 {
            margin: 0 0 8px 0;
            color: #d8b4fe;
            font-size: 1.2rem;
        }
        .solicitud-info p {
            margin: 4px 0;
            font-size: 0.9rem;
            color: #cbd5e1;
        }
        .solicitud-info p span {
            color: #ffffff;
            font-weight: 600;
        }
        .badge-estado {
            background-color: #3b82f6;
            color: white;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        .empty-history {
            text-align: center;
            background-color: #2b2b2e;
            padding: 40px;
            border-radius: 20px;
            color: #a1a1aa;
        }
        .empty-history i {
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
        <div class="historial-container">
            
            <div class="historial-header">
                <h1>Historial de Solicitudes</h1>
                <p>Revisa el estado de tus servicios solicitados</p>
            </div>

            <% if (listaSolicitudes != null && !listaSolicitudes.isEmpty()) { %>
                <% for (String[] sol : listaSolicitudes) { %>
                    <div class="solicitud-card">
                        <div class="solicitud-info">
                            <h3><i class="fas fa-project-diagram"></i> <%= sol[1] %></h3>
                            <p><span>Detalles:</span> <%= sol[2] %></p>
                            <p><i class="far fa-calendar-alt"></i> Fecha: <span><%= sol[3] %></span></p>
                        </div>
                        <div>
                            <span class="badge-estado"><%= sol[4] %></span>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="empty-history">
                    <i class="fas fa-folder-open"></i>
                    <h3>No tienes solicitudes registradas</h3>
                    <p>Cuando solicites un servicio desde el botón superior, aparecerá listado aquí.</p>
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