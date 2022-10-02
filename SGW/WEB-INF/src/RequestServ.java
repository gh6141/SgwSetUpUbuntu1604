
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;



public class RequestServ extends HttpServlet {
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
 // PrintWriter out = res.getWriter();
 // out.println("<HTML>");
 // out.println("<BODY>");
  //(4)name1パラメータの取得
  //out.println(req.getParameter("num") + "<br>");
  //(5)vehicleパラメータの取得
String name = req.getParameter("name");
String user1 =req.getParameter("user");
//String pass =req.getParameter("pass");
String rid =req.getParameter("id");
String oper = req.getParameter("oper");
String sid =req.getParameter("sid");

Connection conn = null;



//*********path
String patht = getServletContext().getRealPath("/WEB-INF/opath.txt");
String str2 = "";String stmp="";
BufferedReader in2=new BufferedReader(new FileReader(patht));
while((str2=in2.readLine())!=null) {
	//out.println(str2);
	stmp=stmp.trim()+str2.trim();
}
in2.close();
String path =stmp.trim() ;

//*****************************************


ServletContext sc = getServletContext();

	path = (String)sc.getInitParameter("master_tenpu");
	if(path==null){
		 System.out.println("web.xmlのmaster_tenpuに書き込みようのtenpuのパスを正しく記載してください");
	}

String hostname = (String)sc.getInitParameter("master_hostname");
String url = "jdbc:mysql://"+hostname+"/skt";
String user = (String)sc.getInitParameter("mysqluser");
String password = (String)sc.getInitParameter("mysqlpass");


try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = (Connection) DriverManager.getConnection(url, user, password);

    Statement stmt = (Statement) conn.createStatement();


    String sql="";
    if (oper.equals("add")) {
    	sql = "insert into shokuin (name,user,sid) values('"+name+"','"+user1+"',"+sid+")";
    	//dirないとき作成
    			File dirs = new File(path+"mylogo");
    			if (!dirs.exists()) {
    			    dirs.mkdir();    //make folders
    			}
    	//ここで、mylogo default画像をコピー
    	String pathf1 = getServletContext().getRealPath("/WEB-INF/default.jpg");
    	 File f1 = new File(pathf1);
    	  File f3=new File(path+"mylogo/"+req.getParameter("user")+".jpg");
    	  f3.delete();
		    FileUtils.copyFile(f1, f3);


    }  else if (oper.equals("del")){
    	 sql = "delete from shokuin where id = "+rid;
    	 File f2=new File(path+"mylogo/"+req.getParameter("user")+".jpg");
    	 System.out.println(req.getParameter("user"));
    	// File f2=new File(path+"mylogo/test5.jpg");
		    f2.delete();

    } else {
    	sql = "update shokuin set name='"+name+"',user='"+user1+"',sid="+sid+" where id = "+rid;

    }

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

		//System.out.println( "name:　"+name);


//  out.println("</BODY>");
//  out.println("</HTML>");
 }
}