<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.File"%>


<%


	// 内容: クッキーを使用する(クッキーの取得)

	// クッキーの配列を取得
	Cookie cookies[] = request.getCookies();

	// 目的のクッキーを格納する変数

	Cookie kensuh = null;

	// それぞれのクッキーに対して名前を確認
	if (cookies != null) {


		  for(int i = 0; i < cookies.length; i++) {
		         if(cookies[i].getName().equals("kensuh")) {
		            // 該当するクッキーを取得
		             kensuh = cookies[i];
		         }
		     }


	}

	// 表示する文字列
	String  skensuh;



	if (kensuh == null) {
		skensuh = "20";
	} else { // クッキーがみつかった場合は値を取得(URLデコードする)
		skensuh = URLDecoder.decode(kensuh.getValue());
	}

	%>
	<%@ include file="msyqlcon.jsp" %>
	<%

	//ステートメントオブジェクトを取得
	Statement stmt = conn.createStatement();
	//Statement stmt3 = conn.createStatement();
	//Statement stmt4 = conn.createStatement();



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
<title>授業変更</title>


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

        $("#hiduke,#hhiduke").datepicker({showOn: 'focus'});

//*************************初期の設定**********************************************************************
		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );

		var kyoka = $( "#kyoka" ),
			tanto = $( "#tanto" ),
			classN = $( "#class" ),
			hiduke = $( "#hiduke" ),
			koji = $("#koji"),
			tenpu =$("#tenpu"),
			allFields = $( [] ).add( kyoka ).add( tanto ).add( classN ).add( hiduke ).add(koji),
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
			width: 200,
			modal: true,
			buttons: {
				"保存": function() {

					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkLength( kyoka, "教科等", 0, 20 );
					bValid = bValid && checkLength( tanto, "担当", 0, 25 );
					bValid = bValid && checkLength( hiduke, "日付", 1, 50 );
					bValid = bValid && checkLength( koji, "校時", 1, 600 );
					bValid = bValid && checkLength( classN, "クラス", 1, 300 );

					if ( bValid ) {
						$.post(
								'RequestServ_henko',
								{
	                              'oper': 'add',
	                              'kyoka': kyoka.val(),
	                              'tanto': tanto.val(),
	                              'class': classN.val(),
	                              'date':hiduke.val(),
	                              'jikan': koji.val()

	                            },
	                            function(data){

	                      $( "#users tbody" ).prepend( "<tr><td></td><td>[" + tanto.val()+"]" + kyoka.val() + "</td><td><b>"
	                      + hiduke.val() + "</b></td><td>編集には再読込</td></tr>" );

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
			width: 200,
			modal: true,
			buttons: {
				"変更の保存": function() {
					var	bValid = true;
					allFields.removeClass( "ui-state-error" );
					if ( bValid ) {
						txtVal= henkan(koji.val());

						$.post(
								'RequestServ_henko',
								{
	                              'oper':   'update','number': $("#number").val(),'kyoka': $("#hkyoka").val(),'tanto': $("#htanto").val(),
	                              'class': $("#hclass").val(),'date':   $("#hhiduke").val(), 'jikan':$("#hkoji").val()
	                            },
	                            function(data){
	                              // alert(data);
	                          //    location.reload(true);
	                                $("#nm"+$("#number").val()).replaceWith("<td>" + $("#hkyoka").val() + "<br>[" +$("#htanto").val()+"]</td>");
	                                $("#tm"+$("#number").val()).replaceWith("<td><b>" +$("#hhiduke").val() + "</b></td>");
	                                 $("#class"+$("#number").val()).replaceWith($("#hclass").val());
	                                  $("#msg"+$("#number").text()).replaceWith($("#hkoji").val());


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

				$( "#hkyoka" ).val($("#ky"+cid).text());
				$( "#htanto" ).val($("#tn"+cid).text());
				$( "#hclass" ).val($("#cl"+cid).text());
				$( "#hhiduke" ).val($("#dt"+cid).text());
				$( "#hkoji" ).val($("#kj"+cid).text());

			});


	   $( ".sakujo" )
			.button()
			.click(function(e) {
				var cid = e.currentTarget.id;
				cid=cid.replace('del','');
				    	　　　　
　　　　　　　					　$.post(
								'RequestServ_henko',
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
					<select id="koji"  style="width: 100px; font-size: 22px">
							 	<option value="1">1</option>
  								<option value="2">2</option>
  								<option value="3">3</option>
  								<option value="4">4</option>
    							<option value="5">5</option>
  								<option value="6">6</option>
  								<option value="7">7</option>
					</select> 校時
				<br>


					<br> <label for="hiduke">日付</label>

					<input type="text"	name="hiduke" id="hiduke" value=""	class="text ui-widget-content ui-corner-all" />



					<label for="class">クラス</label>
					  <input type="text" name="class" id="class" value="" class="text ui-widget-content ui-corner-all" />

					<label for="kyoka">教科等</label>
					  <input type="text" name="kyoka" id="kyoka" value="" class="text ui-widget-content ui-corner-all" />

					 <label	for="tanto">担当</label>
					   <input type="text" name="tanto" id="tanto" value="" class="text ui-widget-content ui-corner-all" />
				</fieldset>
			</form>
		</div>

		<div id="dialog-form_henko" title="編集">
			<form>
				<fieldset>
					<input type="hidden" name="number" id="number" /> <br>


							<select id="hkoji"  style="width: 100px; font-size: 22px">
							  	<option value="1">1</option>
  								<option value="2">2</option>
  								<option value="3">3</option>
  								<option value="4">4</option>
    							<option value="5">5</option>
  								<option value="6">6</option>
  								<option value="7">7</option>
							</select> 校時
				<br><br>


					<label	for="hhiduke">日付</label>
					 <input type="text" name="hhiduke"
						id="hhiduke" value="" class="text ui-widget-content ui-corner-all" />



					<label for="hclass">クラス</label>
					  <input type="text" name="class"	id="hclass" value="" class="text ui-widget-content ui-corner-all" />

					<label for="kyoka">教科等</label>
					  <input type="text" name="kyoka" value=""
						id="hkyoka" class="text ui-widget-content ui-corner-all" />

					 <label	for="kikan">担当</label>
					  <input type="text" name="tanto" id="htanto" value=""	class="text ui-widget-content ui-corner-all" />

				</fieldset>
			</form>
		</div>

		<br>
		<br>
		<br>

		<form method="POST" action="henko_kensu"　><font size=+2 color='green'>=　授業変更　一覧=</font>
		　　　<span title="一覧に表示される件数を制限できます">最新<input type='text' size='2' id=kensuh name='kensuh'
		value='<%=skensuh%>'>件表示に<input type="submit" value="設定"　　></font></span>　　　　　

		　　　　</form>　　　　　　



		<div id="users-contain" class="ui-widget">

			<table id="users" class="ui-widget ui-widget-content">
				<thead>
					<tr class="ui-widget-header ">
						<th>授業日</th>
						<th>クラス</th>
						<th>校時</th>
						<th>教科等</th>
						<th>担当</th>
						<th title="授業変更の登録ができます。"><button id="sinkitoroku">新規登録</button>
						</th>
					</tr>
				</thead>
				<tbody>


					<%
						String strSql = "SELECT * FROM henko order by date desc , class , jikan";
						ResultSet rs = stmt.executeQuery(strSql);

						String henkoid, date, classN, dateN;
						Integer cou = 0;

						while (rs.next() && cou< Integer.parseInt(skensuh)  ) {
							henkoid = rs.getString("id");
					%>
					<tr id="tr<%=henkoid%>">
						<td width=100px id="dt<%=henkoid%>" name="kd"><%=rs.getString("date")%></td>
						<td width='25%' id="cl<%=henkoid%>" name="cl"><%=rs.getString("class")%></td>
						<td width=35px id="kj<%=henkoid%>" name="kj"><%=Integer.toString(rs.getInt("jikan"))%></td>
						<td id="ky<%=henkoid%>" name="ky" ><%=rs.getString("kyoka")%></td>
						<td id="tn<%=henkoid%>" name=tn"><%=rs.getString("tanto")%></td>
						<td width='150px' 　id="bt<%=henkoid%>" 　 title="「編集」「削除」ボタン">
							<button class='henko' id="<%=henkoid%>">編集</button>
							<button class='sakujo' id="del<%=henkoid%>">削除</button>
						</td>
					</tr>
					<%
						cou = cou + 1;
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