<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String usuarioLogueado = (String) sesion.getAttribute("usuarioLogueado");
    String[] datos = (String[]) request.getAttribute("datosUsuario");

    String nombre = (datos != null && datos.length > 1 && datos[1] != null) ? datos[1] : (usuarioLogueado != null ? usuarioLogueado : "");
    String correo = (datos != null && datos.length > 2 && datos[2] != null) ? datos[2] : (String) sesion.getAttribute("correoUsuario");
    if (correo == null) correo = "";
    String telefono = (datos != null && datos.length > 3 && datos[3] != null) ? datos[3] : "";
    String rol = (datos != null && datos.length > 8 && datos[8] != null) ? datos[8] : (String) sesion.getAttribute("rol");
    if (rol == null) rol = "cliente";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - TrueLine</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="IMAGENES/logo de proyecto.png">

    <style>
        .perfil-card {
            background-color: #2b2b2e;
            color: #ffffff;
            padding: 35px;
            border-radius: 25px;
            max-width: 650px;
            margin: 30px auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .perfil-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .perfil-header i {
            font-size: 3.5rem;
            color: #8b5cf6;
            margin-bottom: 10px;
        }

        .perfil-header h2 {
            font-size: 1.8rem;
            margin: 0;
            text-transform: uppercase;
        }

        .form-group {
            margin-bottom: 18px;
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

        /* Estilos para campos bloqueados */
        .form-control[readonly] {
            background-color: #121214;
            color: #888888;
            cursor: not-allowed;
            border-color: #2d2d30;
        }

        .alert-msg {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9rem;
        }

        .alert-success {
            background-color: #059669;
            color: white;
        }

        .alert-error {
            background-color: #dc2626;
            color: white;
        }

        .btn-save {
            display: block;
            width: 100%;
            background-color: #6c5ce7;
            color: #ffffff;
            padding: 12px;
            font-weight: 700;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            text-transform: uppercase;
            font-size: 0.95rem;
            transition: background-color 0.2s ease;
        }

        .btn-save:hover {
            background-color: #5b4bc4;
        }
    </style>
</head>
<body>

    <!-- Encabezado Superior -->
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

    <!-- Contenido Principal -->
    <main class="main-container container">
        
        <div class="perfil-card">
            <div class="perfil-header">
                <i class="fas fa-user-circle"></i>
                <h2>Mi Perfil</h2>
            </div>

            <% if ("true".equals(request.getParameter("exito"))) { %>
                <div class="alert-msg alert-success">
                    <i class="fas fa-check-circle"></i> Datos actualizados correctamente.
                </div>
            <% } else if ("true".equals(request.getParameter("error"))) { %>
                <div class="alert-msg alert-error">
                    <i class="fas fa-exclamation-triangle"></i> Hubo un error al actualizar los datos.
                </div>
            <% } %>

            <form action="PerfilServlet" method="POST">
                
                <!-- Campo Bloqueado: Correo -->
                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Correo Electrónico (No editable)</label>
                    <input type="email" name="correo" class="form-control" value="<%= correo %>" readonly>
                </div>

                <!-- Campo Bloqueado: Rol -->
                <div class="form-group">
                    <label><i class="fas fa-user-shield"></i> Rol en la plataforma (No editable)</label>
                    <input type="text" class="form-control" value="<%= rol != null ? rol : "Cliente" %>" readonly>
                </div>

                <!-- Campo Editable: Nombre -->
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Nombre Completo</label>
                    <input type="text" name="nombre" class="form-control" value="<%= nombre %>" required>
                </div>

                <!-- Campo Editable: Teléfono -->
                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Teléfono / Celular</label>
                    <input type="text" name="telefono" class="form-control" value="<%= telefono %>" required>
                </div>

                <!-- Campo Editable: Nueva Contraseña (Opcional) -->
                <div class="form-group">
                    <label><i class="fas fa-lock"></i> Nueva Contraseña (Opcional)</label>
                    <input type="password" name="contrasena" class="form-control" placeholder="Déjala en blanco si no deseas cambiarla">
                </div>

                <button type="submit" class="btn-save">
                    <i class="fas fa-save"></i> Guardar Cambios
                </button>
            </form>
        </div>

    </main>

    <!-- Pie de página -->
    <footer class="footer">
        <div class="container footer-content">
            <p class="copyright">&copy; TrueLine. Todos los derechos reservados.</p>
        </div>
    </footer>

</body>
</html>