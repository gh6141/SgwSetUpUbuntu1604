import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SessionOut extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;

public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

    response.setContentType("text/html; charset=UTF-8");
    HttpSession session = request.getSession(true);
    session.invalidate();


  }
}

