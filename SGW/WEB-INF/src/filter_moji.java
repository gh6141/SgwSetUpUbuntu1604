import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.http.*;


public class filter_moji extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;


  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{
	  request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    String filtermoji = request.getParameter("filtermoji");

    Cookie cookie = new Cookie("filtermoji",URLEncoder.encode(filtermoji, "UTF-8"));
    cookie.setMaxAge(60*60*24*30*12*5);
    response.addCookie(cookie);

    response.sendRedirect("top.jsp");
  }



}
