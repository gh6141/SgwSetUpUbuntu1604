<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%


%>
<%@ include file="msyqlcon.jsp" %>
<%


Statement stmt = conn.createStatement();
//SQLコマンドを作成
String strSql = "SELECT * FROM groupname";

//問い合わせを実行してリザルトセットを取得
ResultSet rs = stmt.executeQuery(strSql);

%>



<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<TITLE>GroupEdit</TITLE>





<link rel="stylesheet" type="text/css" media="screen"
	href="css/jquery-ui-1.8.21.custom.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="css/ui.jqgrid.css" />

<!-- <script type="text/javascript" src="js/jquery-1.7.2.min.js"> </script> -->
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
        colNames:['ID', 'グループ名', 'メンバー'],
        // 編集可能にするセルを editable:true にします。
        colModel:[
            {index:'num', name:'num', width:50 },
            {index:'name', name:'name', width:200, editable:true },
            {index:'member', name:'member', width:250,  editable:true ,edittype:'select' ,
            editoptions:{value:"",multiple:true,dataUrl:'editoption'}
            },
        ],
        width:800,
        height:400,
 			// cellEdit: true,    // true: クリックしたセルの編集
        cellsubmit: 'remote',
        rowNum: 80,
        sortname: 'num',
        sortorder: 'ASC',
   		  //   multiselect: true,

        onSelectRow: function(num){
         if(num && num!=lastsel2){
         jQuery('#list').restoreRow(lastsel2);
         jQuery('#list').editRow(num,true);
          lastsel2=num;
          }
        },

        editurl: "RequestServ_group",
        caption: 'グループ名リストの編集'
    });

     var mydata =[
		<% int cou=0; while(rs.next()){
		if (cou!=0) {%>,<%}; %>
		{
		num:"<%=rs.getString("id")%>",
		name:"<%=rs.getString("name")%>",
		member:"<%=rs.getString("member")%>"
		}
		<%cou=cou+1;}
	stmt.close();
	conn.close();
	%>
	];
      for(var i=0;i<mydata.length;i++)
    	jQuery("#list").addRowData(mydata[i].num,mydata[i]);

// add*********************************
	$("#btn4").click( function()
	{
	var options = {closeAfterAdd:true,reloadAfterSubmit:false};
	jQuery("#list").editGridRow('new',options);


	});

// del*********************************
	$("#btn5").click( function()
	{
		// 選択されている行ID配列の取得
		//	editting_id = grid.getGridParam("selrow");
    var row = $("#list").getGridParam("selrow");
	jQuery("#list").restoreRow(row);
    //window.alert(row);
    var grid = jQuery("#list");
  	var tmp =grid.getRowData(row);
  	//window.alert(tmp.rid);
  	var options = { delData:{num:tmp.num}};
    jQuery("#list").delGridRow(row,options);
	});


		$("#btn6").click( function()
	{
	 $("#list").restoreRow($("#list").getGridParam("selrow"));　

	});





});



</script>

<style>
select {
height: 30em;
}
body { font-size: 90%; }
body {
text-align: center;

}
 .jqgrid .ui-jqgrid {
    margin-left: auto;
    margin-right: auto;
}
</style>

</head>


<body>
<p><a href="group.jsp">再表示</a>　　　　　　
<button id="btn4">
<span title="グループの追加方法：「追加」をクリック→グループ名入力、CTRLキーを押しながら、メンバー一人一人クリックしてください。→送信→「再表示」クリック">追加</span>
</button>　　　
<button id="btn5">
<span title="削除したい行を選択してから「削除」をクリック" >削除</span>
</button>　　　編集の際は最後にEnterキーで確定し、「再表示」で確認</p>
<div class='jqgrid'  title="メンバーの変更方法：追加したい行を選択すると、全職員が表示されるので、CTRLキーを押しながら、一人一人クリックしてください。最後に、Enterキーを押して確定したら、「再表示」で確認">
<table id="list" class="scroll" cellpadding="0" cellspacing="0"　></table>
</div>
<div id = "pager1"  class="scroll"></div>
<br>
</BODY>
</HTML>

