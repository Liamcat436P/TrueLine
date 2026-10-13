<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Validación de seguridad estricta para diseñadores
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("rol") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String rol = sesion.getAttribute("rol").toString().trim().toLowerCase();

    if (!"diseñador".equals(rol) && !"disenador".equals(rol)) {
        response.sendRedirect("index_visitantes.html");
        return;
    }

    // 2. Recuperamos el nombre del usuario para que no dé error en la interfaz
    String usuarioLogueado = (sesion != null) ? (String) sesion.getAttribute("usuarioLogueado") : null;
    if (usuarioLogueado == null) {
        usuarioLogueado = "Diseñador"; // Valor por defecto por seguridad
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">
    <meta charset="UTF-8">
    <title>Panel de Diseñador - TrueLine</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            color: #333;
        }
        /* Barra de navegación superior */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .logo-container {
            display: flex;
            align-items: center;
            font-weight: bold;
            font-size: 20px;
            color: #111;
        }
        .logo-container span {
            color: #6c5ce7;
            margin-left: 8px;
        }
        .nav-links {
            display: flex;
            gap: 10px;
        }
        .nav-btn {
            background-color: #f1f2f6;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            color: #333;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: background 0.2s;
        }
        .nav-btn:hover {
            background-color: #e4e6eb;
        }
        .nav-btn.primary {
            background-color: #6c5ce7;
            color: white;
        }
        .nav-btn.primary:hover {
            background-color: #5b4cc4;
        }

        /* Contenedor principal */
        .main-container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Banner de bienvenida estilo tarjeta oscura */
        .hero-banner {
            background-color: #222225;
            color: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
            margin-bottom: 40px;
        }
        .hero-banner h1 {
            margin: 0 0 10px 0;
            font-size: 28px;
        }
        .hero-banner h1 span {
            color: #8c7ae6;
        }
        .hero-banner p {
            margin: 0;
            color: #b2bec3;
            font-size: 15px;
        }

        /* Sección de contenidos / tarjetas de servicios o tareas */
        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #2d3436;
        }
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }
        .card {
            background-color: #222225;
            color: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .card h3 {
            margin-top: 0;
            font-size: 18px;
        }
        .card p {
            color: #b2bec3;
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        .card-btn {
            background-color: #6c5ce7;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 20px;
            text-align: center;
            text-decoration: none;
            font-weight: 500;
            font-size: 13px;
            transition: background 0.2s;
        }
        .card-btn:hover {
            background-color: #5b4cc4;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 40px 0 20px 0;
            color: #b2bec3;
            font-size: 13px;
            border-top: 1px solid #e1e1e1;
            margin-top: 60px;
        }
    </style>
</head>
<body>

    <!-- Barra de Navegación Superior -->
    <div class="navbar">
        <div class="logo-container">
            <img src="IMAGENES/logo de proyecto.png" alt="Logo TrueLine" class="logo-img">
                <span class="logo-text">TrueLine</span>
                <span>[Diseño]</span>
        </div>
        <div class="nav-links">
            <span class="nav-btn">👤 <%= usuarioLogueado %></span>
            <a href="index_visitantes.html" class="nav-btn primary">Cerrar Sesión</a>
        </div>
    </div>

    <!-- Contenido Principal -->
    <div class="main-container">
        
        <!-- Banner de Bienvenida -->
        <div class="hero-banner">
            <h1>Bienvenido a <span>TrueLine</span></h1>
            <p>Gestione sus soluciones gráficas y proyectos de diseño asignados desde su panel principal de diseñador.</p>
        </div>

        <div class="section-title">Herramientas y Proyectos Activos</div>

        <!-- Cuadrícula de Tarjetas -->
        <div class="cards-grid">
            <div class="card">
                <div>
                    <h3>Branding y Marca</h3>
                    <p>Revisa las solicitudes de identidad corporativa y directrices de diseño enviadas por los clientes.</p>
                </div>
                <a href="ProyectosDisenadorServlet" class="btn-nav" style="background-color: #6c5ce7; color: white; padding: 10px 25px; border-radius: 20px; text-decoration: none; font-weight: 700;">Ver proyectos</a>
            </div>

            <div class="card">
                <div>
                    <h3>Redes Sociales</h3>
                    <p>Gestiona los paquetes visuales, parrillas de contenido y piezas gráficas aprobadas.</p>
                </div>
              <a href="ProyectosDisenadorServlet" class="btn-nav" style="background-color: #6c5ce7; color: white; padding: 10px 25px; border-radius: 20px; text-decoration: none; font-weight: 700;">Ver proyectos</a>
            </div>
            <div class="card">
                <div>
                    <h3>Consultoria Marketing</h3>
                    <p>Gestiona las estrategias para impulsar negocios.</p>
                </div>
                <a href="ProyectosDisenadorServlet" class="btn-nav" style="background-color: #6c5ce7; color: white; padding: 10px 25px; border-radius: 20px; text-decoration: none; font-weight: 700;">Ver proyectos</a>
            </div>

            <div class="card">
                <div>
                    <h3>Creación Web</h3>
                    <p>Inspecciona las maquetas, wireframes y recursos visuales para los desarrollos front-end.</p>
                </div>
                <a href="ProyectosDisenadorServlet" class="btn-nav" style="background-color: #6c5ce7; color: white; padding: 10px 25px; border-radius: 20px; text-decoration: none; font-weight: 700;">Ver proyectos</a>
            </div>
        </div>

    </div>

    <footer>
        &copy; TrueLine. Todos los derechos reservados.
    </footer>

</body>
</html>