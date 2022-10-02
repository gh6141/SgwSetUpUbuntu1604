<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%


%>
<%@ include file="msyqlcon.jsp" %>
<%


//ステートメントオブジェクトを取得
Statement stmt = conn.createStatement();

//SQLコマンドを作成
String strSql = "SELECT * FROM shokuin order by sid";

//問い合わせを実行してリザルトセットを取得
ResultSet rs = stmt.executeQuery(strSql);
%>



<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<TITLE>shokuin add</TITLE>
<link rel="stylesheet" type="text/css" media="screen"
	href="css/jquery-ui-1.8.21.custom.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="css/ui.jqgrid.css" />

<!-- <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script> -->
<script type="text/javascript" src="js/grid.locale-ja.js"></script>
<script type="text/javascript" src="js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="js/grid.loader.js"></script>



<script type="text/javascript">

jQuery(document).ready(function()
{
var lastsel2 = null;



 var savedRow = null;
 var savedCol = null;


    jQuery("#list").jqGrid({
        data: mydata,
        datatype: "local",
        colNames:['ID', '氏名', 'ｕｓｅｒ','表示順'],
        // 編集可能にするセルを editable:true にします。
        colModel:[
            {index:'rid', name:'rid', width:50 },
            {index:'name', name:'name', width:150, editable:true },
            {index:'user', name:'user', width:250, editoptions:{maxlength:50}, editable:true },
            {index:'sid', name:'sid', width:50, editable:true },
        ],
        width: 450,
        height:800,
 // cellEdit: true,    // true: クリックしたセルの編集
        cellsubmit: 'clientArray',
        rowNum: 80,
        sortname: 'rid',
        sortorder: "ASC",
     //   multiselect: true,
        onSelectRow: function(rid){
         if(rid && rid!=lastsel2){
         jQuery('#list').restoreRow(lastsel2);
         jQuery('#list').editRow(rid,true);
          lastsel2=rid;
          }
        },
        editurl: "RequestServ",
        caption: '職員一覧　編集'
    });

     var mydata =[
<% int cou=0; while(rs.next()){
if (cou!=0) {%>,<%}; %>
{
rid:"<%=rs.getString("id")%>",
name:"<%=rs.getString("name")%>",
user:"<%=rs.getString("user")%>",
sid:"<%=rs.getString("sid")%>"
}
<%cou=cou+1;}
stmt.close();
conn.close();
%>
];

      for(var i=0;i<mydata.length;i++)
    jQuery("#list").addRowData(mydata[i].rid,mydata[i]);



// add
	$("#btn4").click( function()
	{

	var options = {closeAfterAdd:true,reloadAfterSubmit:false};

	jQuery("#list").editGridRow('new',options);


	});

	// del
	$("#btn5").click( function()
	{

		// 選択されている行ID配列の取得
		//	editting_id = grid.getGridParam("selrow");
    var row = $("#list").getGridParam("selrow");
	jQuery("#list").restoreRow(row);
    //window.alert(row);
    var grid = jQuery("#list");
  var tmp =grid.getRowData(row);
 // window.alert(tmp.number);
  var options = { delData:{rid:tmp.rid,user:tmp.user}};

            jQuery("#list").delGridRow(row,options);


	});


});


</script>

<style>
	body { font-size: 90%; }

body {

text-align: center;
}
.jqgrid .ui-jqgrid{
    margin-left: auto;
    margin-right: auto;
}
</style>
</head>


<body>
<p><button id="btn4">追加</button>　　　<button id="btn5">削除</button>　　編集後はEnterキー　　　　　<font size=-1>adminのみ全員の回覧の削除ができます</font></p>
<div class='jqgrid'>
	<table id="list" class="scroll" cellpadding="0" cellspacing="0"　></table>
</div>
	<div id = "pager1"  class="scroll"></div>

	<br>





</BODY>


</HTML>

