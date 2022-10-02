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



public class RequestServ_henko extends HttpServlet {
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
  PrintWriter out = res.getWriter();

String jikan = req.getParameter("jikan");
String rid =req.getParameter("number");
String date =req.getParameter("date");
String classN =req.getParameter("class");

String oper = req.getParameter("oper");
String kyoka = req.getParameter("kyoka");
String tanto = req.getParameter("tanto");


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

    if (oper.equals("add")) {
    	sql = "insert into henko (jikan,date,class,kyoka,tanto) values("+jikan+",'"+date+"','"+classN+"','"+kyoka+"','"+tanto+"')";


     	}
    else if (oper.equals("del")){
    	 sql = "delete from henko where id = "+rid;

    	 }

    else {
    	sql = "update henko set jikan="+jikan+", date='"+date+"', class='"+classN+"', kyoka='"+kyoka+"', tanto='"+tanto+"' where id = "+rid;
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

		out.println( "kyoka:「"+kyoka+"」");


}




}