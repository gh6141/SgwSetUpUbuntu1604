<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>password_set</title>
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script>



$(function() {

$('#mcheck:checkbox').click(function(){
	if($("#mcheck:checked").val()) {
	    $('#title_s').text("ログインパスワード及びメールチェック用パスワードの設定");
	   }
	   else {
		   $('#title_s').text("ログインパスワードパスワードの設定");
	   }
});


 $('.hozon').button().click(function() {


                                if　( $("#pass1").val()==$("#pass2").val() && $("#pass1").val()!=null )  {
                                 $.post('pass_set',
								 {'flg':'kaki',
	                              'password':$("#pass1").val(),
	                              'shokuinid':$("#shokuinid").val()},
	                               function(res) { $("#disp").replaceWith('<br>'+res+'<br>');});

                                 if($("#mcheck:checked").val()) {
                                	 $.post('mail_set',
                                		 {'flg':'kaki_pass',
                                		 'password':$("#pass1").val(),
                                		  'shokuinid':$("#shokuinid").val()},
                                		  function(res) { $("#disp").replaceWith('<br>'+res+'<br>');});
                                 }


                                }else {
                                　　　　　　　　　　　　　　　　　　　alert('パスワードをもう一度確認してください');
                                  $("#disp").replacewith('<br>パスワードが一致していません<br>');

                                }

	                               } );


	$.post(
								'pass_set',
								{
	                              'flg':'yomi',
	                              'shokuinid':$("#shokuinid").val()
	                            },
	                            function(data){
sst=data.split("\t");
	                               $('#pass1').val(sst[0].replace(/\s+$/, ""));
	                               $('#pass2').val(sst[0].replace(/\s+$/, ""));
	                               $('#userN').append(sst[1].replace(/\s+$/, ""));
	        });



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

%>

<br><br><br>
<table align=center border=0>
<tr><td style="text-align:left;">
</span><h2><span id="title_s">ログインパスワード及びメールチェック用パスワードの設定</span></h2>　　　　　　　　利用者：<span id="userN"></span>
　　　　　<button class='hozon' id="hozon">保存</button><br><br>

<br><br>

パスワード　　　　　　：<input type='password' NAME="pass1" id='pass1' size=50>
<br>パスワード（確認用）：<input type='password' NAME="pass2" id='pass2' size=50><br><br><br>
<input type="checkbox" id="mcheck" name="mcheck" value="メールチェック用パスワード" checked>メールチェック用のパスワードも同じにする<br>
（メールチェック用のパスワードを別のものに設定する場合は「設定」＞「メール」＞「メールチェック設定」で設定してください）
</td></tr></table><br><br>

<font color='red'><span id='disp'>変更した後、保存をクリックしてください</span></font>


<input type="hidden" value="<%=shokuinid%>" id="shokuinid">

</body>
</html>