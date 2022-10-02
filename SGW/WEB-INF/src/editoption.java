import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class editoption extends HttpServlet {
 /**
	 *
	 */
	private static final long serialVersionUID = 1L;

public void doGet(HttpServletRequest req, HttpServletResponse res)
             throws ServletException, IOException {
  //(1)エンコード方式の指定
  res.setContentType("text/html; charset=utf-8");
  //(2)パラメータのエンコード方式の指定
  req.setCharacterEncoding("utf-8");

  PrintWriter out = res.getWriter();


Connection conn = null;

ServletContext sc = getServletContext();
String	hostname = (String)sc.getInitParameter("hostname");
String url = "jdbc:mysql://"+hostname+"/skt";
String user = (String)sc.getInitParameter("mysqluser");
String password = (String)sc.getInitParameter("mysqlpass");

try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = (Connection) DriverManager.getConnection(url, user, password);

    conn.setReadOnly(true);;//読み取り専用にして高速化
    Statement stmt = (Statement) conn.createStatement();


	//System.out.println(sql);
    ResultSet rs2 = stmt.executeQuery("SELECT * FROM shokuin order by sid");
    //rs2.next();
    //out.println("test"+rs2.getString("name"));
    out.println( "<select>");

  while(rs2.next()){
	  out.println( "<option value='");
	  out.println(rs2.getString("id"));
	  out.println( "'>");
	  out.println(rs2.getString("name"));
	  out.println( "</option>");

  }

  out.println( "</select>");
	stmt.close();


  }catch (Exception e){
    System.out.println("Exception:" + e.getMessage());
  }finally{
    try{
      if (conn != null){
        conn.close();
      }
    }catch (SQLException e){
      System.out.println("SQLException:" + e.getMessage());
    }
  }


 }
}
