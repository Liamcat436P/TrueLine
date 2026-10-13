import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ActualizarEstadoServlet")
public class ActualizarEstadoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        try {
            int solicitudId = Integer.parseInt(request.getParameter("solicitudId"));
            String nuevoEstado = request.getParameter("nuevoEstado");

            GestorUsuarios gestor = new GestorUsuarios();
            gestor.actualizarEstadoSolicitud(solicitudId, nuevoEstado);

            response.sendRedirect("ProyectosDisenadorServlet?estadoActualizado=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProyectosDisenadorServlet?error=true");
        }
    }
}