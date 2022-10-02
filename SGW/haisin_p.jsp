<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メール配信設定</title>
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->

<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script>



$(function() {


 $('.hozon').button().click(function() {

                                                                            　$.post('mail_set',
								 {'flg':'hkaki',
	                              'haisin_ad':$("#haisin_ad").val(),
	                              'renraku_ad':$("#renraku_ad").val(),
	                              'shokuinid':$("#shokuinid").val()},
	                               function(res) { $("#disp").replaceWith('<br>'+res+'<br>');});

	                               } );


	$.post(
								'mail_set',
								{
	                              'flg':'hyomi',
	                              'shokuinid':$("#shokuinid").val()
	                            },
	                            function(data){
	                               var st=data;
                                   var dt=st.split('\t');

	                               $('#haisin_ad').val(dt[0]);
	                               $('#renraku_ad').val(dt[1]);
	                               $('#userN').append(dt[2].replace(/\s+$/, ""));
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　

	        });



});

</script>
<style>
body { font-size: 90%; }
</style>

</head>

<body>



<br><br><br>
<table align=center border=0 width=80%>
<tr><td style="text-align:left;">
　　　<h2>メール配信（連絡）のための設定</h2>　　利用者：<span id="userN"></span>　　　<button class='hozon' id="hozon">保存</button><br>
<br>
※ここで、設定したメールアドレスに、お知らせや回覧の内容を配信(転送）します。（<font color='red'>注！！：設定については組織内のセキュリティポリシーに従ってください。</font>）
<br>
配信を希望するメールアドレス：<input type='text' NAME="haisin_ad" id='haisin_ad' size=50><br>
<br><br>
※ここで、設定したメールアドレスに、お知らせや回覧の「件名のみ」を連絡します。<br>
件名の連絡を希望するメールアドレス：<input type='text' NAME="renraku_ad" id='renraku_ad' size=50>
</td></tr></table><br><br>

<font color='red'><span id='disp'>変更あれば、修正して保存をクリックしてください</span></font>

<%
String shokuinid =(String)session.getAttribute("shokuinid");
//String shokuinid=request.getParameter("shokuinid");

%>



<input type="hidden" value="<%=shokuinid%>" id="shokuinid">

</body>
</html>