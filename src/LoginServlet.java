import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        GestorUsuarios gestor = new GestorUsuarios();
        
        // Validamos el ingreso con tu método habitual
        String[] usuario = gestor.validarIngreso(correo, contrasena);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario[1]); 
            session.setAttribute("rol", usuario[8]);  
            session.setAttribute("correoUsuario", usuario[2]);

            String rol = usuario[8];
            if (rol != null) {
                rol = rol.trim().toLowerCase();
            }

            // Redirección por roles protegida y estricta
            if ("admin".equals(rol)) {
                response.sendRedirect("AdminDashboardServlet"); // Redirige al nuevo Panel de Administración
            } else if ("diseñador".equals(rol) || "disenador".equals(rol)) {
                response.sendRedirect("panel_diseno.jsp"); 
            } else {
                response.sendRedirect("index_cliente.jsp"); // Panel exclusivo para clientes logueados
            }

        } else {
            // Error unificado para credenciales incorrectas o usuario inexistente
            response.sendRedirect("login.jsp?error=true");
        }
    }
}