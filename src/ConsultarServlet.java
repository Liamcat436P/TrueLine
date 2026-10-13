import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/consultar")
public class ConsultarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Verificamos sesión activa
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("rol") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Normalizamos el rol
        String rol = sesion.getAttribute("rol").toString().trim().toLowerCase();

        // 3. Blindaje: Solo ADMIN puede acceder a la lista
        if (!"admin".equals(rol)) {
            response.sendRedirect("index.html"); 
            return;
        }

        // 4. Consultamos los datos (Asegúrate de que este método en tu GestorUsuarios se llame así, 
        // o cámbialo por el nombre que uses, ej: listarUsuarios())
        GestorUsuarios gestor = new GestorUsuarios();
        ArrayList<String[]> listaUsuarios = gestor.listarUsuarios(); 

        // 5. Enviamos la lista al request
        request.setAttribute("listaUsuarios", listaUsuarios);

        // 6. Redirigimos a listar.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("listar.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}