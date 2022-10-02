
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
public class pass_set extends HttpServlet {


	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {




		//入力情報の取得
		request.setCharacterEncoding("UTF-8");
		String flg = request.getParameter("flg");
		String password = request.getParameter("password");



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
			String pass=null;
			String userN=null;
			String userID=null;
			try {
				Statement stmt;
				stmt = (Statement) conn.createStatement();
				rs = stmt.executeQuery(sql);

				if (rs.next()){
					pass=rs.getString("pass");
					userN=rs.getString("name");
					userID=rs.getString("user");
					//System.out.print(userN+"DB読み取りOK");
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
				String sql2="update shokuin set pass = '"+password+"'  where id = "+request.getParameter("shokuinid");
				stmt2.executeUpdate(sql2);
				stmt2.close();

				//System.out.print("書き込みました");
				out.print("書き込みました");
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}

		}
		else if(flg.equals("kaki_rst")){
			Statement stmt3;
			try {
				stmt3 = (Statement) conn.createStatement();
				String sql3="update shokuin set pass = '"+password+"'  where user = '"+request.getParameter("userD")+"'";
				stmt3.executeUpdate(sql3);
				stmt3.close();

				//System.out.print("書き込みました");
				out.print("仮のログインパスワードを設定しました");
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				out.print("設定に失敗しました");
				e.printStackTrace();
			}

		} else { //yomi no baai
			out.print(pass+"\t"+userN+"\t"+userID);

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
