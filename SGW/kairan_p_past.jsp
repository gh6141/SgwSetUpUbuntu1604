<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>


<%


 String userN="";
 String shokuinid="";
   String user="";

 // 内容: クッキーを使用する(クッキーの取得)

 // クッキーの配列を取得
 Cookie cookies[] = request.getCookies();

 // 目的のクッキーを格納する変数
 Cookie idval = null;
  Cookie kensu = null;

 // それぞれのクッキーに対して名前を確認
 if(cookies != null) {
     for(int i = 0; i < cookies.length; i++) {
         // 名前が "idval" であるかチェック
         if(cookies[i].getName().equals("idval")) {
            // 該当するクッキーを取得
             idval = cookies[i];
         }
     }

     for(int i = 0; i < cookies.length; i++) {
         if(cookies[i].getName().equals("kensu")) {
            // 該当するクッキーを取得
             kensu = cookies[i];
         }
     }
 }

 // 表示する文字列
 String sidval,skensu;

 // 該当するクッキーがみつからなかった場合
 if(idval == null) {
     sidval = "";
     %><marquee scrolldelay="280" scrollamount="428" width="428">
     <font color="red">いったん終了し、もういちどログインしてください！(cookie保存の設定で)</font></marquee><%
     return;
 } else { // クッキーがみつかった場合は値を取得(URLデコードする)
    sidval = URLDecoder.decode(idval.getValue());
 }

if(kensu == null) {
     skensu = "20";
 } else { // クッキーがみつかった場合は値を取得(URLデコードする)
    skensu = URLDecoder.decode(kensu.getValue());
 }


//*****************************ページの読み込み

  String pg;
//pg="1";
pg= request.getParameter("page");
if (pg==null) pg="1";


String fmidoku=request.getParameter("fmidoku");

String kensakut=request.getParameter("kensaku");
String kensaku;
if (kensakut==null){kensaku="";}
else{
	   kensaku = new String(kensakut.getBytes("ISO8859_1"),"UTF-8");
	}

String vals[]=request.getParameterValues("user_srch");
String user_srch="";
if(vals!=null){
	fmidoku="kensaku";//error 防止 の意味も
	for (int i = 0 ; i < vals.length ; i++){
		user_srch=vals[i];
		}
}
String limmax=request.getParameter("limmax");

//*********************




%>
<%@ include file="msyqlcon.jsp" %>
<%

//ステートメントオブジェクトを取得
Statement stmt = conn.createStatement();
Statement stmt3 = conn.createStatement();
Statement stmt4 = conn.createStatement();


String strSql2 = "SELECT * FROM shokuin where user='"+sidval+"'";
ResultSet rs2 = stmt.executeQuery(strSql2);
Integer c=0;
while(rs2.next()&& c==0){
userN=rs2.getString("name");
shokuinid=rs2.getString("id");
user=rs2.getString("user");
c=c+1;
 }

rs2.close();

//***********reply kanren
String tflg,oflg,openflg,ratesakit,ratesaki,rkenmei,rmsg;
openflg="true";tflg="true";
openflg=request.getParameter("oflg");
//if (oflg.equals(tflg)) { openflg="true";}
ratesakit=userN+'　'+request.getParameter("ratesakit");
ratesaki=shokuinid+','+request.getParameter("ratesaki");
rkenmei=request.getParameter("rkenmei");
rmsg="";
//rmsg=request.getParameter("rmsg");
//if (rmsg.equals("NULL")) {rmsg="";}



      GregorianCalendar cal = new GregorianCalendar();
      SimpleDateFormat format = new SimpleDateFormat("yyyy年M月d日 E曜日");
      SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
      SimpleDateFormat format3 = new SimpleDateFormat("HHmm");
      String datestr = format.format(cal.getTime());
      String datestr_s = format2.format(cal.getTime());

      SimpleDateFormat format_yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");

  	Calendar calimg = Calendar.getInstance();


    %>


<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">

	<title>KairanPage</title>


<link rel="stylesheet" type="text/css" media="screen" href="css/iconize.css" />
<link rel="stylesheet" href="jQuery/themes/base/jquery.ui.all.css" />
<!--<script src="jQuery/jquery-1.7.2.js"></script>  -->
	<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript" src="jQuery/ui/i18n/jquery.ui.datepicker-ja.js"></script>
<script type="text/javascript" src="js/jquery.upload-1.0.2.min.js"></script>


	<style>

	.htmlbox p { margin:0; padding:0; }

	 a:link { color: #0000ff; }
a:visited { color: #000080; }
a:hover { color: #ff0000; }
a:active { color: #ff8000; }
	 .ui-widget a:link{ text-decoration: underline; }


		body { font-size: 90%; }
		button {height:32px;}
		button#clear {height:22px;text-align:top;font-size:60%;}
		button#clear2 {height:22px;text-align:top;font-size:60%;}
			button.min {height:20px;}
		label {text-align:left;display:block}
		 input { text-align:left}
		input.text,textarea { margin-bottom:10px; width:100%; padding: .3em; }
		fieldset { padding:0; border:0; margin-top:3px; }
		h1 { font-size: 1.2em; margin: .6em 0; }

		div#users-contain { width: 88%; margin: 1px 0; }
		div#users-contain table { margin: 0.3em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #ccc; padding: .1em 2px; text-align: left; }
		.nakawaku  {  border: 1px solid #ddd;  }
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }

body {
text-align: center;
}

div#users-contain  {
    margin: 0 auto;
}

<!--
div.ScrollBox {overflow:auto;width:230px;height:400px;border:1px gray solid;margin:15px;text-align:left;font-size:120%;}
-->
	</style>

	<STYLE type="text/css">
<!--
.scr {
  overflow: scroll;   /* スクロール表示 */
  overflow:auto;
}
-->
</STYLE>


</head>
<body>





<!--****************************************************-->

<br><br><br>
<%
String stitle,strSql,strSqlx;
String addsql="(((title like '%@下書き%' or title like '%＠下書き%') and FIND_IN_SET('"+shokuinid+"',hyoji)=1)  or (title not like '%@下書き%' and title not like '%＠下書き%') ) and ";
cal.add(Calendar.DATE,-14);
String datestr_s_2shu = format2.format(cal.getTime());

if (fmidoku.equals("izen")) {
	stitle="=　２週間以上前の回覧　一覧=";
	  strSql = "SELECT * FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji) and date < '"+datestr_s_2shu+ "' order by date desc limit "+skensu+" offset "+String.valueOf((Integer.parseInt(pg)-1)*Integer.parseInt(skensu));
  	  strSqlx = "SELECT count(*) as cnt FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji) and date < '"+datestr_s_2shu+ "'";
}
else if(fmidoku.equals("sosin")){
	stitle="=　送信済み回覧　一覧=";
	  strSql = "SELECT * FROM kairan where user='"+user+"' order by date desc" ;
	  strSqlx = "SELECT count(*) as cnt FROM kairan where user='"+user+"' " ;
}else if(fmidoku.equals("true")){
	stitle="=　未読回覧　一覧=";
	 //strSql = "SELECT * FROM kairan where FIND_IN_SET('"+shokuinid+"',hyoji) order by date desc";
	 strSql="SELECT * from kairan LEFT JOIN ( SELECT DISTINCT kairanlog.kairanid FROM kairanlog where "
	 + " shokuinid="+shokuinid+") LOG_TEMP ON LOG_TEMP.kairanid = kairan.id WHERE "+addsql+" LOG_TEMP.kairanid is null "
	 + " and  FIND_IN_SET('"+shokuinid+"',hyoji) ";
	  strSqlx = "SELECT count(*) as cnt FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji) ";

}
else if(!(user_srch).equals("ALL")||!(kensaku).equals("")){
	String stmp="";String key1="";
	String stmp2="";String key2="";
	String joken="";
	if (!(user_srch).equals("ALL")){
		stmp="ユーザー名："+user_srch;
		key1=" and user='"+user_srch+"' ";
	}
	if (!(kensaku).equals("")){
		stmp2="　　キーワード："+kensaku;
		key2=" and (title like '%"+kensaku+"%'  or msg like '%"+kensaku+"%') ";
	}

	joken=key1+key2;


	stitle="=　"+stmp+stmp2+"　　検索結果（最新"+limmax+"件まで）　=";
	  strSql = "SELECT * FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji) "+joken+" order by date desc limit "+limmax ;
	  strSqlx = "SELECT count(*) as cnt FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji) "+joken ;
}
else {
	stitle="=　　検索結果（最新"+limmax+"件まで）　=";
	  strSql = "SELECT * FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji)  order by date desc limit "+limmax ;
	  strSqlx = "SELECT count(*) as cnt FROM kairan where "+addsql+" FIND_IN_SET('"+shokuinid+"',hyoji) " ;

}


%>

<form method="post" name="form1" id="form1" ><font size=+2 color='#222222'><%=stitle %></font>　　　　　利用者:<font size=+1><%=userN %></font>　　<a href="kairan.jsp?rmsg=NULL">回覧板一覧</a>
　　<a href="kairan_p_past.jsp?fmidoku=izen">2週間以上前</a>
　<a href="kairan_p_past.jsp?fmidoku=true">未読</a>
　<a href="kairan_p_past.jsp?fmidoku=sosin">送信済み</a>　　

<%
if (fmidoku.equals("izen")) {
%>
　　　　　　　　　　　　　　　　　　　　<span title="件数が多いときは複数ページになります。表示したいページを選択してください。" >
ページ指定：　<select name="page" id="pages" style="font-size: 18px" ></select>ページ<input type="submit" name="btn" style="display:none;" class="pag"/></span>
<%
}
%>
</form>

<div id="users-contain" class="ui-widget" >	　　　　
	    <table id="users" class="ui-widget ui-widget-content" >
		<thead>
			<tr class="ui-widget-header ">
			    <th></th>
				<th>作成日/作成者</th>
				<th>件名</th>
				<th  title="回覧の新規作成ができます。必ず宛先を指定してください。"><button id="sinkitoroku">新規登録</button>　</th>
			</tr>
		</thead>
		<tbody>

			<%

   		ResultSet rs = stmt.executeQuery(strSql);

   		Statement stmtx=conn.createStatement();
   		ResultSet rsx = stmtx.executeQuery(strSqlx);
Integer coux=0;
   		//while(rsx.next()){
   			//coux=coux+1;
   		//}
 		if(rsx.next())
   			coux=Integer.parseInt(rsx.getString("cnt"));
   		stmtx.close();
   		String couxs;
   		couxs=String.valueOf(coux);


String kairanid,kidoku,hyoji,hyoj[],userid;
Integer cou=0;
String tcolor="";


			  while(rs.next()  ){
                kairanid=rs.getString("id");
                hyoji=rs.getString("hyoji");
                hyoj=hyoji.split(",");
                userid=hyoj[0];

                tcolor="black";
                if(rs.getString("title").indexOf("@下書き")!=-1||rs.getString("title").indexOf("＠下書き")!=-1){
                	  tcolor="red";
                  }



                Statement stmt5 = conn.createStatement();
                ResultSet rs5 = stmt5.executeQuery("select * from kairanlog where kairanid="+kairanid+" and shokuinid="+shokuinid);
 if(rs5.next()){
  kidoku=rs5.getString("kidoku");

 }else{
  kidoku="<font color='red'><b>未読</b></font>";
 }
                stmt5.close();

                if (fmidoku.equals("izen")||(fmidoku.equals("true")&&kidoku.equals("<font color='red'><b>未読</b></font>"))
                		||(fmidoku.equals("sosin")&&shokuinid.equals(userid))||fmidoku.equals("kensaku")){
                	%>


                	    <tr id="tr<%=kairanid%>">
              <td width=40px id="kd<%=kairanid%>" name="kd"><%=kidoku%></td>
              <td width='370px' id="nm<%=kairanid%>" name="date">[<%=rs.getString("date")%>]　<img src='<%=rs.getString("user")%>.jpg' class='igazo'>　<%=rs.getString("name")%>
               <input type='hidden' id="atesaki<%=kairanid%>" value="<%=rs.getString("hyoji")%>" name="atesaki"> </td>
              <td class="title_msg" id="tm<%=kairanid%>" name="title"  title="件名をクリックすると内容を閲覧できます"　><a href="kairan_msg.jsp?number=<%=kairanid%>&shokuinid=<%=shokuinid%>" ><%=rs.getString("title")%></a></td>
              <td width='140px'　id="bt<%=kairanid%>"　 title="<%=kairanid%>番のメッセージです。自分が作成した回覧には「編集」「削除」ボタンが表示されます">

               <% if ( shokuinid.equals(userid) || user.equals("admin")) {  %>
                <button class='henko' id="<%=kairanid%>"><font color="<%=tcolor%>">編集</font></button><button class='sakujo' id="del<%=kairanid%>">削除</button>
               <%}%>

              <textarea id="msg<%=kairanid%>" style="display:none" name="msg"><%=rs.getString("msg")%></textarea>
              <textarea id="tp<%=kairanid%>" style="display:none" ><%=rs.getString("tenpu").replace("<N>","")%></textarea>
              </td>
              </tr>


               <%
                }else{


                }

                cou=cou+1;
              }

			%>

<%

stmt.close();

%>

		</tbody>
	</table>
<br>
<%
if (fmidoku.equals("izen")) {
%>
	<form method="POST" action="kairan_kensu"　>
　　　<span title="１ページに表示される件数を制限できます"><font size=-1>１ページあたりの最大表示件数：　
<input type='text' size='2' id=kensu name='kensu' value='<%=skensu%>'>（件）に
<input type="submit" value="設定"　class="sett"　/></font></span>
　　　　　　　　　　		　　　　　　　　　　　　　<%=String.valueOf((Integer.parseInt(pg)-1)*Integer.parseInt(skensu)+1)%>～/全<%=couxs %>件</div>
	<div id="coux" style="display:none;"><%=couxs %></form>
<%
}
%>



</div>
</div><!-- End demo -->

<%@ include file="kairan_kohanbubun.jsp" %>


</body>
</html>
