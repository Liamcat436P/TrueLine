import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/NotificacionesServlet")
public class NotificacionesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String correoUsuario = (String) sesion.getAttribute("correoUsuario");
        
        GestorUsuarios gestor = new GestorUsuarios();
        ArrayList<String[]> listaArchivos = gestor.obtenerArchivosPorCliente(correoUsuario);

        request.setAttribute("listaArchivos", listaArchivos);
        request.getRequestDispatcher("notificaciones.jsp").forward(request, response);
    }
}