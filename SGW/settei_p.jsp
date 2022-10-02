<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>settei</title>
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script>



$(function() {

 $('.hozon').button().click(function() {
                                                                           　$.post('sette_p',
								 {'flg':'kaki',
	                              'osirase_path':$('#osirase_path').val(),
	                              'osirase_path2':$('#osirase_path2').val(),
	                              'excel_path':$('#excel_path').val(),

	                              'excel_komoku':$('#excel_komoku').val(),
	                              'sosin_ad':$('#sosin_ad').val(),
	                              'smtp':$('#smtp').val(),
	                              'port':$('#port').val(),
	                              'sosin_pass':$('#sosin_pass').val()},
	                              function(res) {  $('#disp').replaceWith('<br>'+res+'<br>');} );
	                               } );

 $( ".sakujo" )
	.button()
	.click(function(e) {

			answer=confirm('指定番号以前のデータをすべて削除（または移動）してもよろしいですか？');

			if( $('[name=sosa]').val()=="osirasedel" ){
				var svlt='RequestServ_osirase';
				var opr='ikkatu_del';
			}else if($('[name=sosa]').val()=="osirasemove")	{
				var svlt='RequestServ_osirase';
				var opr='ikkatu_move';
			}else{
				var svlt='RequestServ_kairan';
				var opr='ikkatu_del';
			}

				if(answer==true&&$('#kikan_e').val().substring(0,1)=="#"){
				　$.post(
						svlt,
						{
                       'oper':opr,'kikan_e':$('#kikan_e').val().slice(1),'opath':$('#osirase_path').val(),'opath2':$('#osirase_path2').val()
                     },
                     function(data){

                        alert("実行しました");

 						//$(location).attr("href", "top.jsp");
                     }
				   );
				}else{
						alert("指定した形式で数字を入力してください")
				　}


	});




	$.post(
								'sette_p',
								{
	                              'flg':'yomi'
	                            },
	                            function(data){
	                               var st=data;
                                   var dt=st.split('\t');

	                               $('#osirase_path').val(dt[0]);
	                               $('#osirase_path2').val(dt[1]);
	                               $('#excel_path').val(dt[2]);
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
									$('#excel_komoku').val(dt[3]);
									$('#sosin_ad').val(dt[4]);
									$('#smtp').val(dt[5]);
									$('#port').val(dt[6]);
									$('#sosin_pass').val(dt[7]);

	        });



});

</script>
<style>
body { font-size: 90%; }
</style>

</head>

<body>
<br><br><br>

<table align=center border=0 width=90%>
<tr><td style="text-align:left;">
<h2>設定</h2><button class='hozon' id="hozon">保存</button><br><br>

添付ファイル読み込みパス（サーバからみた場所）：<input type='text' NAME="osirase_path" id='osirase_path' size=50>
<br>linuxでは/を使う、末尾に/をつける<br>web.xmlにmaster_tenpuという項目がありここには、添付ファイルの書き込みパスを設定するが、通常はこの欄と一致させる<br>
<br>mysqlは、レプリケーション機能で負荷の分散化も可能。その際は、web.xmlのmaster_hostnameを書き込み用のホストとして指定する
<br>※windowsでは /path/はダウンロードの際にカレントドライブ:\path\のように変換する。
<br><br>

添付ファイル読み込み場所（ユーザーからみた場所）：<input type='text' NAME="osirase_path2" id='osirase_path2' size=50>
<br>例．「../tenpu/」とする。この設定を変更すると、コンテキスト.xmlファイルも変更必要になるので、通常は変更しない。<br>
　　ただし、分散化のため複数PCをサーバにしている場合、一台でもWindowsがある場合は、http://マスターのHost名:8080/tenpu/のように指定する。（画像挿入の不具合防止）
<br><br>

予定表エクセルファイルの読み込み場所およびファイル名：<input type='text' NAME="excel_path" id='excel_path' size=50>
<br>
月のタブは４月、５月、、、３月、４（次年度）の順に並んでいる必要があります。
<br>
<br>
予定表エクセルデータから抽出する項目（，区切り）：<input type='text' NAME="excel_komoku" id='excel_komoku' size=80>
<br><br>

メール配信の送信アドレス：<input type='text' NAME="sosin_ad" id='sosin_ad' size=50>
<br>
メール配信のSMTPサーバ：<input type='text' NAME="smtp" id='smtp' size=50>
<br>
メール配信のポート番号：<input type='text' NAME="port" id='port' size=50>(通常は空欄）
<br>
メール配信のパスワード：<input type='password' NAME="sosin_pass" id='sosin_pass' size=50>(送信で認証不要のときは空欄）
<br><br>
<b><font color='red'><span id='disp'>変更あれば、修正して保存をクリックしてください</span></font></b>
</td></tr>
</table><br>

<Br>
<br>
<div align=left>
　　　　　　<b><<<<メッセージの一括移動または削除>>>></b>
<bR>　　　　　　<font color='red'>いったん実行するともとにもどせません。必要あれば、データベースと添付ファイルのバックアップ行ってから実行してください。</font>
<br>
　　　　　　<select name="sosa">
<option value="osirasemove" selected>お知らせデータ(keijiban)の過去データ領域(past_keijiban）への移動</option>
<option value="osirasedel" >お知らせの過去データ(pasut_keijiban)削除</option>
<option value="kairandel">回覧データ(kairan)の削除</option>
</select> を <input type='text' NAME="kikan_e" id='kikan_e' size=5>番目以下のメッセージに対して　　一括で<button class='sakujo' id="del">実行</button>
<br>
　　　　　　「お知らせ」「回覧」の「編集」「削除」ボタンにマウスを合わせると、メッセージ番号が表示されます。
<br>
　　　　　　「回覧」のタイトルに＊(*)がついたメッセージは一括削除はできないようにしてあります。
<br>
　　　　　　一括削除の機能については、利用者の方針に沿って利用ください。
<br>
　　　　　　(お知らせデータの移動については、過去データ領域に移動すると編集と個別の削除ができなくなります。それ以外は利用上支障となることはありません。)
<br>
　　　　　　<font color="red">回覧のデータは、古いデータがたまってくると、topページの表示が遅くなることがあります。その際は、適宜、削除してください。タイトルに＊印のついたものは残ります。</font>



</div>

</body>
</html>