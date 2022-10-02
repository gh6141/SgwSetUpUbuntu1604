<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.File"%>


<%


	%>
	<%@ include file="msyqlcon.jsp" %>
	<%

	//ステートメントオブジェクトを取得
	Statement stmt = conn.createStatement();



	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat format = new SimpleDateFormat("yyyy年M月d日 E曜日");
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat format3 = new SimpleDateFormat("HHmm");
	String datestr = format.format(cal.getTime());
	String datestr_s = format2.format(cal.getTime());
%>


<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>Link</title>


<link rel="stylesheet" type="text/css" media="screen"
	href="css/iconize.css" />
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript"
	src="jQuery/ui/i18n/jquery.ui.datepicker-ja.js"></script>
<script type="text/javascript" src="js/jquery.upload-1.0.2.min.js"></script>


<style>
a:link {
	color: #0000ff;
}

a:visited {
	color: #000080;
}

a:hover {
	color: #ff0000;
}

a:active {
	color: #ff8000;
}

.ui-widget a:link {
	text-decoration: underline;
}

body {
	font-size: 90%;
}

button {
	height: 32px;
}

label {
	text-align: left;
	display: block
}

input {
	text-align: left
}

input.text,textarea {
	margin-bottom: 12px;
	width: 100%;
	padding: .4em;
}

fieldset {
	padding: 0;
	border: 0;
	margin-top: 5px;
}

h1 {
	font-size: 1.2em;
	margin: .6em 0;
}

div#users-contain {
	width: 88%;
	margin: 10px 0;
}

div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}

div#users-contain table td,div#users-contain table th {
	border: 1px solid #ccc;
	padding: .1em 10px;
	text-align: left;
}

.nakawaku {
	border: 1px solid #ddd;
}

.ui-dialog .ui-state-error {
	padding: .3em;
}

.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}

body {
	text-align: center;
}

div#users-contain {
	margin: 0 auto;
}

<!--
div.ScrollBox {
	overflow: auto;
	width: 230px;
	height: 200px;
	border: 1px gray solid;
	margin: 15px;
	text-align: left;
	font-size: 120%;
}
-->
</style>

<script>


	$(function() {


//*************************初期の設定**********************************************************************
		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );

		var label = $( "#label" ),
			url = $( "#url" ),
			allFields = $( [] ).add( label ).add( url) ,
			tips = $( ".validateTips" );

//************function***************
		function updateTips( t ) {
			tips
				.text( t )
				.addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}

		function checkLength(o, n, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {
				updateTips(  n + "の文字数は " +min + " ～ " + max + "の範囲にしてください" );
				return false;
			} else {
				return true;
			}
		}

		function henkan(moji){
							moji = moji.replace(/\r\n/g, "<br>");
							moji = moji.replace(/(\n|\r)/g, "<br>")
		return moji;
		}

//*********************************新規　dialog	入力すべて終わって　POST後　最初の画面にもどる

		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 500,
			width: 700,
			modal: true,
			buttons: {
				"保存": function() {

					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkLength( label, "表示名", 1, 100 );
					bValid = bValid && checkLength( url, "URL", 1, 200 );

					if ( bValid ) {
						$.post(
								'RequestServ_link',
								{
	                              'oper': 'add',
	                              'label': label.val(),
	                              'url': url.val()
	                            },
	                            function(data){


	            				$( "#dialog-form" ).dialog( "close" );
	            				location.reload();

	                             }
						 );
					}
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});
// 変更のダイアログ

		$( "#dialog-form_henko" ).dialog({
			autoOpen: false,
			height: 500,
			width: 700,
			modal: true,
			buttons: {
				"変更の保存": function() {
					var	bValid = true;
					allFields.removeClass( "ui-state-error" );
					if ( bValid ) {


						$.post(
								'RequestServ_link',
								{
	                              'oper':  'update',
	                              'number': $("#number").val(),
	                              'label': $("#hlabel").val(),
	                              'url': $("#hurl").val()
	                            },
	                            function(data){

            						$( "#dialog-form_henko" ).dialog( "close" );
            						location.reload();

	                            }
						 );
					}
				},

				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});


		$( "#sinkitoroku" )
			.button()
			.click(function() {
				$( "#dialog-form" ).dialog( "open" );
			});


//***********************************最初の画面の編集　削除　ボタン　クリックしたとき　→　編集又は新規ダイアログが開く

		$( ".henko" )
			.button()
			.click(function(e) {
			//*********************************
			$( "#dialog-form_henko" ).dialog( "open" );
				var cid = e.currentTarget.id;
				$("#number").val(cid);

				$( "#hlabel" ).val($("#ky"+cid).val());
				$( "#hurl" ).val($("#tn"+cid).val());


			});


	   $( ".sakujo" )
			.button()
			.click(function(e) {
				var cid = e.currentTarget.id;
				cid=cid.replace('del','');
				    	　　　　
　　　　　　　					　$.post(
								'RequestServ_link',
								{
	                              'oper':'del','number':cid
	                            },
	                            function(data){
	                                $("#tr"+cid).remove();
            						$( "#dialog-form_henko" ).dialog( "close" );
	                            }
						   );
　　　　

			});


	});
	</script>
</head>
<body>

	<div class="demo">

		<div id="dialog-form" title="新規作成">
			<form>
				<fieldset>
				<br>
					<label for="label">表示名</label>
					  <input type="text" name="label" id="label" value="" class="text ui-widget-content ui-corner-all" />

					 <label	for="url">URL</label>
					   <input type="text" name="url" id="url" value="" class="text ui-widget-content ui-corner-all" />
				</fieldset>
			</form>
		</div>

		<div id="dialog-form_henko" title="編集">
			<form>
				<fieldset>
					<input type="hidden" name="number" id="number" /> <br>
					<br><br>
					<label for="label">表示名</label>
					  <input type="text" name="label" value=""
						id="hlabel" class="text ui-widget-content ui-corner-all" />

					 <label	for="kikan">URL</label>
					  <input type="text" name="url" id="hurl" value=""	class="text ui-widget-content ui-corner-all" />

				</fieldset>
			</form>
		</div>

		<br>
		<br>
		<br>

		<font size=+2 color='green'>=　共有リンク=</font>

		<div id="users-contain" class="ui-widget">

			<table id="users" class="ui-widget ui-widget-content">
				<thead>
					<tr class="ui-widget-header ">

						<th>表示名</th>
						<th title="登録ができます。"><button id="sinkitoroku">新規登録</button>
						</th>
					</tr>
				</thead>
				<tbody>


					<%
						String strSql = "SELECT * FROM link ";
						ResultSet rs = stmt.executeQuery(strSql);

						String linkid, date, classN, dateN;
						Integer cou = 0;

						while (rs.next() ) {
							linkid = rs.getString("id");
					%>
					<tr id="tr<%=linkid%>">
						<td  name="ky" ><a href='<%=rs.getString("url")%>'"><%=rs.getString("label")%></a></td>
<input type="hidden" name="number" id="tn<%=linkid%>" value="<%=rs.getString("url")%>"/>
<input type="hidden" name="number" id="ky<%=linkid%>" value="<%=rs.getString("label")%>"/>
						<td width='150px' 　id="bt<%=linkid%>" 　 title="「編集」「削除」ボタン">
							<button class='henko' id="<%=linkid%>">編集</button>
							<button class='sakujo' id="del<%=linkid%>">削除</button>
						</td>
					</tr>
					<%

						}
						stmt.close();
					%>
				</tbody>
			</table>
		</div>
	</div>
	<!-- End demo -->


</body>
</html>

