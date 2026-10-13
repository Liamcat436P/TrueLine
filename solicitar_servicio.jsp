<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String usuarioLogueado = (String) sesion.getAttribute("usuarioLogueado");
    String correoUsuario = (String) sesion.getAttribute("correoUsuario");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitar Servicio - TrueLine</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">

    <style>
        .form-card {
            background-color: #2b2b2e;
            color: #ffffff;
            padding: 35px;
            border-radius: 25px;
            max-width: 650px;
            margin: 30px auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        .form-header {
            text-align: center;
            margin-bottom: 25px;
        }
        .form-header i {
            font-size: 3rem;
            color: #8b5cf6;
            margin-bottom: 10px;
        }
        .form-header h2 {
            font-size: 1.8rem;
            margin: 0;
            text-transform: uppercase;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 0.88rem;
            color: #d8b4fe;
            margin-bottom: 6px;
            font-weight: 600;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border-radius: 12px;
            border: 1px solid #404045;
            background-color: #1e1e21;
            color: #ffffff;
            font-family: 'Poppins', sans-serif;
            font-size: 0.95rem;
            box-sizing: border-box;
        }
        .form-control:focus {
            outline: none;
            border-color: #8b5cf6;
        }
        textarea.form-control {
            resize: vertical;
            height: 120px;
        }
        .btn-submit {
            display: block;
            width: 100%;
            background-color: #6c5ce7;
            color: #ffffff;
            padding: 14px;
            font-weight: 700;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            text-transform: uppercase;
            font-size: 0.95rem;
            transition: background-color 0.2s ease;
        }
        .btn-submit:hover {
            background-color: #5b4bc4;
        }
        .alert-success {
            background-color: #059669;
            color: white;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9rem;
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
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-folder-plus"></i>
                <h2>Solicitar Nuevo Servicio</h2>
            </div>

            <% if ("true".equals(request.getParameter("exito"))) { %>
                <div class="alert-success">
                    <i class="fas fa-check-circle"></i> ¡Solicitud enviada con éxito! La verás reflejada en tu historial.
                </div>
            <% } %>

            <form action="SolicitarServicioServlet" method="POST">
                
                <input type="hidden" name="correo" value="<%= correoUsuario != null ? correoUsuario : "" %>">
                <input type="hidden" name="nombre" value="<%= usuarioLogueado %>">

                <div class="form-group">
                    <label><i class="fas fa-concierge-bell"></i> Seleccione el Servicio Destacado</label>
                    <select name="servicio" class="form-control" required>
                        <option value="" disabled selected>-- Elige una opción --</option>
                        <option value="Branding y Marca">Branding y Marca</option>
                        <option value="Redes Sociales">Redes Sociales (Paquete RRSS)</option>
                        <option value="Consultoría Marketing">Consultoría Marketing</option>
                        <option value="Creación Web">Creación Web</option>
                    </select>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-building"></i> Razón Social, Nombre del Negocio o Proyecto</label>
                    <input type="text" name="negocio" class="form-control" placeholder="Ej: Café Aroma y Formas Spa" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-comment-dots"></i> Detalles, objetivos o visión de lo que necesitas</label>
                    <textarea name="detalles" class="form-control" placeholder="Describe brevemente lo que buscas lograr con este servicio..." required></textarea>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Enviar Solicitud
                </button>
            </form>
        </div>
    </main>

    <footer class="footer">
        <div class="container footer-content">
            <p class="copyright">&copy; TrueLine. Todos los derechos reservados.</p>
        </div>
    </footer>

</body>
</html>