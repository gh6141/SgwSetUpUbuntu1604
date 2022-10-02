<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%@ page session="true" %>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mylogo settei</title>
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.upload-1.0.2.min.js"></script>
<script>
//***************************::iframe error shori
<%
String patht = getServletContext().getRealPath("/WEB-INF/opath2.txt");
String str2 = "";String stmp="";
BufferedReader in2=new BufferedReader(new FileReader(patht));
while((str2=in2.readLine())!=null) {
	//out.println(str2);
	stmp=stmp.trim()+str2.trim();
}
in2.close();
String path2 =stmp.trim() ;
%>

//********************************************************************************
$(function() {

	$("#myForm").submit(function(){
		$("#reply").html("<br>　　　　<font color='red'>しばらくお待ちください...</font>");
	    var $form, fd;
	    $form = $(this);
	    fd = new FormData($form[0]);
	    $.ajax($form.attr("action"), {
	      type: 'post',
	      processData: false,
	      contentType: false,
	      data: fd,
	      dataType: 'html',
	      success: function(data){
	        $("#reply").html(data);
	        $('#myicon').attr('src',dt[1]+'mylogo/'+sidval+'.jpg?'+Math.round( Math.random()*100000 ).toString(10));
	      }
	    });
	    return false;
	  });



	 $('#help').error(function() {
			//ファイルが存在しない画像はdefault.jpg or dell
       //   $(this).attr('src', 'default.jpg');
	        $('#help').remove();
	    });

	function rCheck()
	{
		if (window.name != "xyz")
		{
			//alert("リロードしました");
			location.reload();
			window.name = "xyz";
		}
	}

	rCheck();
var dt;
$.post(
								'pass_set',
								{
	                              'flg':'yomi',
	                              'shokuinid':$("#shokuinid").val()
	                            },
	                            function(data){
									sst=data.split("\t");
	                               $('#userN').append(sst[1].replace(/\s+$/, ""));
	                               $('#userID').append(sst[2].replace(/\s+$/, ""));

	                               sidval=sst[2].replace(/\s+$/, "");
	                               $('#userID2').val(sidval);
	                               $.post(
	                            			'sette_p',
	                            			{
	                            	          'flg':'yomi'
	                            	        },
	                            	        function(data){
	                            	         var st=data;
	                            	           dt=st.split('\t');
	                            	            $('#myicon').attr('src',dt[1]+'mylogo/'+sidval+'.jpg?'+Math.round( Math.random()*100000 ).toString(10));


	                            	});
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
　　　<h2>　　ロゴの設定　　</h2>　　　　　　　　利用者：<span id="userN"></span>　ID:<span id="userID"></span>
　　　　　<br><br>
　　　※自分のロゴ（オリジナルのマーク、似顔絵、写真等可）を登録することができます。<br>
　　　※トップページの右上と「お知らせ」・「回覧」の自分が投稿したメッセージの名前の脇に表示されます。<br>
　　　<img src="dummy.jpg" id="myicon">

<br>
<br>

<form id="myForm" name="myForm" action="UploadImage" method="post" enctype="multipart/form-data">
　　　元になる画像ファイル（Jpgファイル）を選択してください：
<br>
　　　<input type="file" name="filename" size="50">
<br>
　　　画像の縦幅を<input type="text" name="height" size=4 value="25">pxに縮小します<br><br>
<span title="登録または削除を選んで実行をクリックしてください">
　　　<select name="sosa">
<option value="save" selected>登録</option>
<option value="del">削除</option>
</select>
<input type="submit" value="実行" id="submitBtn">
<input type="hidden" value="" id="userID2" name="userID2">
</span>
</form>
<div id="reply"></div>

</td></tr></table><br><br>


<br>サイズが大きいと縮小変換・登録のために数秒かかります。10MBを超える場合は縮小変換・登録ができません。<br>
（Tomcat ver7以上で対応）
<br>
<p style="text-align: center;">
<iframe src="<%=path2 %>mylogohelp.htm" id="mylogohelp" name="mylogohelp" width="800" height=400" id="help" align="middle">
</iframe></p>
（フレーム内で404エラーが表示された場合は、<%=path2 %>mylogohelp.htmのページがあるか要確認)
<br>

<input type="hidden" value="<%=shokuinid%>" id="shokuinid">


</body>
<script type='text/javascript'>

</script>

</html>