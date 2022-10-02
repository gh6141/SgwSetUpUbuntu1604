<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>password_reset</title>
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script>


$(function() {


 $('.hozon').button().click(function() {

                                if　( $("#pass1").val()==$("#pass2").val() && $("#pass1").val()!=null )  {
                                 	if ($("#mysqlpass").val()==$("#dbpass").val()){
                                  	$.post('pass_set',
           								 {'flg':'kaki_rst',
           	                              'password':$("#pass1").val(),
           	                              'userD':$("#userD").val()},
           	                               function(res) { $("#disp").replaceWith('<br>'+res+'<br>');});

                                 	}else{
                                 		alert('データベースのパスワードが違います');

                                 	}
                                }else {
                                alert('２か所に入力した仮パスワードが一致していません');

                                }
	                               } );

});

</script>
<style>
body { font-size: 90%; }
</style>

</head>

<body>

<%
String shokuinid =(String)session.getAttribute("shokuinid");
//String shokuinid=request.getParameter("shokuinid");
String mysqlpass=application.getInitParameter("mysqlpass");

%>

<br><br><br>
<table align=center border=0>
<tr><td style="text-align:left;">
</span><h2><span id="title_s"仮のログインパスワード発行</span></h2>　　　　　　　　
　　　　　<button class='hozon' id="hozon">保存</button><br><br>
パスワードを忘れてしまったユーザーに仮パスワードを発行できます。<br>
仮パスワードでログインしてもらったら、自分で決めたパスワードに変更してもらうようにしてください。
<br><br>

データベースのパスワード（管理者に確認） :<input type='password' NAME="dbpass" id='dbpass' size=50>
<br>
<br>パスワードを変更したいユーザー（ログイン用のユーザー名)　　：<input type='text' NAME="userD" id='userD' size=50>
<br>仮のパスワード（ログイン用の仮パスワードを入力）　　：<input type='password' NAME="pass1" id='pass1' size=50>
<br>仮のパスワード（確認のため上と同じパスワードを入力）：<input type='password' NAME="pass2" id='pass2' size=50><br><br><br>

</td></tr></table><br><br>

<font color='red'><span id='disp'>変更した後、保存をクリックしてください</span></font>

<input type="hidden" value="<%=mysqlpass%>" id="mysqlpass">

</body>
</html>