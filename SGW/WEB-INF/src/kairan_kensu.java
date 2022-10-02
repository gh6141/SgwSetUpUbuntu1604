import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class kairan_kensu extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;


  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

    response.setContentType("text/html; charset=UTF-8");
    String kensu = request.getParameter("kensu");

    if (Integer.parseInt(kensu)<2) {
    	kensu="2";

    }

    Cookie cookie = new Cookie("kensu",kensu);
    cookie.setMaxAge(60*60*24*30*12*5);
    response.addCookie(cookie);

    response.sendRedirect("kairan.jsp?rmsg=NULL");
  }



}
