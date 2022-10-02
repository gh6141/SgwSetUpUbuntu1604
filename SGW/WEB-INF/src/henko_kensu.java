import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class henko_kensu extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;


  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

    response.setContentType("text/html; charset=UTF-8");
    String kensuh = request.getParameter("kensuh");
    
    Cookie cookie = new Cookie("kensuh",kensuh);
    cookie.setMaxAge(60*60*24*30*12*5);
    response.addCookie(cookie);

    response.sendRedirect("henko.jsp");
  }



}