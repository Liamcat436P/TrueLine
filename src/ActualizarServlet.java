import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ActualizarServlet")
public class ActualizarServlet extends HttpServlet {

    // 1. ESTO ES LO QUE TE FALTA: El método para recibir el POST del formulario
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtenemos los datos del formulario
        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String empresa = request.getParameter("empresa");
        String servicio = request.getParameter("servicio");
        String nacimiento = request.getParameter("nacimiento");
        String contrasena = request.getParameter("contrasena");

        // Llamamos al gestor para actualizar
        GestorUsuarios gestor = new GestorUsuarios();
        gestor.actualizarUsuario(cedula, nombre, correo, telefono, empresa, servicio, nacimiento, contrasena);

        // Volvemos a la lista
        response.sendRedirect("consultar");
    }

    // 2. Por seguridad, puedes añadir esto también
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("consultar");
    }
}