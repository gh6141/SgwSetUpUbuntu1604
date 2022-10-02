import java.io.*;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class rename extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

    response.setContentType("text/html; charset=UTF-8");
    PrintWriter out =response.getWriter();
    
    String src = request.getParameter("opath");
    String des = request.getParameter("dpath");
    File f1 = new File(src);  
    File f2 = new File(des);  
    f1.renameTo(f2);  
    out.println(src+des);
    out.close();
  }

  
}
