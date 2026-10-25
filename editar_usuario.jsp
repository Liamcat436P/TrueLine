<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Recuerda: el objeto "usuario" viene del EditarServlet --%>
<% String[] u = (String[]) request.getAttribute("usuario"); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario - TrueLine</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px;
        }
        .contenedor-form {
            background: #ffffff;
            max-width: 500px;
            margin: 0 auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .campo {
            margin-bottom: 15px;
        }
        .campo label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        .campo input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn-guardar {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            margin-top: 10px;
        }
        .btn-guardar:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="contenedor-form">
        <h2>Editar Usuario</h2>

        <form action="ActualizarServlet" method="POST">
            <input type="hidden" name="cedula" value="<%= u[0] %>">
            
            <div class="campo">
                <label>Cédula:</label>
                <input type="text" value="<%= u[0] %>" disabled>
            </div>
            
            <div class="campo">
                <label>Nombre:</label>
                <input type="text" name="nombre" value="<%= u[1] %>">
            </div>
            
            <div class="campo">
                <label>Correo:</label>
                <input type="email" name="correo" value="<%= u[2] %>">
            </div>
            
            <div class="campo">
                <label>Teléfono:</label>
                <input type="text" name="telefono" value="<%= u[3] %>">
            </div>
            
            <div class="campo">
                <label>Empresa:</label>
                <input type="text" name="empresa" value="<%= u[4] %>">
            </div>
            
            <div class="campo">
                <label>Servicio:</label>
                <input type="text" name="servicio" value="<%= u[5] %>">
            </div>
            
            <div class="campo">
                <label>Fecha Nacimiento:</label>
                <input type="date" name="nacimiento" value="<%= u[6] %>">
            </div>

            <div class="campo">
                <label>Contraseña:</label>
                <input type="text" name="contrasena" value="<%= u[7] %>">
            </div>
            
            <button type="submit" class="btn-guardar">Guardar Cambios</button>
        </form>
    </div>

</body>
</html>