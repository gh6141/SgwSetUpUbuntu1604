<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sample100</title>
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<script src="jQuery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script>



$(function() {


 $('.hozon').button().click(function() {


                                if　( $("#pass1").val()==$("#pass2").val() && $("#pass1").val()!=null )  {
                                                                            　$.post('mail_set',
								 {'flg':'kaki',
	                              'mailname':$("#mailname").val(),
	                              'password':$("#pass1").val(),
	                              'pop3':$("#pop3").val(),
	                              'shokuinid':$("#shokuinid").val()},
	                               function(res) { $("#disp").replaceWith('<br>'+res+'<br>');});

                                }else {
                                　　　　　　　　　　　　　　　　　　　alert('パスワードをもう一度確認してください');
                                  $("#disp").replacewith('<br>パスワードが一致していません<br>');

                                }

	                               } );


	$.post(
								'mail_set',
								{
	                              'flg':'yomi',
	                              'shokuinid':$("#shokuinid").val()
	                            },
	                            function(data){
	                               var st=data;
                                   var dt=st.split('\t');

	                               $('#mailname').val(dt[0]);
	                               $('#pass1').val(dt[1]);
	                               $('#pass2').val(dt[1]);
	                                 $('#pop3').val(dt[2]);

　　　　　　　　　　　　　　　　　　　　　　　　　　　　　

	        });



});

</script>
<style>
body { font-size: 90%; }
</style>

</head>

<body>



<br><br><br>
<table align=center border=0>
<tr><td style="text-align:left;">
<h2>メールチェックのための設定</h2><button class='hozon' id="hozon">保存</button><br><br>
※ここで、設定したメールアカウントに　メールが届いていた場合　トップページでお知らせします。ただし、メールの中身は、メールソフトでないと閲覧できません。
<br><br>
メールアカウント名：<input type='text' NAME="mailname" id='mailname' size=50><br>
<br><br>

パスワード　　　　　　：<input type='password' NAME="pass1" id='pass1' size=50>
<br>パスワード（確認用）：<input type='password' NAME="pass2" id='pass2' size=50><br><br><br>

POP3サーバ：<input type='text' NAME="pop3" id='pop3' size=50>
</td></tr></table><br><br>

<font color='red'><span id='disp'>変更あれば、修正して保存をクリックしてください</span></font>

<%
String shokuinid =(String)session.getAttribute("shokuinid");
//String shokuinid=request.getParameter("shokuinid");

%>



<input type="hidden" value="<%=shokuinid%>" id="shokuinid">

</body>
</html>