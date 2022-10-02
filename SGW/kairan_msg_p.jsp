<%!

private String enc(String src){
	String regex = "%[0-9A-Z][0-9A-Z]%[0-9A-Z][0-9A-Z]";
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(src);

    String osname = System.getProperty("os.name");
    if(osname.indexOf("Windows")>=0){
      // Windowsであったときの処理
    	 return src;
    } else if(osname.indexOf("Linux")>=0){
      // Linuxであったときの処理
    	 if(m.find() )
    	     // System.out.println("正規表現とマッチ");
    	     return src;
    	    else
    	     // System.out.println("正規表現とマッチしない");
    	       // return URLEncoder.encode(src).replace("+", "%20").replace("%3B", ";")
    	       	//	 .replace("%2F", "/").replace("%3F", "?").replace("%3A", ":")
    	       	//	 .replace("%40", "@").replace("%3D", "=").replace("%2B", "+")
    	       	//	 .replace("%24", "$").replace("%31", "!").replace("%7E", "~")
    	       	//	 .replace("%2C", ",").replace("%28", "(").replace("%29", ")")
    	       	//	 .replace("%23", "#").replace("%27", "'");
    	      return URLEncoder.encode(src);
    } else {
      // その他の環境だったときの処理
    	 return src;
    }




}
%>


<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.util.regex.Matcher" %>


<%

String shokuinid=request.getParameter("shokuinid");
String kairanid=request.getParameter("number");

      GregorianCalendar cal = new GregorianCalendar();
      SimpleDateFormat format = new SimpleDateFormat("yyyy年M月d日 E曜日");
      SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
      SimpleDateFormat format3 = new SimpleDateFormat("HHmm");
      String datestr = format.format(cal.getTime());
      String datestr_s = format2.format(cal.getTime());

//JDBCドライバを登録
Class.forName("com.mysql.jdbc.Driver");
//コネクションオブジェクトを取得
Connection conn = DriverManager.getConnection("jdbc:mysql://"+application.getInitParameter("hostname")+"/skt?user="+application.getInitParameter("mysqluser")+"&password="+application.getInitParameter("mysqlpass")+"&useUnicode=true&characterEncoding=utf-8");
conn.setReadOnly(true);;//読み取り専用にして高速化
Connection m_conn = DriverManager.getConnection("jdbc:mysql://"+application.getInitParameter("master_hostname")+"/skt?user="+application.getInitParameter("mysqluser")+"&password="+application.getInitParameter("mysqlpass")+"&useUnicode=true&characterEncoding=utf-8");


//ステートメントオブジェクトを取得
Statement stmt = conn.createStatement();
Statement stmt4 = m_conn.createStatement();
Statement stmt3 = m_conn.createStatement();
Statement stmt5 = conn.createStatement();
Statement stmt6 =conn.createStatement();
Statement stmt7 =conn.createStatement();


String strSql = "SELECT * FROM kairan where id="+kairanid;
      //問い合わせを実行してリザルトセットを取得
      ResultSet rs = stmt.executeQuery(strSql);
 rs.next();

 //次のメッセージと、前のメッセージ検索
 Integer nextID;
 ResultSet rs6=stmt6.executeQuery("select id From kairan where  FIND_IN_SET('"+shokuinid+"',hyoji) and id < "+kairanid+" order by date desc limit 1");
 try {
	 rs6.next();
	 nextID=rs6.getInt("id");
 }catch(Exception e){
	 nextID=-1;
 }



//String nextID=rs6.getString("name");
// ResultSet rs7=stmt7.executeQuery("select * From kairan where FIND_IN_SET('"+shokuinid+"',hyoji)  and id < "+kairanid+" order by id limit 2 ");
Integer prevID;
ResultSet rs7=stmt7.executeQuery("select id From kairan where  FIND_IN_SET('"+shokuinid+"',hyoji) and id > "+kairanid+" order by date limit 1");
try {
	rs7.next();
	prevID=rs7.getInt("id");
}catch(Exception e){
	prevID=-1;
}



 ResultSet rs4 = stmt4.executeQuery("select * from kairanlog where kairanid="+kairanid+" and shokuinid="+shokuinid);
 if(rs4.next()){
 stmt4.close();
 }else{
 stmt3.executeUpdate( "insert into kairanlog (kairanid,shokuinid,kidoku,date) values('"+kairanid+"','"+shokuinid+"','既読','"+datestr_s+"')");
}
 stmt3.close();
    %>




<!DOCTYPE html>
<html lang="ja">
<head>




	<meta charset="utf-8">
	<title>回覧板</title>

<link rel="stylesheet" type="text/css" media="screen" href="css/iconize.css" />
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!-- <script src="jQuery/jquery-1.7.2.js"></script> -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript" src="jQuery/ui/i18n/jquery.ui.datepicker-ja.js"></script>
<script type="text/javascript" src="js/jquery.upload-1.0.2.min.js"></script>




	<style>

		.htmlbox p { margin:0; padding:0; }

		.table211 a:link{ text-decoration: underline; }
	 	a:link { color: #0000ff; }
		a:visited { color: #000080; }
		a:hover { color: #ff0000; }
		a:active { color: #ff8000; }



		table.table211 {
 		 	width: 95%;
  			border-collapse: separate;
  			border-spacing: 2px;
        	font-size: 110%;

		}

		table.table211 th,
		table.table211 td {
 		 padding: 6px 6px;

		}


		table.table211 td {
  		 text-align: left;

		}

		table.table211 col.month {
 		width: 20%;
  		background: #CBD5FF;
		}

		table.table211 col.session {
  		background: #F2F5FF;
			}

		body {
 			font-size: 90%;
			text-align: center;
			margin: 0 5%;
		}

 		#tmsg  {
    		margin: 10px auto;


		}

		a.buttonar {
  /* サイズ指定 */
  width: 80px;
  height: 20px;
 display: inline-block;
   box-sizing: border-box;
  margin: 5px;

  /* 縦横中央揃え */
  text-align: center;
  vertical-align:middle;


  /* 色指定 */
  background-color:  #EEE;
  border: 1px solid #AAA;
  color: #555;

  /* 角丸 */
  border-radius: 2px;

  /* シャドウ / ベベル
  box-shadow: 0 1px 5px 1px rgba(0, 0, 0, 0.5), 0 1px 3px rgba(255, 255, 255, 0.9) inset, 0 -1px 3px rgba(0, 0, 0, 0.1) inset;
*/
  /* その他 */
  text-decoration: none;
  font-size: 16px;

}

a.buttonar:hover {
  /* 反転 */
  background-image: -webkit-linear-gradient(top, #AAA, #CCC);
}

	</style>




</head>
<body>
<br><br><br><br>
<div >
	　　　　　　<font size=+2 color='#FF6600'>＝　回　覧　板　＝</font>　<input type=submit id='pdf' value='PDF' title='プレビュー・印刷'>　　　　　　　
	<button class='modoru' id="modoru" >回覧板一覧</button>
	　　<a href="kairan_p_past.jsp?fmidoku=izen">2週間以上前</a>
	　<a href="kairan_p_past.jsp?fmidoku=true">未読</a>
	　<a href="kairan_p_past.jsp?fmidoku=sosin">送信済み</a>　　
	<%if (prevID==-1) {%>
	　　　　　　　　
	<%} else { %>
	<a href="kairan_msg.jsp?number=<%=prevID%>&shokuinid=<%=shokuinid%>" class="buttonar">↑上へ</a>
	<%} %>


	　　
		<%if (nextID==-1) {%>
		　　　　　　　　
		<%} else { %>
	<a href="kairan_msg.jsp?number=<%=nextID%>&shokuinid=<%=shokuinid%>" class="buttonar">↓下へ</a>
	<%} %>

</div>
<table width=100% id="tmsg" class="table211" >
  <col class="month" />
  <col class="session" />


  <tr>
    <td>件　名</td>
    <td><div id='kenmei'><%=rs.getString("title")%></div></td>

  </tr>
  <tr >
    <td>作成日</td>
    <td id=pd2><%=rs.getString("date")%></td>

  </tr>
   <tr >
    <td>作成者　　<button class='reply' id="reply" >返信</button></td>
    <td><img src="<%=rs.getString("user") %>.jpg?<%=Double.toString(Math.round( Math.random()*100000 )) %>" id="igazo" align="absmiddle">　<div id='sakuseisha'><%=rs.getString("name")%></div></td>

  </tr>
  <tr>
    <td>内　容	 </td>
    <td style="word-break: break-all;" class="htmlbox"><div id='naiyo'><%=rs.getString("msg").replace("\n","<br>")%></div></td>

  </tr>
 <tr>
    <td>添　付</td>
    <%
    String stenpu=rs.getString("tenpu");



Pattern p = Pattern.compile("<a href=\"FileDownloadServlet.filename=(.*?)\">(.*?)</a>",Pattern.DOTALL);
Matcher m = p.matcher(stenpu);
String result="";
while (m.find()){
	String fname=m.group(1);
	String text=m.group(2);
 result=result+"<a href=\"FileDownloadServlet?filename="+enc(fname)+"\">"+text+"</a><br>";
}
//stenpu.replace("><a", "><br><a").replace(">　<a", "><br><a").replace("<br><br>","<br>") izennokatachi
    %>
    <td id=pd5>
    <%=result%>
    </td>

  </tr>
  <tr>
    <td title="複数の宛先名のときは、番号の若い人１名のみ表示します。宛先名全員を表示したいときは、「詳細表示」をクリックしてください。青字の人は未読を表します。">宛先　　　　<button class='alist' id="alist">詳細表示</button></td>
    <%


    String atesak=rs.getString("hyoji");
    String ates[]=atesak.split(",");
     Integer maxi=ates.length;
     String atetenten="";


      Statement stmt2 = conn.createStatement();
      ResultSet rs2,rs5;

     String aslist="";String col1="";String col2="";
     for(int i = 0; i < maxi; i++) {
     try{
       rs2= stmt2.executeQuery("SELECT * FROM shokuin where id="+ates[i]+" order by sid");
       rs2.next();

       rs5 = stmt5.executeQuery("select * from kairanlog where kairanid="+kairanid+" and shokuinid="+ates[i]);
 		if(rs5.next()){
 		 col1="<font color='black' class='ates'>";col2="</font>";
 		}else{
 		 col1="<font color='blue' class='ates'>";col2="</font>";
 		}


      aslist=aslist+" "+col1+rs2.getString("name")+col2;
      if(i==1) {atetenten=atetenten+ " "+col1+rs2.getString("name")+col2;    }
      else if (i==2) {atetenten=atetenten+ "他";    }
     } catch(SQLException e) {
    		//メンバーが削除されてもエラーでないようにした
     }

     }
     stmt2.close();
     stmt5.close();
    %>

    <td><div style="display:inline;" id="aname2"><%=atetenten%>　</div><div style="display:none;" id="aname"><%=aslist%>　(未読者は<font color='blue'>青</font>)</div>　計<%=maxi%>名</td>

  </tr>

</table>



<% stmt.close();%>





<input type='hidden' id='sosinsha' value='<%=ates[0]%>'>

<input type='hidden' id='opath'>
<input type='hidden' id='opath2'>


<script>










	$(function() {


	　　　　$.post(
								'sette_p',
								{
	                              'flg':'yomi'
	                            },
	                            function(data){
	                            	 var st=data;
	                                   var dt=st.split('\t');

		                               $('#opath').val(dt[0]);
		                                $('#opath2').val(dt[1]);
	                          //     $('#opath').val(data);

		                            		jQuery('#igazo').attr('src',dt[1]+'mylogo/'+$('#igazo').attr('src'));

		                            		$('#igazo').error(function() {
		                            			//ファイルが存在しない画像はimgタグ自体を削除
		                            		    $('#igazo').remove();
		                            		});


	        });



		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );



		function henkan(moji){
							moji = moji.replace(/\r\n/g, "<br>");
							moji = moji.replace(/(\n|\r)/g, "<br>")
		return moji;
		}

//*****************************
			$( ".alist" )
			.button()
			.click(function() {
			    if($(this).text()=="詳細表示"){
			    $("#aname").attr('style','display:block');
			    $(".ates").attr('style','display:block');
			    $("#aname2").attr('style','display:none');
			    $(this).text('詳細非表示');
			    }else{
			     $("#aname").attr('style','display:none');
			     $("#aname2").attr('style','display:inline');
			    $(this).text('詳細表示');
			    }
			});



		$( ".modoru" )
			.button()
			.click(function() {
	         $(window.location).attr('href', 'kairan.jsp?rmsg=NULL');

	      });

		$( ".reply" )
		.button()
		.click(function() {
         $(window.location).attr('href', encodeURI('kairan.jsp?oflg=true&ratesakit='+$('#sakuseisha').text()+'&ratesaki='+$('#sosinsha').val()+'&rkenmei=RE:'+$('#kenmei').text()+'&rmsg=<br>-----Original Message-----<br>'+$('#naiyo').text()));

      });


		//＊＊＊＊＊＊＊＊＊＊＊＊＊＊******************************************************************
		 $('#pdf').click(function() {
			 var data = {'naiyo': '件名：'+$('#kenmei').html()+'<br>作成日：'+$('#pd2').html()+'<br>作成者：'+$('#sakuseisha').html()+'<br>内容：'+$('#naiyo').html()+'<br>添付：'+$('#pd5').html()+'<br>宛先:'+$('#aname').html()+'<br>', 'nichime':'0','fontsize':'14'};
			 postForm('pdf.jsp', data);
			         });



		 var postForm = function(url, data) {
		     var $form = $('<form/>', {'action': url, 'method': 'post'});
		     for(var key in data) {
		             $form.append($('<input/>', {'type': 'hidden', 'name': key, 'value': data[key]}));
		     }
		     $form.appendTo(document.body);
		     $form.submit();
		};




	});
	</script>


</body>

</html>
