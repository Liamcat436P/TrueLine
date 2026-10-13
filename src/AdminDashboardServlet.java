import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || !"admin".equalsIgnoreCase((String) sesion.getAttribute("rol"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        GestorUsuarios gestor = new GestorUsuarios();

        // Métricas para las tarjetas
        int totalClientes = gestor.contarUsuariosPorRol("cliente");
        int totalDisenadores = gestor.contarUsuariosPorRol("diseñador") + gestor.contarUsuariosPorRol("disenador");
        int totalSolicitudes = gestor.contarSolicitudesPorEstado(null);
        int completados = gestor.contarSolicitudesPorEstado("Completado");

        // Lista de todas las solicitudes para la tabla
        ArrayList<String[]> listaSolicitudes = gestor.obtenerTodasLasSolicitudes();

        request.setAttribute("totalClientes", totalClientes);
        request.setAttribute("totalDisenadores", totalDisenadores);
        request.setAttribute("totalSolicitudes", totalSolicitudes);
        request.setAttribute("completados", completados);
        request.setAttribute("listaSolicitudes", listaSolicitudes);

        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}