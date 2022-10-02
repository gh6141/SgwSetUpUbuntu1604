import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginCheck extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;
protected Connection conn = null;

  public void init() throws ServletException{


  }

  public void destory(){

  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

    response.setContentType("text/html; charset=UTF-8");
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");

    HttpSession session = request.getSession(true);

   boolean check = authUser(user, pass);

    if (check){
      /* 認証済みにセット */
      session.setAttribute("login", "OK");
      session.setAttribute("user", user);
      session.setAttribute("pass", pass);

      Cookie cookie = new Cookie("idval",user);
      Cookie cookie2 = new Cookie("passval",pass);
      cookie.setMaxAge(60*60*24*30*12*10);
      cookie2.setMaxAge(60*60*24*30*12*10);
      response.addCookie(cookie);
      response.addCookie(cookie2);


      /* 本来のアクセス先へ飛ばす
      String target = (String)session.getAttribute("target");
      response.sendRedirect(target);  */
      response.sendRedirect("/SGW/top.jsp");
    }else{
      /* 認証に失敗したら、ログイン画面に戻す */
      session.setAttribute("status", "Not Auth");
      response.sendRedirect("/SGW/Login");
    }
  }

  protected boolean authUser(String user, String pass){


	    ServletContext sc = getServletContext();
	    String hostname = (String)sc.getInitParameter("hostname");
	    String url = "jdbc:mysql://"+hostname+"/skt";
	   String muser = (String)sc.getInitParameter("mysqluser");
	    String password = (String)sc.getInitParameter("mysqlpass");


	    try {
	      Class.forName("com.mysql.jdbc.Driver").newInstance();
	      conn = DriverManager.getConnection(url, muser, password);

	    		conn.setReadOnly(true);;//読み取り専用にして高速化


	    }catch (SQLException e){
	      System.out.println("SQLException:Mysql_connection_error_2 hostname=" +hostname+" "+ e.getMessage());
	    }catch (Exception e){
	      System.out.println("Exception:Mysql_connection_error_3 hostname=" +hostname+" "+ e.getMessage());
	    }



    /* 取りあえずユーザー名とパスワードが入力されていれば認証する */

    if (user == null || user.length() == 0 || pass == null || pass.length() == 0){
      return false;
    }

   try {
      String sql = "SELECT * FROM shokuin WHERE user = ? AND pass = ?";


    PreparedStatement pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, user);
    pstmt.setString(2, pass);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()){
        return true;
     }else{
      return false;
      }
    }catch (SQLException e){
    	System.out.println("SQLException:user="+user+"<--LoginError :::" + e.getMessage());
     return false;
   }finally{
	   try{
		   if (conn != null){
		        conn.close();
		      }
		    }catch (SQLException e){
		      System.out.println("SQLException:conn.close missing!!" + e.getMessage());
		    }
   }




  }

}
