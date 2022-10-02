import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;



public class RequestServ_link extends HttpServlet {
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

  PrintWriter out = res.getWriter();

String rid =req.getParameter("number");
String oper = req.getParameter("oper");
String label = req.getParameter("label");
String url = req.getParameter("url");


Connection conn = null;


ServletContext sc = getServletContext();
String 	hostname = (String)sc.getInitParameter("master_hostname");
String urlx = "jdbc:mysql://"+hostname+"/skt";
String user = (String)sc.getInitParameter("mysqluser");
String password = (String)sc.getInitParameter("mysqlpass");

try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();

    conn = (Connection) DriverManager.getConnection(urlx, user, password);

    Statement stmt = (Statement) conn.createStatement();


    String sql="";

    if (oper.equals("add")) {
    	sql = "insert into link (label,url) values('"+label+"','"+url+"')";


     	}
    else if (oper.equals("del")){
    	 sql = "delete from link where id = "+rid;

    	 }
    else {
    	sql = "update link set label='"+label+"', url='"+url+"' where id = "+rid;
    	}

	if (sql.length()>0){
	 stmt.executeUpdate(sql);
	//System.out.println(sql);
	}

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

		out.println( "label:「"+label+"」");


}




}