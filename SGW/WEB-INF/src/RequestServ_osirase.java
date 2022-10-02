import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;



public class RequestServ_osirase extends HttpServlet {
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
 // out.println("<HTML>");
 // out.println("<BODY>");
  //(4)name1パラメータの取得
  //out.println(req.getParameter("num") + "<br>");
  //(5)vehicleパラメータの取得
String name = req.getParameter("name");
String rid =req.getParameter("number");
String kikan_s =req.getParameter("kikan_s");
String kikan_e =req.getParameter("kikan_e");

String oper = req.getParameter("oper");
String title = req.getParameter("title");
String msg = req.getParameter("msg");
String tenpu = req.getParameter("tenpu");
String user1 = req.getParameter("user");
String userid = req.getParameter("userid");

String opath = req.getParameter("opath");
String opath2 = req.getParameter("opath2");


Connection conn = null;


ServletContext sc = getServletContext();


	opath = (String)sc.getInitParameter("master_tenpu");
	if(opath==null){
	 System.out.println("web.xmlのmaster_tenpuに書き込みようのtenpuのパスを記載してください");
	}

String hostname = (String)sc.getInitParameter("master_hostname");
String url = "jdbc:mysql://"+hostname+"/skt";
String user = (String)sc.getInitParameter("mysqluser");
String password = (String)sc.getInitParameter("mysqlpass");
try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn = (Connection) DriverManager.getConnection(url, user, password);

    Statement stmt = (Statement) conn.createStatement();

    File fname;
    int i;

    String sql="";
    String	sql2="";
    if (oper.equals("add")) {
    	sql = "insert into keijiban (name,kikan_s,kikan_e,title,tenpu,msg,user,userid) values('"+name+"','"+kikan_s+"','"+kikan_e+"','"+title+"','"+tenpu+"','"+msg+"','"+user1+"','"+userid+"')";
    }else if (oper.equals("del")){

    	 sql = "delete from keijiban where id = "+rid;

    	 String ttenpu="";
    	 ResultSet rs = stmt.executeQuery("select tenpu from keijiban where id = "+rid);
    	 while (rs.next()){
    		  ttenpu =rs.getString("tenpu");
    	 }


    	 String op_tp2=ttenpu.replaceAll("/a><br>","/a><br>,").replaceAll("<.+?>", "");
         String[] op_tpArray2 = op_tp2.split(",");
    	 for ( i=0; i<op_tpArray2.length; i++) {
    		 //System.out.println(opath+op_tpArray2[i]);
    	  	 fname = new File(opath+op_tpArray2[i]);
        	 fname.delete();
    	 }

    	// System.out.println(tenpu);
    	 imgAllDell(tenpu.replaceAll(opath2,opath));//imgの削除


    }
    else if (oper.equals("deltenpu")){
    	sql="update keijiban set tenpu='' where id = "+rid;

   	    String op_tp=tenpu.replaceAll("/a><br>","/a><br>,").replaceAll("<.+?>", "");
   	 //System.out.println("op_tp="+op_tp);
         String[] op_tpArray = op_tp.split(",");
         for (  i=0; i<op_tpArray.length; i++) {
        	fname =  new File(opath+op_tpArray[i]);
           	 fname.delete();
         }
    }
    else if (oper.equals("ikkatu_del")){
    	 sql = "delete from past_keijiban where id <= "+kikan_e;
    	// sql = "delete from keijiban where kikan_e <= '2015/04/01'";
    	 //System.out.println("delete from keijiban where kikan_e LIKE '"+kikan_e+"'");
    	//out.println( "削除OK");

    	 String ttenpu2="";
    	 String op_tp22;
    	 String[] op_tpArray22 ;

    	 ResultSet rs2 = stmt.executeQuery("select tenpu,msg from past_keijiban where id <= "+kikan_e);
    	 //System.out.println("rs2");
    	 while (rs2.next()){
    		  ttenpu2 =rs2.getString("tenpu");

    		  imgAllDell(rs2.getString("msg").replaceAll(opath2,opath));//imgの削除

    		  op_tp22=ttenpu2.replaceAll("/a><br>","/a><br>,").replaceAll("<.+?>", "");
    	         op_tpArray22 = op_tp22.split(",");
    	    	 for ( i=0; i<op_tpArray22.length; i++) {
    	    		 //System.out.println(opath+op_tpArray22[i]);
    	    	  	 fname = new File(opath+op_tpArray22[i]);
    	        	 fname.delete();
    	    	 }

    	 }

     }
    else if (oper.equals("ikkatu_move")){

    	sql="insert into past_keijiban select * from keijiban where id <= "+kikan_e;

   	 sql2 = "delete from keijiban where id <= "+kikan_e;
   	// sql = "delete from keijiban where kikan_e <= '2015/04/01'";
   	 //System.out.println("delete from keijiban where kikan_e LIKE '"+kikan_e+"'");
   	//out.println( "削除OK");

    }
    else if (oper.equals("delimg")){//画像表示を<imgからパスを抽出して　ファイル削除

         imgAllDell(tenpu.replaceAll(opath2,opath));

    }
    else {
    	 sql = "update keijiban set name='"+name+"', kikan_s='"+kikan_s+"', kikan_e='"+kikan_e+"', title='"+title+"', tenpu='"+tenpu+"', msg='"+msg+"' where id = "+rid;
    }

	//System.out.println(sql);
   // stmt.executeUpdate(sql);

	if (sql.length()>0){
	 stmt.executeUpdate(sql);
	}

    if (sql2.length()>0){
		 stmt.executeUpdate(sql2);
		}

    stmt.close();

  }catch (SQLException e){
    System.out.println("SQLException:" + e.getMessage());
    out.println("データ処理ができません。データベースの設定ミス、データの異常などが考えられます。"+ e.getMessage());
  }catch (Exception e){
    System.out.println("Exception:外側..削除失敗？" + e.getMessage());
  }finally{
    try{
      if (conn != null){
        conn.close();
      }
    }catch (SQLException e){
      System.out.println("SQLException:最後.." + e.getMessage());
    }
  }

		//out.println( "title:「"+title+"」");


//  out.println("</BODY>");
//  out.println("</HTML>");
 }


private void imgAllDell(String tenpu) {
	// TODO 自動生成されたメソッド・スタブ
	String[] resx = extractImgSrc(tenpu);
	 File fname;
   	for (int ix = 0; ix < resx.length; ix++) {
		fname =  new File(resx[ix].replace("&#10;",""));
      	 fname.delete();
	//System.out.println("res[" + ix + "]=" + resx[ix]);
	}

}





public static String[] extractImgSrc(String html) {
List<String> result = new ArrayList<String>();
Pattern p = Pattern.compile("<\\s*img[^>]*src\\s*=\\s*([\\\"'])?([^ \\\"']*)[^>]*>");
Matcher m = p.matcher(html);
while (m.find()) {
result.add(m.group(2));
}
return result.toArray(new String[result.size()]);
}


}