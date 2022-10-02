
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Store;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

//@WebServlet("/SGW/maillist")
public class maillist extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public maillist() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//送信内容の入力
		response.setContentType("text/plain;charset=UTF-8");
		PrintWriter out = response.getWriter();


		Connection conn = null;


		ServletContext sc = getServletContext();
		String hostname = (String)sc.getInitParameter("hostname");

		String url = "jdbc:mysql://"+hostname+"/skt";
	    String user = (String)sc.getInitParameter("mysqluser");
	    String passw = (String)sc.getInitParameter("mysqlpass");

		 try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e3) {
			// TODO 自動生成された catch ブロック
			System.out.println("err01："+e3.getMessage());
			e3.printStackTrace();
		} catch (IllegalAccessException e3) {
			// TODO 自動生成された catch ブロック
			e3.printStackTrace();
			System.out.println("err02："+e3.getMessage());
		} catch (ClassNotFoundException e3) {
			// TODO 自動生成された catch ブロック
			e3.printStackTrace();
			System.out.println("err03："+e3.getMessage());
		}

		    try {
				conn = (Connection) DriverManager.getConnection(url, user, passw);
				conn.setReadOnly(true);;//読み取り専用にして高速化
			} catch (SQLException e2) {
				// TODO 自動生成された catch ブロック
				e2.printStackTrace();
				System.out.println("err1："+e2.getMessage());
			}

		    String usern=request.getParameter("usern");
		    String shokuini=request.getParameter("shokuinid");
		    String sql;
		    if (usern==null) {
		    	  sql = "SELECT * FROM shokuin WHERE id = "+ shokuini ;
		    }
		    else {
		    	   sql = "SELECT * FROM shokuin WHERE user = '"+ usern+"'" ;
		    }



		  //System.out.println(sql);
		    ResultSet rs;
			String username=null;String password=null;String pop3host=null;
			try {
				Statement stmt;
				stmt = (Statement) conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next()){
					username=rs.getString("mail");
					password=rs.getString("mailpass");
					pop3host=rs.getString("pop3");
					//System.out.println("DBから読み取りFORメールチェック："+username);
				}

				stmt.close();
				rs.close();
				conn.close();

			} catch (SQLException e1) {
				// TODO 自動生成された catch ブロック
				e1.printStackTrace();
				System.out.println("err2："+e1.getMessage());
			}




		//password=request.getParameter("password");
		//pop3host=request.getParameter("pop3host");



		if (username==null || password== null || pop3host==null ||username.length()==0 || password.length()==0 || pop3host.length()==0) {
			out.println("設定なし");
			return;            }

try {


		String  temp=null;
		//空のProperty取得
		Properties props = new Properties();
		//Sessionオブジェクトの取得
		Session s = Session.getDefaultInstance(props, null);
		//Storeオブジェクトの取得
		Store store = s.getStore("pop3");
		//接続
		store.connect(pop3host,username,password);
		//Folderの取得
		Folder folder = store.getFolder("INBOX");
		folder.open(Folder.READ_ONLY);
		Message message[] = folder.getMessages();

		//Runtime.getRuntime().exec("C:\\Program Files\\Windows Mail\\WinMail.exe");
		if (message.length==0){

			out.print("メールなし");
		}else{
			out.print("メールが"+message.length+"件届いています。メールソフトで確認してください。\t");
			 for(int i=0,n=message.length; i<n; i++) {
				//FROMとSUBJECTの表示
			temp=message[i].getSubject().toString();
			out.print((i + 1) + "通目");
				out.print("From：" + message[i].getFrom()[0]);
				out.print("　題名： " + temp+"<br>");

			}


		}


		//close処理
		folder.close(false);
		store.close();
		}catch(Exception e)	{
			out.print("メールなし");
			//System.out.println("errlast:" + e.getMessage());
			//out.print("メールチェックのための設定に間違いがあるようです。パスワード等を再度ご確認ください。\t設定＞メール＞メールチェック設定のページの設定を確認してください<br>・アカウント名やパスワードの間違いはないですか。<br>・POP3サーバー名の間違いはないですか。");
		}
		out.close();


	}
}
