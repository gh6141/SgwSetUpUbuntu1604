import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;

 public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

    response.setContentType("text/html; charset=UTF-8");
    PrintWriter out = response.getWriter();

    out.println("<html>");
    out.println("<head>");
    out.println("<title>ログインページ</title>");
    out.println("</head>");
    out.println("<body>");

    out.println("<h1>ログイン画面</h1>");

    HttpSession session = request.getSession(true);

    /* 認証失敗から呼び出されたのかどうか */
    Object status = session.getAttribute("status");

    if (status != null){
      out.println("<p>認証に失敗しました</p>");
      out.println("<p>再度ユーザー名とパスワードを入力して下さい</p>");
      out.println("<p>（認証失敗が続く場合は、担当に連絡ください。</p>");

      session.setAttribute("status", null);
    }

    Cookie cookie[] = request.getCookies();

    String idval="";
    String passval="";
    if (cookie != null){
        for (int i = 0 ; i < cookie.length ; i++){
          if (cookie[i].getName().equals("idval")){
             idval = cookie[i].getValue();
          }
        }

        for (int i = 0 ; i < cookie.length ; i++){
          if (cookie[i].getName().equals("passval")){
             passval = cookie[i].getValue();
          }
        }
    }


    out.println("<form method=POST action=/SGW/LoginCheck name=loginform>");
    out.println("<table>");
    out.println("<tr>");
    out.println("<td>ユーザー名</td>");
     out.println("<td><input type=text name=user size=32 value="+idval+"></td>");
  // out.println("<td><input type=text name=user size=32 value=''></td>");
    out.println("</tr>");
    out.println("<tr>");
    out.println("<td>パスワード</td>");
    	out.println("<td><input type=password name=pass size=32 value="+passval+"></td>");
  //  out.println("<td><input type=password name=pass size=32 value=''></td>");
    out.println("</tr>");
    out.println("<tr>");
    out.println("<td><input type=submit value=login></td>");
    out.println("</tr>");
    out.println("</table>");
    out.println("</form>");

    out.println("</body>");
    out.println("</html>");
  }
}
