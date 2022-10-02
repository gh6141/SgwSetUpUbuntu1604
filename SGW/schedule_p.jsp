<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>

<%@ page session="true" %>


<%
 //String userN="";
  //String shokuinid="";
 // String user="";
 // String userid="";



 // 内容: クッキーを使用する(クッキーの取得)

 // クッキーの配列を取得
// Cookie cookies[] = request.getCookies();

 // 目的のクッキーを格納する変数
// Cookie idval = null;

 // それぞれのクッキーに対して名前を確認
// if(cookies != null) {
 //    for(int i = 0; i < cookies.length; i++) {
         // 名前が "idval" であるかチェック
  //       if(cookies[i].getName().equals("idval")) {
            // 該当するクッキーを取得
  //           idval = cookies[i];
 //        }
 //    }
 //}

 // 表示する文字列
 //String sidval;

 // 該当するクッキーがみつからなかった場合
// if(idval == null) {
 //    sidval = "";
 //} else { // クッキーがみつかった場合は値を取得(URLデコードする)
 //   sidval = URLDecoder.decode(idval.getValue());
 //}


//JDBCドライバを登録
//Class.forName("com.mysql.jdbc.Driver");

//データベース接続文字列を作成
//String strConn = "jdbc:mysql://"+application.getInitParameter("hostname")+"/skt?user="+application.getInitParameter("mysqluser")+"&password="+application.getInitParameter("mysqlpass")+"&useUnicode=true&characterEncoding=utf-8";

//コネクションオブジェクトを取得
//onnection conn = DriverManager.getConnection(strConn);


//Statement stmt = conn.createStatement();
//ステートメントオブジェクトを取得

//ResultSet rs;
//String strSql2 = "SELECT * FROM shokuin where user='"+sidval+"'";
//ResultSet rs2 = stmt.executeQuery(strSql2);
//Integer c=0;
//while(rs2.next()&& c==0){
//userN=rs2.getString("name");
//shokuinid=rs2.getString("id");
//user=rs2.getString("user");
//c=c+1;
 //}

//rs2.close();

//******session shutoku*************************************
//session.setAttribute("shokuinid",shokuinid);

      GregorianCalendar cal = new GregorianCalendar();

      Calendar cal1 = Calendar.getInstance();  //(1)オブジェクトの生成
      int month = cal1.get(Calendar.MONTH) + 1;
      String tuki="00"+Integer.toString(month);
      tuki = tuki.substring(tuki.length()-2,tuki.length());

request.setCharacterEncoding("UTF-8");


    %>


<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<title>月の予定</title>

<link rel="stylesheet" type="text/css" media="screen" href="css/iconize.css" />
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript" src="jQuery/ui/i18n/jquery.ui.datepicker-ja.js"></script>
<script type="text/javascript" src="js/jquery.upload-1.0.2.min.js"></script>

	<style>
	 .ui-widget a:link{ text-decoration: underline; }
	 a:link { color: #0000ff; }
	a:visited { color: #000080; }
	a:hover { color:  #ff0000;}
	a:active { color: #ff8000; }
		body { font-size: 90%; }
		button {height:32px;}
		label {text-align:left;display:block}
		 input { text-align:left}
		input.text,textarea { margin-bottom:12px; width:100%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:25px; }
		h1 { font-size: 1.2em; margin: .6em 0; }
		div#hyo {text-align:center;}
		         table   {margin-left:auto;margin-right:auto;}
         caption {margin-left:auto;margin-right:auto;}
		div#users-contain { width:90%;  }
		div#users-contain table { border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { padding: .6em .6em; text-align: left; }
		div#users-contain table th {border: 1px solid #fff;    }
        .nakawaku  {  border: 1px solid #ddd;          }
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
body {
text-align: center;
}
div#users-contain  {
    margin: 0 auto;
}
	</style>

	<script>
		$.ajaxSetup({ cache: false });

	$(function() {
		  $('<font color=red>データの読み込み中...しばらくお待ちください</font>').appendTo('#yotei2');
		  $('#gatu').val('<%=tuki %>');
	   $.get('poi',	{'month':'<%=tuki %>','hiduke':'', 'hiduke2':'' },
	             function(data){
		  				 $('#yotei2').empty();
	                              st=data;
	                        $(st).appendTo('#yotei2');
	        });




$(function(){
     $(".tooltip input").hover(function() {
        $(this).next("span").animate({opacity: "show", top: "-75"}, "slow");}, function() {
               $(this).next("span").animate({opacity: "hide", top: "-85"}, "fast");
     });

     $('#gatu').change(function(){
        // alert(jQuery('option:selected').text());
         $('#yotei2').empty();
         $('<font color=red>エクセルデータの読み込み中...しばらくお待ちください</font>').appendTo('#yotei2');
         $.get('poi',	{'month':$('#gatu').val(),'hiduke':'', 'hiduke2':'' },
	             function(data){
	                              st=data;
	                              $('#yotei2').empty();
	                        $(st).appendTo('#yotei2');
	        });

     });

});
	});
	</script>
</head>
<body>
     <!--***********************************************************************************  -->
<select id="gatu" >
  <option value="04">４月</option>
  <option value="05">５月</option>
  <option value="06">６月</option>
  <option value="07">７月</option>
    <option value="08">８月</option>
  <option value="09">９月</option>
  <option value="10">１０月</option>
  <option value="11">１１月</option>
    <option value="12">１２月</option>
  <option value="01">１月</option>
  <option value="02">２月</option>
  <option value="03">３月</option>
</select>の予定<br><br>
        <div id="yotei2" ></div>



</body>
</html>
