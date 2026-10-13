import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestorUsuarios {

    // --- MÉTODO PRIVADO PARA ENCRIPTAR CONTRASEÑAS (SHA-256) ---
    private String encriptarSHA256(String textoOriginal) {
        try {
            java.security.MessageDigest motor = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = motor.digest(textoOriginal.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder resultadoHex = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    resultadoHex.append('0');
                }
                resultadoHex.append(hex);
            }
            return resultadoHex.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            System.out.println("Error crítico: No se encontró el algoritmo de encriptación.");
            e.printStackTrace();
            return textoOriginal;
        }
    }

    // 1. MÉTODO PARA REGISTRAR (Recibe 8 datos del formulario; asigna 'cliente' por defecto)
    public void registrarUsuario(String nombre, String correo, String telefono, String empresa, String tipo_servicio, String cedula, String fecha_nacimiento, String contrasena) {
        
        String contrasenaSegura = encriptarSHA256(contrasena);
        
        System.out.println("\n--- INICIANDO REGISTRO DE USUARIO ---");
        System.out.println("Intentando registrar a: " + nombre + " (Cédula: " + cedula + ")");
        
        Conexion conexionDB = new Conexion();
        Connection conexion = conexionDB.conectar();
        
        if (conexion == null) {
            System.out.println("ERROR CRÍTICO: No hay conexión a la base de datos.");
            return;
        }

        String sql = "INSERT INTO usuarios (nombre, correo, telefono, empresa, tipo_servicio, cedula, fecha_nacimiento, contrasena, tipo_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'cliente')";
        
        try {
            System.out.println("Conexión exitosa. Preparando la orden SQL...");
            PreparedStatement orden = conexion.prepareStatement(sql);
            orden.setString(1, nombre);
            orden.setString(2, correo);
            orden.setString(3, telefono);
            orden.setString(4, empresa);
            orden.setString(5, tipo_servicio);
            orden.setString(6, cedula);
            orden.setString(7, fecha_nacimiento);
            orden.setString(8, contrasenaSegura);
            
            System.out.println("Enviando datos a MySQL...");
            int filasAfectadas = orden.executeUpdate();
            
            System.out.println("¡OPERACIÓN EXITOSA! Filas guardadas: " + filasAfectadas);
            
            orden.close();
            conexion.close();
        } catch (SQLException e) {
            System.out.println(">>> ERROR SQL AL GUARDAR <<<");
            System.out.println("Motivo exacto del rechazo: " + e.getMessage());
        }
        System.out.println("--- FIN DEL INTENTO DE REGISTRO ---\n");
    }

    // 2. MÉTODO PARA LISTAR USUARIOS (Incluye el campo tipo_usuario)
    public ArrayList<String[]> listarUsuarios() {
        ArrayList<String[]> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql);
             ResultSet resultados = orden.executeQuery()) {
            while (resultados.next()) {
                String[] usuario = new String[9]; 
                usuario[0] = resultados.getString("cedula");
                usuario[1] = resultados.getString("nombre");
                usuario[2] = resultados.getString("correo");
                usuario[3] = resultados.getString("telefono");
                usuario[4] = resultados.getString("empresa");
                usuario[5] = resultados.getString("tipo_servicio");
                usuario[6] = resultados.getString("fecha_nacimiento");
                usuario[7] = resultados.getString("contrasena"); 
                usuario[8] = resultados.getString("tipo_usuario");
                lista.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // 3. MÉTODO PARA OBTENER UN SOLO USUARIO POR CÉDULA
    public String[] obtenerUsuarioPorCedula(String cedula) {
        String[] usuario = null;
        String sql = "SELECT * FROM usuarios WHERE cedula = ?";
        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            orden.setString(1, cedula);
            ResultSet rs = orden.executeQuery();
            if (rs.next()) {
                usuario = new String[9]; 
                usuario[0] = rs.getString("cedula");
                usuario[1] = rs.getString("nombre");
                usuario[2] = rs.getString("correo");
                usuario[3] = rs.getString("telefono");
                usuario[4] = rs.getString("empresa");
                usuario[5] = rs.getString("tipo_servicio");
                usuario[6] = rs.getString("fecha_nacimiento");
                usuario[7] = rs.getString("contrasena"); 
                usuario[8] = rs.getString("tipo_usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    // 4. MÉTODO PARA OBTENER UN USUARIO POR CORREO (Útil para el perfil del cliente)
    public String[] obtenerUsuarioPorCorreo(String correo) {
        String[] usuario = null;
        String sql = "SELECT * FROM usuarios WHERE correo = ?";
        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            orden.setString(1, correo);
            ResultSet rs = orden.executeQuery();
            if (rs.next()) {
                usuario = new String[9];
                usuario[0] = rs.getString("cedula");
                usuario[1] = rs.getString("nombre");
                usuario[2] = rs.getString("correo");
                usuario[3] = rs.getString("telefono");
                usuario[4] = rs.getString("empresa");
                usuario[5] = rs.getString("tipo_servicio");
                usuario[6] = rs.getString("fecha_nacimiento");
                usuario[7] = rs.getString("contrasena");
                usuario[8] = rs.getString("tipo_usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    // 5. MÉTODO PARA ACTUALIZAR DATOS DE USUARIO (ADMIN)
    public void actualizarUsuario(String cedula, String nombre, String correo, String telefono, String empresa, String servicio, String nacimiento, String contrasena) {
        String contrasenaSegura = encriptarSHA256(contrasena);
        String sql = "UPDATE usuarios SET nombre=?, correo=?, telefono=?, empresa=?, tipo_servicio=?, fecha_nacimiento=?, contrasena=? WHERE cedula=?";
        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            orden.setString(1, nombre);
            orden.setString(2, correo);
            orden.setString(3, telefono);
            orden.setString(4, empresa);
            orden.setString(5, servicio);
            orden.setString(6, nacimiento);
            orden.setString(7, contrasenaSegura);
            orden.setString(8, cedula);    
            orden.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 6. MÉTODO PARA ACTUALIZAR EL PERFIL DEL CLIENTE
    public boolean actualizarPerfilCliente(String correo, String nombre, String telefono, String nuevaContrasena) {
        boolean exito = false;
        String sql;
        boolean cambiarPassword = (nuevaContrasena != null && !nuevaContrasena.trim().isEmpty());

        if (cambiarPassword) {
            sql = "UPDATE usuarios SET nombre = ?, telefono = ?, contrasena = ? WHERE correo = ?";
        } else {
            sql = "UPDATE usuarios SET nombre = ?, telefono = ? WHERE correo = ?";
        }

        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            orden.setString(1, nombre);
            orden.setString(2, telefono);
            if (cambiarPassword) {
                orden.setString(3, encriptarSHA256(nuevaContrasena));
                orden.setString(4, correo);
            } else {
                orden.setString(3, correo);
            }

            int filas = orden.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exito;
    }

    // 7. MÉTODO PARA ELIMINAR USUARIO
    public void eliminarUsuario(String cedula) {
        String sql = "DELETE FROM usuarios WHERE cedula = ?";
        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            orden.setString(1, cedula);
            orden.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 8. MÉTODO PARA VALIDAR EL INICIO DE SESIÓN
    public String[] validarIngreso(String correo, String contrasenaPlana) {
        String contrasenaEncriptada = encriptarSHA256(contrasenaPlana);
        String[] usuario = null;
        
        String sql = "SELECT * FROM usuarios WHERE correo = ? AND contrasena = ?";
        Conexion conexionDB = new Conexion();
        
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            
            orden.setString(1, correo);
            orden.setString(2, contrasenaEncriptada);
            
            ResultSet rs = orden.executeQuery();
            if (rs.next()) {
                usuario = new String[9];
                usuario[0] = rs.getString("cedula");
                usuario[1] = rs.getString("nombre");
                usuario[2] = rs.getString("correo");
                usuario[3] = rs.getString("telefono");
                usuario[4] = rs.getString("empresa");
                usuario[5] = rs.getString("tipo_servicio");
                usuario[6] = rs.getString("fecha_nacimiento");
                usuario[7] = rs.getString("contrasena");
                usuario[8] = rs.getString("tipo_usuario"); 
            }
        } catch (SQLException e) {
            System.out.println("Error al validar ingreso: " + e.getMessage());
            e.printStackTrace();
        }
        return usuario; 
    }
    // MÉTODO PARA OBTENER TODAS LAS SOLICITUDES (PANEL DE DISEÑADOR)
public ArrayList<String[]> obtenerTodasLasSolicitudes() {
    ArrayList<String[]> lista = new ArrayList<>();
    String sql = "SELECT * FROM solicitudes ORDER BY fecha DESC";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql);
         ResultSet rs = orden.executeQuery()) {
        while (rs.next()) {
            String[] solicitud = new String[7];
            solicitud[0] = rs.getString("id");
            solicitud[1] = rs.getString("correo_cliente");
            solicitud[2] = rs.getString("nombre_cliente");
            solicitud[3] = rs.getString("servicio");
            solicitud[4] = rs.getString("negocio_razon");
            solicitud[5] = rs.getString("fecha");
            solicitud[6] = rs.getString("estado");
            lista.add(solicitud);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}
// Registrar un archivo subido por el diseñador
public void guardarArchivoProyecto(int solicitudId, String correoCliente, String nombreArchivo) {
    String sql = "INSERT INTO archivos_proyecto (solicitud_id, correo_cliente, nombre_archivo) VALUES (?, ?, ?)";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql)) {
        orden.setInt(1, solicitudId);
        orden.setString(2, correoCliente);
        orden.setString(3, nombreArchivo);
        orden.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
// MÉTODO PARA CONTAR USUARIOS POR ROL
public int contarUsuariosPorRol(String rol) {
    int total = 0;
    String sql = "SELECT COUNT(*) FROM usuarios WHERE tipo_usuario = ?";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql)) {
        orden.setString(1, rol);
        ResultSet rs = orden.executeQuery();
        if (rs.next()) {
            total = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return total;
}

// MÉTODO PARA CONTAR SOLICITUDES SEGÚN SU ESTADO
public int contarSolicitudesPorEstado(String estado) {
    int total = 0;
    String sql = (estado == null) ? "SELECT COUNT(*) FROM solicitudes" : "SELECT COUNT(*) FROM solicitudes WHERE estado = ?";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql)) {
        if (estado != null) {
            orden.setString(1, estado);
        }
        ResultSet rs = orden.executeQuery();
        if (rs.next()) {
            total = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return total;
}

// MÉTODO PARA ELIMINAR UNA SOLICITUD (ADMIN)
public void eliminarSolicitud(int id) {
    String sql = "DELETE FROM solicitudes WHERE id = ?";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql)) {
        orden.setInt(1, id);
        orden.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
// MÉTODO PARA ACTUALIZAR EL ESTADO DE UNA SOLICITUD
public void actualizarEstadoSolicitud(int id, String estado) {
    String sql = "UPDATE solicitudes SET estado = ? WHERE id = ?";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql)) {
        orden.setString(1, estado);
        orden.setInt(2, id);
        orden.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
// Obtener los archivos destinados a un cliente específico (para sus notificaciones)
public ArrayList<String[]> obtenerArchivosPorCliente(String correo) {
    ArrayList<String[]> lista = new ArrayList<>();
    String sql = "SELECT a.*, s.servicio, s.negocio_razon FROM archivos_proyecto a JOIN solicitudes s ON a.solicitud_id = s.id WHERE a.correo_cliente = ? ORDER BY a.fecha DESC";
    Conexion conexionDB = new Conexion();
    try (Connection conexion = conexionDB.conectar();
         PreparedStatement orden = conexion.prepareStatement(sql)) {
        orden.setString(1, correo);
        ResultSet rs = orden.executeQuery();
        while (rs.next()) {
            String[] archivo = new String[5];
            archivo[0] = rs.getString("id");
            archivo[1] = rs.getString("nombre_archivo");
            archivo[2] = rs.getString("fecha");
            archivo[3] = rs.getString("servicio");
            archivo[4] = rs.getString("negocio_razon");
            lista.add(archivo);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}
    // 9. MÉTODO PARA OBTENER LAS SOLICITUDES DE UN CLIENTE ESPECÍFICO
    public ArrayList<String[]> obtenerSolicitudesPorCorreo(String correo) {
        ArrayList<String[]> lista = new ArrayList<>();
        String sql = "SELECT * FROM solicitudes WHERE correo_cliente = ? ORDER BY fecha DESC";
        Conexion conexionDB = new Conexion();
        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            orden.setString(1, correo);
            ResultSet rs = orden.executeQuery();
            while (rs.next()) {
                String[] solicitud = new String[5];
                solicitud[0] = rs.getString("id");
                solicitud[1] = rs.getString("servicio");
                solicitud[2] = rs.getString("negocio_razon");
                solicitud[3] = rs.getString("fecha");
                solicitud[4] = rs.getString("estado");
                lista.add(solicitud);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}