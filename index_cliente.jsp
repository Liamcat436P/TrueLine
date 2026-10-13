<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Validación de sesión y seguridad para el panel de clientes
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("rol") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String rol = sesion.getAttribute("rol").toString().trim().toLowerCase();

    // Si un admin o diseñador intenta entrar aquí, los reenviamos a su zona correspondiente
    if ("admin".equals(rol)) {
        response.sendRedirect("consultar");
        return;
    } else if ("diseñador".equals(rol) || "disenador".equals(rol)) {
        response.sendRedirect("panel_diseno.jsp");
        return;
    }

    // 2. Recuperamos el nombre del usuario logueado
    String usuarioLogueado = (String) sesion.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        usuarioLogueado = "Cliente";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Cliente - TrueLine</title>
    
    <!-- Fuentes y Fuentes de Iconos -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">
</head>
<body>

    <!-- Encabezado Superior -->
    <header class="header">
        <div class="container header-content">
            <a href="#" class="logo-container">
                <img src="IMAGENES/logo de proyecto.png" alt="Logo TrueLine" class="logo-img">
                <span class="logo-text">TrueLine</span>
            </a>
            
            <nav class="top-nav">
    <a href="PerfilServlet" class="btn-nav"><i class="fas fa-user"></i> Ver perfil</a>
    <a href="NotificacionesServlet" class="btn-nav" style="text-decoration: none;"><i class="fas fa-bell"></i> Notificaciones</a>
    <a href="solicitar_servicio.jsp" class="btn-nav btn-accent" style="text-decoration: none;"><i class="fas fa-plus-circle"></i> Solicitar servicio</a>
    <a href="HistorialServlet" class="btn-nav" style="text-decoration: none;"><i class="fas fa-history"></i> Historial</a>
    <a href="index_visitantes.html" class="btn-nav" style="background-color: #ff7675; color: white; text-decoration: none;"><i class="fas fa-sign-out-alt"></i> Salir</a>
</nav>
        </div>
    </header>

    <!-- Contenido Principal -->
    <main class="main-container container">
        
        <!-- Panel de Bienvenida -->
        <section class="welcome-banner">
            <div class="banner-text">
                <h1>Bienvenid@ a TrueLine <span><%= usuarioLogueado %></span></h1>
                <p>Gestione sus soluciones digitales y servicios publicitarios desde su panel principal.</p>
            </div>
        </section>

        <!-- Sección de Servicios (Cuadrícula Horizontal) -->
        <section class="services-section">
            <h2 class="section-title">Servicios Destacados</h2>
            
            <div class="services-grid">
                <div class="service-card">
                    <h3>Branding</h3>
                    <p>Desarrollo de identidad corporativa y diseño de marca.</p>
                    <a href="branding.html" class="btn-primary">Conoce más</a>
                </div>

                <div class="service-card">
                    <h3>Paquete Redes Sociales</h3>
                    <p>Gestión estratégica y creación de contenido visual.</p>
                    <a href="redes.html" class="btn-primary">Conoce más</a>
                </div>

                <div class="service-card">
                    <h3>Consultoría Marketing</h3>
                    <p>Estrategias personalizadas para impulsar su negocio.</p>
                    <a href="mark.html" class="btn-primary">Conoce más</a>
                </div>

                <div class="service-card">
                    <h3>Creación Web</h3>
                    <p>Diseño y desarrollo de páginas web modernas y responsivas.</p>
                    <a href="cre.html" class="btn-primary">Conoce más</a>
                </div>
            </div>
        </section>

        <!-- Elementos Gráficos Secundarios -->
        <section class="media-section">
            <div class="media-container">
                <div class="media-card"><img src="IMAGENES/b.png" alt="Branding Icon"></div>
                <div class="media-card"><img src="IMAGENES/s.png" alt="Social Icon"></div>
                <div class="media-card"><img src="IMAGENES/c.png" alt="Consulting Icon"></div>
            </div>
        </section>

    </main>

    <!-- Pie de página -->
    <footer class="footer">
        <div class="container footer-content">
            <p class="copyright">&copy; TrueLine. Todos los derechos reservados.</p>
            <div class="social-icons">
                <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>

</body>
</html>