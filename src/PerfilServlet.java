import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PerfilServlet")
public class PerfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession sesion = request.getSession(false);
            if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String correoUsuario = (String) sesion.getAttribute("correoUsuario");
            String nombreUsuario = (String) sesion.getAttribute("usuarioLogueado");

            GestorUsuarios gestor = new GestorUsuarios();
            String[] datosUsuario = null;

            // 1. Intentamos buscar por correo
            if (correoUsuario != null && !correoUsuario.trim().isEmpty()) {
                datosUsuario = gestor.obtenerUsuarioPorCorreo(correoUsuario);
            }

            // 2. Si no se encontró por correo, buscamos por nombre en la lista
            if (datosUsuario == null && nombreUsuario != null && !nombreUsuario.trim().isEmpty()) {
                for (String[] u : gestor.listarUsuarios()) {
                    if (u != null && u.length > 1 && u[1] != null && u[1].equalsIgnoreCase(nombreUsuario)) {
                        datosUsuario = u;
                        break;
                    }
                }
            }

            // 3. Respaldo de seguridad para que el array nunca sea null
            if (datosUsuario == null) {
                datosUsuario = new String[9];
                datosUsuario[0] = "";
                datosUsuario[1] = nombreUsuario != null ? nombreUsuario : "";
                datosUsuario[2] = correoUsuario != null ? correoUsuario : "";
                datosUsuario[3] = "";
                datosUsuario[4] = "";
                datosUsuario[5] = "";
                datosUsuario[6] = "";
                datosUsuario[7] = "";
                datosUsuario[8] = (String) sesion.getAttribute("rol");
            }

            request.setAttribute("datosUsuario", datosUsuario);
            request.getRequestDispatcher("perfil.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error al cargar el perfil:</h3><p>" + e.getMessage() + "</p>");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession sesion = request.getSession(false);
            if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            request.setCharacterEncoding("UTF-8");

            String correo = request.getParameter("correo");
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            String contrasena = request.getParameter("contrasena");

            GestorUsuarios gestor = new GestorUsuarios();
            boolean actualizado = gestor.actualizarPerfilCliente(correo, nombre, telefono, contrasena);

            if (actualizado) {
                sesion.setAttribute("usuarioLogueado", nombre);
                response.sendRedirect("PerfilServlet?exito=true");
            } else {
                response.sendRedirect("PerfilServlet?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("PerfilServlet?error=true");
        }
    }
}