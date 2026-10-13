import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/SubirArchivoServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,        // 10MB
    maxRequestSize = 1024 * 1024 * 50      // 50MB
)
public class SubirArchivoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int solicitudId = Integer.parseInt(request.getParameter("solicitudId"));
        String correoCliente = request.getParameter("correoCliente");

        Part filePart = request.getPart("archivo");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Carpeta donde se guardarán los archivos dentro del servidor
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Guardar archivo físicamente
        filePart.write(uploadPath + File.separator + fileName);

        // Guardar registro en la base de datos
        GestorUsuarios gestor = new GestorUsuarios();
        gestor.guardarArchivoProyecto(solicitudId, correoCliente, fileName);

        response.sendRedirect("ProyectosDisenadorServlet?subido=true");
    }
}