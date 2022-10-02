
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;



public class RequestServ_group extends HttpServlet {
 /**
	 *
	 */
	private static final long serialVersionUID = 1L;

public void doPost(HttpServletRequest req, HttpServletResponse res)
             throws ServletException, IOException {
  //(1)エンコード方式の指定
  res.setContentType("text/html; charset=utf-8");
  //(2)パラメータのエンコード方式の指定
  req.setCharacterEncoding("utf-8");

  //(3)PrintWriterオブジェクトの生成

 // out.println("<HTML>");
 // out.println("<BODY>");
  //(4)name1パラメータの取得
  //out.println(req.getParameter("num") + "<br>");
  //(5)vehicleパラメータの取得
String name = req.getParameter("name");
String num =req.getParameter("num");
String rid =req.getParameter("id");
String member =req.getParameter("member").replaceAll("\\n", "");
String oper = req.getParameter("oper");

Connection conn = null;


ServletContext sc = getServletContext();

String	hostname = (String)sc.getInitParameter("master_hostname");

String url = "jdbc:mysql://"+hostname+"/skt";
String user = (String)sc.getInitParameter("mysqluser");
String password = (String)sc.getInitParameter("mysqlpass");

try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = (Connection) DriverManager.getConnection(url, user, password);

    Statement stmt = (Statement) conn.createStatement();

    String sql="";
    if (oper.equals("add")) {sql = "insert into groupname (name,member) values('"+name+"','"+member+"')";}  else if (oper.equals("del")){
    	 sql = "delete from groupname where id = "+num;} else {sql = "update groupname set name='"+name+"',member='"+member+"' where id = "+rid;}

	//System.out.println(sql);
    stmt.executeUpdate(sql);
    stmt.close();

  }catch (SQLException e){
    System.out.println("SQLException:" + e.getMessage());
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

		System.out.println( "name:　"+name);


//  out.println("</BODY>");
//  out.println("</HTML>");
 }
}