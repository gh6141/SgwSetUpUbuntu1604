
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

//@WebServlet("/sette_p")
public class mail_set extends HttpServlet {


	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		//入力情報の取得
		request.setCharacterEncoding("UTF-8");
		String flg = request.getParameter("flg");
		String mailname = request.getParameter("mailname");
		String password = request.getParameter("password");
		String pop3 = request.getParameter("pop3");
		String haisin_ad = request.getParameter("haisin_ad");
		String renraku_ad = request.getParameter("renraku_ad");



		//response準備
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();


		Connection conn = null;


		ServletContext sc = getServletContext();
		String hostname = (String)sc.getInitParameter("hostname");
		try{
			hostname = (String)sc.getInitParameter("master_hostname");
		}catch (Exception e){

		}
		String url = "jdbc:mysql://"+hostname+"/skt";
	    String user = (String)sc.getInitParameter("mysqluser");
	    String passw = (String)sc.getInitParameter("mysqlpass");

		 try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e3) {
			// TODO 自動生成された catch ブロック
			e3.printStackTrace();
		} catch (IllegalAccessException e3) {
			// TODO 自動生成された catch ブロック
			e3.printStackTrace();
		} catch (ClassNotFoundException e3) {
			// TODO 自動生成された catch ブロック
			e3.printStackTrace();
		}

		    try {
				conn = (Connection) DriverManager.getConnection(url, user, passw);
			} catch (SQLException e2) {
				// TODO 自動生成された catch ブロック
				e2.printStackTrace();
			}


		  String sql = "SELECT * FROM shokuin WHERE id = "+ request.getParameter("shokuinid");
		    ResultSet rs;
			String username=null;String pass=null;String pop3host=null;
			String haisin_adress=null;String renraku_adress=null;String userN=null;
			try {
				Statement stmt;
				stmt = (Statement) conn.createStatement();
				rs = stmt.executeQuery(sql);

				if (rs.next()){
					username=rs.getString("mail");
					pass=rs.getString("mailpass");
					pop3host=rs.getString("pop3");
					haisin_adress=rs.getString("haisin_ad");
					renraku_adress=rs.getString("renraku_ad");
					userN=rs.getString("name");
					//System.out.println("DBからの読み取り:"+username);
				}
				stmt.close();
				rs.close();


			} catch (SQLException e1) {
				// TODO 自動生成された catch ブロック
				e1.printStackTrace();
			}

		//ファイル書き込み
		if (flg.equals("kaki")) {
			Statement stmt2;
			try {
				stmt2 = (Statement) conn.createStatement();
				String sql2="update shokuin set mail = '"+mailname+"' , mailpass = '"+password+"' ,pop3 = '"+pop3+"'  where id = "+request.getParameter("shokuinid");
				stmt2.executeUpdate(sql2);
				stmt2.close();
				//System.out.print("書き込みました"+sql2);
				out.println("書き込みました");
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
		} else  if(flg.equals("kaki_pass")){
			Statement stmt2;
			try {
				stmt2 = (Statement) conn.createStatement();
				String sql2="update shokuin set mailpass = '"+password+"'  where id = "+request.getParameter("shokuinid");
				stmt2.executeUpdate(sql2);
				stmt2.close();
				//System.out.print("書き込みました"+sql2);
				out.println("（メールチェック用パスワードも）");
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}

		}else  if(flg.equals("yomi")){ //yomi no baai
			out.println(username+"\t"+pass+"\t"+pop3host+"\t"+userN);
		} else if(flg.equals("hkaki")){//配信、連絡メールのアドレス書き込み
			Statement stmt3;
			try {
				stmt3 = (Statement) conn.createStatement();
				String sql3="update shokuin set haisin_ad = '"+haisin_ad+"' , renraku_ad = '"+renraku_ad+"' where id = "+request.getParameter("shokuinid");
				stmt3.executeUpdate(sql3);
				stmt3.close();
				//System.out.print("書き込みました"+sql3);
				out.println("書き込みました");
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}

		}else if(flg.equals("hyomi")){//配信、連絡メールのアドレス読み込み
			out.println(haisin_adress+"\t"+renraku_adress+"\t"+userN);
		}
		out.close();
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

	}

}
