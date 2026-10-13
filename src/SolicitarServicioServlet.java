import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SolicitarServicioServlet")
public class SolicitarServicioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String correo = request.getParameter("correo");
        String nombre = request.getParameter("nombre");
        String servicio = request.getParameter("servicio");
        String negocio = request.getParameter("negocio");
        String detalles = request.getParameter("detalles");

        // Combinamos negocio y detalles en el texto que verá el diseñador
        String razonCompleta = "Negocio/Proyecto: " + negocio + " | Detalles: " + detalles;

        Conexion conexionDB = new Conexion();
        String sql = "INSERT INTO solicitudes (correo_cliente, nombre_cliente, servicio, negocio_razon, estado) VALUES (?, ?, ?, ?, 'Pendiente')";

        try (Connection conexion = conexionDB.conectar();
             PreparedStatement orden = conexion.prepareStatement(sql)) {
            
            orden.setString(1, correo);
            orden.setString(2, nombre);
            orden.setString(3, servicio);
            orden.setString(4, razonCompleta);
            
            orden.executeUpdate();
            response.sendRedirect("solicitar_servicio.jsp?exito=true");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("solicitar_servicio.jsp?error=true");
        }
    }
}