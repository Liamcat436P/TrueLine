<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Acceso TrueLine</title>
    <link rel="stylesheet" href="style1.css"> 
</head>
<body>

    <div class="form-container">
        <h2>Iniciar Sesión</h2>

        <% 
            String error = request.getParameter("error");
            if ("true".equals(error)) { 
        %>
            <div style="background-color: #ffcccc; color: #cc0000; padding: 10px; border-radius: 15px; text-align: center; margin-bottom: 15px; font-weight: 600;">
                ❌ Credenciales incorrectas o usuario inexistente.
            </div>
        <% } %>

        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label>Correo Electrónico</label>
                <input type="email" name="correo" required placeholder="ejemplo@trueline.com">
            </div>

            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" name="contrasena" required placeholder="•••••••••••••">
            </div>

            <button type="submit">Entrar al Sistema</button>
        </form>

        <a href="registro.html" class="back-link">¿No tienes cuenta? Regístrate aquí</a>
    </div>

</body>
</html>