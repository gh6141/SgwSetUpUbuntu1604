
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class henkolist extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public henkolist() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//送信内容の入力
		response.setContentType("text/plain;charset=UTF-8");
		PrintWriter out = response.getWriter();


		Connection conn = null;


		ServletContext sc = getServletContext();
		String hostname = (String)sc.getInitParameter("hostname");
		//try{
		//	hostname = (String)sc.getInitParameter("master_hostname");
		//}catch (Exception e){

		//}
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

		    String hiduke =request.getParameter("hiduke");
		    String hiduke2 =request.getParameter("hiduke2");

		    String sql,sql2;
		    ArrayList <String> hkyoka = new ArrayList <String>();
		    ArrayList <String> hjikan = new ArrayList <String>();
		    ArrayList <String> htanto = new ArrayList <String>();
		    ArrayList <String> hclassN = new ArrayList <String>();
		    ArrayList <String> hclassNH = new ArrayList <String>();

		    ArrayList <String> hkyoka2 = new ArrayList <String>();
		    ArrayList <String> hjikan2 = new ArrayList <String>();
		    ArrayList <String> htanto2 = new ArrayList <String>();
		    ArrayList <String> hclassN2 = new ArrayList <String>();
		    ArrayList <String> hclassN2H = new ArrayList <String>();

		    	   sql = "SELECT * FROM henko where date ='"+hiduke+"' order by class,jikan" ;
		    	   sql2 = "SELECT * FROM henko where date ='"+hiduke2+"' order by class,jikan" ;




		 // System.out.println(sql);
		    ResultSet rs,rs2;


			try {
				Statement stmt;
				stmt = (Statement) conn.createStatement();
				String pc1="",pc2="",c1="",c2="";

				rs = stmt.executeQuery(sql);
				while(rs.next()){
				    hkyoka.add(rs.getString("kyoka"));
					hjikan.add(Integer.toString(rs.getInt("jikan")));
					htanto.add(rs.getString("tanto"));
					c1=rs.getString("class");
					hclassN.add(c1);
					if(!(pc1.equals(c1))){
						hclassNH.add(c1);
					}
					pc1=c1;
				}
				rs.close();

				rs2 = stmt.executeQuery(sql2);
				while(rs2.next()){
					  hkyoka2.add(rs2.getString("kyoka"));
						hjikan2.add(Integer.toString(rs2.getInt("jikan")));
						htanto2.add(rs2.getString("tanto"));
						c2=rs2.getString("class");
						hclassN2.add(c2);
						if(!(pc2.equals(c2))){
							hclassN2H.add(c2);
						}
						pc2=c2;
				}
				rs2.close();

				stmt.close();
				conn.close();

				String msg="";
				String msg2="";
				if(hjikan.size()==0 && hjikan2.size()==0){
					out.print("変更なし");
				}else{
					if(hjikan.size()>0){
						msg="今日";
						pc1="(";
						for(int i=0;i<hclassNH.size();i++){
							if(i==hclassNH.size()-1){
								pc1=pc1+hclassNH.get(i)+")";
							}else{
								pc1=pc1+hclassNH.get(i)+",";
							}

						}
					}
					if(hjikan2.size()>0){
						msg2="明日";
						pc2="(";
						for(int i=0;i<hclassN2H.size();i++){
							if(i==hclassN2H.size()-1){
								pc2=pc2+hclassN2H.get(i)+")";
							}else{
								pc2=pc2+hclassN2H.get(i)+",";
							}

						}
					}
					 out.print("<span title='クリックすると授業変更が表示されます。' id='henkodisp'>"+msg+pc1+"　"+msg2+pc2+" 授業変更があります</span>\t");
//******************************************************************************************


					 String PclassN="";
					 String[] cell = new String[8];
					 for(int jj=0;jj<8;jj++){
			    	   cell[jj]=" "	;
			    	  }

					 if(!(msg=="")){
						 out.print("<table title='登録に重複があると赤字になります。その際は、不要な登録を削除してください。' id='kyo' border=2 bordercolor='black' style='font-size:14px;border-collapse:collapse;'>");
					 out.print("<tr>");
					 for(int jj=0;jj<8;jj++){
						 if(jj==0){
							 out.print("<td>"+msg+"</td>");
						 }else{
							 out.print("<td width='80'>"+jj+"校時</td>");
						 }
					 }
					 out.print("</tr>");
					 }



					 for (int i = 0 ; i < hjikan.size() ; i++){
					      String jikan = hjikan.get(i);	      String kyoka = hkyoka.get(i);
					      String tanto = htanto.get(i);	      String classN = hclassN.get(i);

					     if(hjikan.size()==1){//dataが１つしかないとき
					    	 out.print("<tr>");
					    	  for(int jj=0;jj<8;jj++){
					    		  if(jj==0){
					    			  out.print("<td>"+classN+"</td>");
					    		  }else{
					    			  if(jj==Integer.parseInt(jikan)){
					    				  out.print("<td>"+kyoka+"("+tanto+")</td>");
					    			  }else{
					    				  out.print("<td>　</td>");
					    			  }

					    		  }
					    	  }
					    	  out.print("</tr>");

					     }else if(!(classN.equals(PclassN))&&i>0){		//クラスが変わったら、累積したデータを出力
					    	  out.print("<tr>");
					    	  for(int jj=0;jj<8;jj++){
					    		  if(jj==0){
					    			  out.print("<td>"+PclassN+"</td>");
					    		  }else{
					    			  out.print("<td>"+cell[jj]+"</td>");
					    		  }
					    		  cell[jj]=" ";
					    	  }
					    	  out.print("</tr>");

					      }else{

					      }
					     if(cell[Integer.parseInt(jikan)]==" "){//だぶりちぇっく
					    	 cell[Integer.parseInt(jikan)]=kyoka+"("+tanto+")";
					     }else{
					    	 cell[Integer.parseInt(jikan)]="<font color='red'>"+kyoka+"("+tanto+")</font>";
					     }

					      	PclassN=classN;
					    }
				//last
					 if (hjikan.size()>1){
						 out.print("<tr>");
				    	  for(int jj=0;jj<8;jj++){
				    		  if(jj==0){
				    			  out.print("<td>"+PclassN+"</td>");
				    		  }else{
				    			  out.print("<td>"+cell[jj]+"</td>");
				    		  }
				    	  }
				    	  out.print("</tr>");
					 }

			    	  out.print("</table>");
//***************************************************************************************
			    	  out.print("<br>");
			    	  PclassN="";
						 for(int jj=0;jj<8;jj++){
				    	   cell[jj]=" "	;
				    	  }

						 if(!(msg2=="")){
							 out.print("<table id='asu' border=1 style='color:gray;font-size:14px;border-collapse:collapse;'>");
							  out.print("<tr>");
					    	  for(int jj=0;jj<8;jj++){
					    		  if(jj==0){
					    			  out.print("<td>"+msg2+"</td>");
					    		  }else{
					    			  out.print("<td width='80'>"+jj+"校時</td>");
					    		  }
					    	  }
					    	  out.print("</tr>");
						 }


						 for (int i = 0 ; i < hjikan2.size() ; i++){
						      String jikan2 = hjikan2.get(i);	      String kyoka2 = hkyoka2.get(i);
						      String tanto2 = htanto2.get(i);	      String classN2 = hclassN2.get(i);

						     if(hjikan2.size()==1){//dataが１つしかないとき
						    	 out.print("<tr>");
						    	  for(int jj=0;jj<8;jj++){
						    		  if(jj==0){
						    			  out.print("<td>"+classN2+"</td>");
						    		  }else{
						    			  if(jj==Integer.parseInt(jikan2)){
						    				  out.print("<td>"+kyoka2+"("+tanto2+")</td>");
						    			  }else{
						    				  out.print("<td>　</td>");
						    			  }


						    		  }
						    	  }
						    	  out.print("</tr>");

						     }else if(!(classN2.equals(PclassN))&&i>0){		//クラスが変わったら、累積したデータを出力
						    	  out.print("<tr>");
						    	  for(int jj=0;jj<8;jj++){
						    		  if(jj==0){
						    			  out.print("<td>"+PclassN+"</td>");
						    		  }else{
						    			  out.print("<td>"+cell[jj]+"</td>");
						    		  }
						    		  cell[jj]=" ";
						    	  }
						    	  out.print("</tr>");

						      }else{

						      }
						     if(cell[Integer.parseInt(jikan2)]==" "){//だぶりちぇっく
						    	 cell[Integer.parseInt(jikan2)]=kyoka2+"("+tanto2+")";
						     }else{
						    	 cell[Integer.parseInt(jikan2)]="<font color='red'>"+kyoka2+"("+tanto2+")</font>";
						     }

						      	PclassN=classN2;
						    }
					//last
						 if(hjikan2.size()>1){
							 out.print("<tr>");
					    	  for(int jj=0;jj<8;jj++){
					    		  if(jj==0){
					    			  out.print("<td>"+PclassN+"</td>");
					    		  }else{
					    			  out.print("<td>"+cell[jj]+"</td>");
					    		  }
					    	  }
					    	  out.print("</tr>");
						 }



				    	  out.print("</table>");

				}




			} catch (SQLException e1) {
				// TODO 自動生成された catch ブロック
				e1.printStackTrace();
				System.out.println("err2："+e1.getMessage());
			}

		out.close();
	}
}
