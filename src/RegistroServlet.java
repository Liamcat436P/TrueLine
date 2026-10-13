import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/registrar") // Esta es la ruta que pondrás en el action de tu formulario HTML
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Configurar la codificación para que acepte tildes y caracteres especiales desde el formulario
        request.setCharacterEncoding("UTF-8");
        
        // 1. Recibir los datos del formulario HTML
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String empresa = request.getParameter("empresa");
        String servicio = request.getParameter("tipo_servicio");
        String cedula = request.getParameter("cedula");
        String fecha = request.getParameter("fecha_nacimiento");
        String contrasena = request.getParameter("contrasena"); // Nuevo parámetro capturado

        // 2. Llamar a la lógica actualizada en GestorUsuarios (ahora con 8 parámetros)
        GestorUsuarios gestor = new GestorUsuarios();
        gestor.registrarUsuario(nombre, correo, telefono, empresa, servicio, cedula, fecha, contrasena);

        // Configurar el tipo de respuesta del servidor
        response.setContentType("text/html;charset=UTF-8");

        // 3. Responder al usuario en el navegador
        response.getWriter().println("<h1>¡Registro exitoso para " + nombre + "!</h1>");
        response.getWriter().println("<a href='index_visitantes.html'>Volver</a>");
    }
}