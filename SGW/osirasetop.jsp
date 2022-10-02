
<%!
private String enc(String src){
	String regex = "%[0-9A-Z][0-9A-Z]%[0-9A-Z][0-9A-Z]";
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(src);

    String osname = System.getProperty("os.name");
    if(osname.indexOf("Windows")>=0){
      // Windowsであったときの処理
    	 return src;
    } else if(osname.indexOf("Linux")>=0){
      // Linuxであったときの処理
    	 if(m.find() )
    	     // System.out.println("正規表現とマッチ");
    	     return src;
    	    else
    	     // System.out.println("正規表現とマッチしない");
    	       // return URLEncoder.encode(src).replace("+", "%20").replace("%3B", ";")
    	       	//	 .replace("%2F", "/").replace("%3F", "?").replace("%3A", ":")
    	       	//	 .replace("%40", "@").replace("%3D", "=").replace("%2B", "+")
    	       	//	 .replace("%24", "$").replace("%31", "!").replace("%7E", "~")
    	       	//	 .replace("%2C", ",").replace("%28", "(").replace("%29", ")")
    	       	//	 .replace("%23", "#").replace("%27", "'");
    	      return URLEncoder.encode(src);
    } else {
      // その他の環境だったときの処理
    	 return src;
    }




}
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>
<%@page import="java.util.Random" %>

<%@ page session="true" %>
<%@page import="java.io.*"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.util.regex.Matcher" %>



<%


Random rnd =new Random();

String freset=request.getParameter("freset");
if (freset==null){
	freset="false";
}else{
	freset="true";
}
 String userN="";
  String shokuinid="";
  String user="";
  String userid="";
  String ransu="";

  request.setCharacterEncoding("UTF-8");



 // 内容: クッキーを使用する(クッキーの取得)

 // クッキーの配列を取得
 Cookie cookies[]=request.getCookies();
  int co1=0;
  while (cookies==null){
	  Thread.sleep(100);//クッキー取得失敗したら100msec時間置きながら繰り返す
	  cookies = request.getCookies();
	  co1++;
	  if (co1>5) break;
  }


 // 目的のクッキーを格納する変数
 Cookie idval = null;
 Cookie filtermoji = null;

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
         if(cookies[i].getName().equals("filtermoji")) {
            // 該当するクッキーを取得
             filtermoji = cookies[i];
         }
     }


 }

 // 表示する文字列
 String sidval;
 String sfiltermoji;

 // 該当するクッキーがみつからなかった場合
 if(idval == null) {
     sidval = "";
     %><marquee scrolldelay="200" scrollamount="80" width="900">
     <font color="red" size=+2>いったん、「終了」し「ログイン」してからご利用ください！(cookie設定要確認)</font></marquee>
     <jsp:forward page="Login" />
     <%

 } else { // クッキーがみつかった場合は値を取得(URLデコードする)
    sidval = URLDecoder.decode(idval.getValue());
    }


// filtermoji = URLDecoder.decode(filtermoji, "UTF-8");

 if(filtermoji == null) {
     sfiltermoji = "";
 } else { // クッキーがみつかった場合は値を取得(URLデコードする)
    sfiltermoji = URLDecoder.decode(filtermoji.getValue(),"UTF-8");
    //sfiltermoji = "テスト";

 }

//ここで　非表示用のキーワードを配列に入れておく
	String[] sfmoji = sfiltermoji.replaceAll("　"," ").split(" ",0);

	%>
	<%@ include file="msyqlcon.jsp" %>
	<%


Statement stmt = conn.createStatement();
//ステートメントオブジェクトを取得

ResultSet rs;
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
//*****************************現在の利用者カウント**************
%>
<%@ include file="login_ninzu.jsp" %>
<%


//乱数読み取り　キャッシュ画像リセット用****************************

String patht = getServletContext().getRealPath("/WEB-INF/opath.txt");
		String str2 = "";String stmp="";
		BufferedReader in2=new BufferedReader(new FileReader(patht));
		while((str2=in2.readLine())!=null) {
			//out.println(str2);
			stmp=stmp.trim()+str2.trim();
		}
		in2.close();
		String path =stmp.trim() ;

try{
	  BufferedReader bufFileData =
	          new BufferedReader(new FileReader(path+"mylogo/rnd.txt"));
	   ransu=bufFileData.readLine();
	  bufFileData.close();
}catch(Exception e){

}




//*********************************メール配信のアドレスは先にセット
String col1="haisin_ad";//転送希望

                     Statement stmt7 = conn.createStatement();
			  		 ResultSet rs7;
                     rs7 = stmt7.executeQuery("SELECT * FROM shokuin where "+col1+" like '%@%' " );
                     String stbc="";
                        if(rs7.next()) stbc=rs7.getString(col1);
			  			while(rs7.next()){
			  			 stbc=stbc+","+rs7.getString(col1);
			  			}
			  			rs7.close();
			  			stmt7.close();

 col1="renraku_ad";//タイトルのみ希望
                     Statement stmt8 = conn.createStatement();
			  		 ResultSet rs8;
                     rs8 = stmt8.executeQuery("SELECT * FROM shokuin where "+col1+" like '%@%' " );
                     String stbc2="";
                        if(rs8.next()) stbc2=rs8.getString(col1);
			  			while(rs8.next()){
			  			 stbc2=stbc2+","+rs8.getString(col1);
			  			}
			  			rs8.close();
			  			stmt8.close();



//******session shutoku*************************************


session.setAttribute("shokuinid",shokuinid);




      GregorianCalendar cal = new GregorianCalendar();
      SimpleDateFormat format = new SimpleDateFormat("yyyy年M月d日");
      SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
      SimpleDateFormat format3 = new SimpleDateFormat("HHmm");
      SimpleDateFormat format4 = new SimpleDateFormat("HH時mm分");
      SimpleDateFormat format_yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");

  	Calendar calimg = Calendar.getInstance();


      Calendar cal1 = Calendar.getInstance();  //(1)オブジェクトの生成
      StringBuffer dow = new StringBuffer();
      switch (cal1.get(Calendar.DAY_OF_WEEK)) {  //(8)現在の曜日を取得
        case Calendar.SUNDAY: dow.append("日曜日"); break;
        case Calendar.MONDAY: dow.append("月曜日"); break;
        case Calendar.TUESDAY: dow.append("火曜日"); break;
        case Calendar.WEDNESDAY: dow.append("水曜日"); break;
        case Calendar.THURSDAY: dow.append("木曜日"); break;
        case Calendar.FRIDAY: dow.append("金曜日"); break;
        case Calendar.SATURDAY: dow.append("土曜日"); break;
      }



      String datestr=format.format(cal.getTime())+" "+dow;
      String datestr_s = format2.format(cal.getTime());
      cal.add(Calendar.DATE,1);
      String datestr_s2 =format2.format(cal.getTime());
      cal.add(Calendar.DATE,8);
      String datestr_e = format2.format(cal.getTime());

 cal.add(Calendar.DATE,-9+180);
String osirase_mirai=format2.format(cal.getTime());
 cal.add(Calendar.DATE,-180*2);
String osirase_kako=format2.format(cal.getTime());

GregorianCalendar cal2 = new GregorianCalendar();
cal2.add(Calendar.DATE,-180);
String datestr_180 = format2.format(cal2.getTime());

//request.setCharacterEncoding("UTF-8");
  String kensaku1=request.getParameter("kensaku1");
  if (kensaku1==null){kensaku1=datestr_s;}
  String kensaku2=request.getParameter("kensaku2");
  if (kensaku2==null){kensaku2=datestr_s;}
  String kensaku3t=request.getParameter("kensaku3");
  String kensaku3;
   if (kensaku3t==null){kensaku3="%";}
   else{
	   kensaku3 = new String(kensaku3t.getBytes("ISO8859_1"),"UTF-8");
	   kensaku3="%"+kensaku3+"%";}



    %>








<!--右上表示＊＊＊＊＊＊＊＊＊＊＊＊＊＊tenki＊＊＊＊＊***********************************-->

　　<div id="users-contain" class="ui-widget tenki" >
	<font size=-1>
	<div id="tenki" style="display:inline;"></div>
<%String nowtime2=format4.format(cal.getTime()); %>　　　<%=nowtime2 %>　　　 <%=userN%>　　　<img src="gomi.gif" id="myicon">　<span title="直近５分間のログインユーザー(<%=strUnm %>)の人数">ログインユーザー：<%=strCnt%>人</span>

       <font size="3" color="green"><i id="aisatu">
		<%

		GregorianCalendar calendar = new GregorianCalendar();
		int nowHour = calendar.get(Calendar.HOUR_OF_DAY);
		String aisatu;
		if(nowHour >= 4 && nowHour < 9) {
		%>おはようございます<%
		} else if(nowHour >= 9 && nowHour < 12) {
 		%>　　　<%
 		} else if(nowHour >= 12 && nowHour < 13) {
 		 %>昼食はとられましたか<%
		} else if(nowHour >= 13 && nowHour < 17) {
  		%>　　　　<%
 		} else if(nowHour >= 17 && nowHour < 22) {
  		%>お疲れ様です<%
 		} else if(nowHour >= 22 || nowHour < 4) {
 		%>深夜です　疲れをためないようにお気をつけください<%
 		}
 		%></i></font>
 		　　　
 	</font>

 	<input type="submit" id=filter_bot value="非表示設定" title="ここで指定した文字が、「予定の項目名」や「お知らせの件名に含まれる文字」と一致すると非表示になります">
<form method="POST" action="filter_moji" id=filter_form >
						<span title="「予定の項目名」や「お知らせの件名に含まれる文字」を指定すると非表示になります。スペースを入れ複数指定可能。" >
						<font size=-1>
						<br>　　　　　　　　　「予定の項目名」や「お知らせの件名の一部」に<input type='text' size='14' id=filtermoji name='filtermoji' value='<%=sfiltermoji%>'>の文字があると非表示に
						<input type="submit" value="設定">
						</font></span>

					</form>

 	<!--***********************************　**************今日の予定-->
 <table id="sotowaku" >
  <tr>
   <td valign="top" id="users" >
     <table class="ui-widget ui-widget-content nakawaku" width=100% >
      <thead>
		<tr class="ui-widget-header">
		 <th id="sento" title="今日の予定以外に、回覧・メールの未読、授業変更の情報を表示します。予定は1分毎に最新データを読み込みます。今すぐ最新データを確認したいときは、「更新」をクリックしてください。"><input type="submit" id="pdf" value="今日の予定" title="今日の予定のプレビュー・印刷">　　　<%=datestr%>　　<a href="top.jsp?freset=true">更新</a>　</th>
		</tr>
	  </thead>
	  <tbody>
	    <tr>
         <td id="todaycheck">
		    <div id="yotei" style="font-size:150%;"></div>  　
         <!--日によって　おしらせないかチェック**********kairan**********************-->
  		  <%
				Statement stmt6 = conn.createStatement();
				Statement stmt5 = conn.createStatement();
				ResultSet rs5;
				ResultSet rs6;

 				cal.add(Calendar.DATE,-14);//１年でなく　２週間程度の未読チェックにとどめる
    		  	String datestr_s_1nen = format2.format(cal.getTime());//半年前まで
				//rs6 = stmt6.executeQuery("SELECT * FROM kairan where date >= '"+datestr_s_1nen+ "' and  FIND_IN_SET('"+shokuinid+"',hyoji) ");
    		  	String addsql="(((title like '%@下書き%' or title like '%＠下書き%') and FIND_IN_SET('"+shokuinid+"',hyoji)=1)  or (title not like '%@下書き%' and title not like '%＠下書き%') ) and ";

				rs6=stmt6.executeQuery("SELECT count(*) as cnt from kairan LEFT JOIN ( SELECT DISTINCT kairanlog.kairanid FROM kairanlog where shokuinid="+shokuinid+") LOG_TEMP ON LOG_TEMP.kairanid = kairan.id WHERE "+addsql+" LOG_TEMP.kairanid is null and  FIND_IN_SET('"+shokuinid+"',hyoji) ");
				//rs6=stmt6.executeQuery("SELECT * from kairan LEFT JOIN ( SELECT DISTINCT kairanlog.kairanid FROM kairanlog where date >= '"+datestr_s_1nen+ "' and shokuinid="+shokuinid+") LOG_TEMP ON LOG_TEMP.kairanid = kairan.id WHERE LOG_TEMP.kairanid is null and date >= '"+datestr_s_1nen+ "' and  FIND_IN_SET('"+shokuinid+"',hyoji) ");

				String kairanid,kidoku,ms2;
				ms2="";
 				Integer cou=0;
 				if(rs6.next())
 				cou=Integer.parseInt(rs6.getString("cnt"));


 				if (cou>0 && cou<=20) { %><div id="chui" ><b><font color='red'>>>><a href='kairan.jsp?rmsg=NULL'><font color='red' >未読回覧は<%=cou%>件です。</font></b></a><br> </div><% }
 				else if (cou>20) { %><div id="chui" ><b><font color='red'>>>><a href='kairan.jsp?rmsg=NULL'><font color='red' size='<%=cou/4%>'>未読回覧は<%=cou%>件です。</font></b></a><br> </div><% }%>


 	    	<!--メールないかチェック**ここに追加******************************-->

        </td>
        </tr>
        <tr id="henkocheckr"><td id="henkocheck"></td></tr>



        </tbody>
       </table>

     <!--***************************おしらせ**************************************************************  -->
　　　　　　
		<table id="users" class="ui-widget ui-widget-content nakawaku" >
			<thead >
				<tr class="ui-widget-header ">

					<th title="お知らせの新規作成ができます。必要に応じて掲載期間の変更もできます。"><button id="sinkitoroku" >新規</button> </th>
					<th><span id=kensaku_bot_osirase>
						<b>　　お知らせ　　</b>
                    　　　　<input type="submit" id=kensaku_bot value="検索.." title="指定期間内で特定の文字を含む投稿を検索できます"></span>

					 <form method="POST" action="top.jsp" id=kensaku_form>
					   <span title="期間とキーワードを指定して「検索」できます。キーワードが空欄だと期間内のすべてを表示します。">
					   <br>　　　　　　　　　<font size=-1><input type='text' id=kensaku1 name='kensaku1' size="9" value="">~
					   <input type='text' id=kensaku2 name='kensaku2' size="9" value="">の期間を
					   <input type='text' id=kensaku3 name='kensaku3' size="7" value="">で
	                   <input type="submit" value="検索"></font></span>
	                 </form>

					</th>
				</tr>
			</thead>
			<tbody>

			<%

			String joken= "";String jk="";

			if(sfmoji.length>0 && sfmoji[0]!=null && sfmoji[0].length()>0){
				for (int i=0; i<sfmoji.length; i++) {
					  if(i>0){
						  jk=jk+"and title not like '%"+sfmoji[i]+"%'";
					  }else{
						  jk=jk+"title not like '%"+sfmoji[i]+"%'";
					  }

				    }
				joken="and "+jk;
			}else{
				joken="";
			}



			String strSql;
			//タイトルの先頭に「下書き」があると、投稿者以外は表示しない
			String Swhere=" where (((title like '%@下書き%' or title like '%＠下書き%') and userid='"+shokuinid+"')  or (title not like '%@下書き%' and title not like '%＠下書き%') ) and kikan_s <= '"+kensaku2+"' and kikan_e >= '"+kensaku1+"' "
          		  +"and (title like '"+kensaku3+"' or msg like '"+kensaku3+"') "+joken;

            Collator cmp2 = Collator.getInstance();

			//kensaku2が今日の日付と違う（過去データ検索）ときは、past_keijibanも検索する。
			//通常のときは、高速化のため、過去データは検索しない。


			if(cmp2.compare(kensaku1,  datestr_s)<0 ){//過去検索は、過去データpast_keijibanも一緒に検索
				 strSql = "(SELECT * FROM keijiban "+Swhere+" ) UNION ( SELECT * FROM past_keijiban "+Swhere
	            		  +" ) order by kikan_s desc";

			}else{//今日以降の検索はkeijibanのみで高速検索
				 strSql = "SELECT * FROM keijiban "+Swhere+" order by id desc";

				//strSql = "SELECT * FROM keijiban  order by id desc";
			}

			// strSql = "SELECT * FROM keijiban where kikan_s <= '"+kensaku2+"' and kikan_e >= '"+kensaku1+"' "
           	//	  +"and (title like '"+kensaku3+"' or msg like '"+kensaku3+"') "
           	//	  +joken
           	//	  +" order by id desc";


            rs = stmt.executeQuery(strSql);

            	String scolor="";
String tcolor="";
               	String bold1;
               	String bold2;
			  String tmpid="";
			  while(rs.next()){ tmpid=rs.getString("id");userid=rs.getString("userid");tcolor="black"; bold1="<b>"; bold2="</b>";
			     if (cmp2.compare(rs.getString("kikan_s"),  datestr_s)<=0 && cmp2.compare(rs.getString("kikan_e"), datestr_s)>=0) {
			      scolor="black";
			      if(rs.getString("title").indexOf("@下書き")!=-1||rs.getString("title").indexOf("＠下書き")!=-1){
			    	  tcolor="red";
			    	  bold1="";
			    	  bold2="";
			      }

			    }else if(cmp2.compare(rs.getString("kikan_s"),  datestr_s)>0) {
			      scolor="blue";
			    }else {
			      scolor="orange";
			    }


				%>
		      <tr>
              <td width='200px' valign="top" id="nm<%=tmpid%>" class="nakawaku"　>
              <img src="<%=rs.getString("user")%>.jpg?<%=ransu %>" class="igazo" >



              <%=rs.getString("name")%><br>
              <font size=-1 color=<%=scolor%>>[<%=rs.getString("kikan_s")%>~<%=rs.getString("kikan_e")%>]</font>
               <% if ( shokuinid.equals(userid)|| user.equals("admin") ) {  %>
               <span title="<%=tmpid%>番目のメッセージです。自分が投稿したお知らせのところのみ、「編集」「削除」ボタンが表示されます。添付ファイルもつけられます。"><button class='henko' id="<%=tmpid%>"><font color="<%=tcolor%>">編集</font></button>  <button class='sakujo' id="del<%=tmpid%>">削除</button></span>

               <%}%>
               </td>
              <td class="nakawaku" style="word-break: break-all;"><div class="title_msg htmlbox" id="tm<%=tmpid%>" ><%=bold1 %>[<%=rs.getString("title")%>]<%=bold2 %><BR><%=rs.getString("msg").replace("\n","<br>")%></div>

<%
String stenpu=rs.getString("tenpu").replace("\n","<br>").replace("<N>","");

Pattern p = Pattern.compile("<a href=\"FileDownloadServlet.filename=(.*?)\">(.*?)</a>",Pattern.DOTALL);
Matcher m = p.matcher(stenpu);
String result="";
while (m.find()){
	String fname=m.group(1);
	String text=m.group(2);
 result=result+"<a href=\"FileDownloadServlet?filename="+enc(fname)+"\">"+text+"</a><br>";
}

%>

              <div id="tp<%=tmpid%>"><%=result%></div></td>
              </tr>
            <%
              }
		stmt.close();
		conn.close();
		%>
		</tbody>
	　　</table>

   </td>
<!--*****************************右側の　明日以降の予定***************************************-->
   <td  valign="top" width="25%"><table id="users" class="ui-widget ui-widget-content ">

     <table class="ui-widget ui-widget-content nakawaku">
       <thead>
		<tr class="ui-widget-header ">
		 <th id="sento">明日以降　<font size=-2><input type=submit id='pdf1' value=明日 title='プレビュー・印刷'><input type=submit id='pdf2' value=明後日 title='プレビュー・印刷'><input type=submit id='pdf3' value=３日後 title='プレビュー・印刷'></font></th>
		</tr>
	   </thead>
	   <tbody>
        <tr><td id="yotei2" ></td></tr>
       </tbody>
    </table>



   </td></tr>
 </table></td>
  　<div align="Right"><font size=-1 >SGW　Ver1.70906TMPG</font></div>



</div><!-- End demo -->
<input type='hidden' id='opath'>
<input type='hidden' id='opath2'>





<div id="dialog-form" title="お知らせの作成" ondragover="onDragOver(event)" ondrop="onDrop(event)" >

<table><tr>
<td>
<form id="myForm" name="myForm" action="UploadImage" method="post" enctype="multipart/form-data">
<input type="file" id="imgfileup1" name="filename" size="10" class="imgfileup" title="Drag&Dropも可" >
<span title="JPEG画像ファイルを添付する前にチェックすると画像も表示可能。"><input type="checkbox" id="img_gazo"  >　画像挿入</span><span  id="imgurls">　縦<input type="text" name="height" size=3 value="120" id="height1">に縮小</span>

<input type="hidden" value="" id="flg" name="flg" class="flg">
<input type="hidden" value="imgsave" id="sosa" name="sosa">
<input type="hidden" value="NULL" id="userID2" name="userID2" class="jpgname">
</form>
</td>
<td>
　<button  id="clear" title="添付ファイルを変更したいときは、すべて削除してから再度、操作してください。削除したときは最後に必ず保存をクリックしてください。">添付削除</button>
</td>
</tr></table>


	<form>
	<fieldset>

		<label for="tenpu" class="wait">添付ファイル</label>
		<table width=100% height=20px class="text ui-widget-content ui-corner-all" >
		<tr><td name="tenpu"  id="tenput" align=left></td>
		<td><textarea name="tenpu"  rows=1 id="tenpu" value="" class="text" style="display:none"></textarea></td></tr></table>

<br>

<div align="left">
掲載開始日
		<input type="text" name="kikan_s" id="kikan_s" value=<%=datestr_s%> class=" ui-widget-content ui-corner-all" />
　　　掲載終了日
		<input type="text" name="kikan_e" id="kikan_e" value=<%=datestr_e%> class=" ui-widget-content ui-corner-all" />
</div>
<br>
<div align="left" title="「下書き」にチェックを入れる（@下書きを挿入する）と、作成者以外には表示されません">
		件名<font size=-1>　　<input type="checkbox" id="sitagaki1" name="sitagaki1" value="sitagaki">下書き</font>
		</div>
		<input type="text" name="kenmei" id="kenmei" value="" class="text ui-widget-content ui-corner-all" />

<%@ include file="shushoku1.jsp" %>
    <p>
      <div id="editArea" style="height:120px;border-style:inset;text-align:left"  class="htmlbox scr ui-widget-content ui-corner-all"  contentEditable="true">
          </div>
    </p>

		<textarea name="naiyo"  rows=6 id="naiyo" value="" class="text ui-widget-content ui-corner-all" style="display:none;"></textarea>


		<label for="name">作成者</label>
		<input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
	</fieldset>
	<!--  <span title="この機能はインターネットエクスプローラーでのみ使用可能です"></span>共有へのリンク作成<input type="file" name="link" id="link" class="link"></span>
	-->

	</form>

<div id="imgtmp"></div>
	<input type="file" name="file" id="file1" class="fileup" style="display:none;">
</div>


<div id="dialog-form_henko" title="お知らせの変更" ondragover="onDragOver(event)" ondrop="onDrop(event)" >
<table><tr>
<td>
<form id="myForm2" name="myForm2" action="UploadImage" method="post" enctype="multipart/form-data">
<input type="file" id="imgfileup2" name="filename" size="10" class="imgfileup" title="Drag&Dropも可">
<span title="JPEG画像ファイルを添付する前にチェックすると画像も表示可能。">
<input type="checkbox" id="img_gazo2"  >画像挿入
</span>
<span  id="imgurls2">　縦<input type="text" name="height" size=3 value="120" id="height2">pxに縮小</span>
<input type="hidden" value="" id="flg2" name="flg" class="flg">
<input type="hidden" value="imgsave" id="sosa2" name="sosa">
<input type="hidden" value="NULL" id="userID22" name="userID2" class="jpgname">
</form>
</td>
<td>
　<button id="clear2" title="添付ファイルを変更したいときは、すべて削除してから再度、操作してください。削除したときは最後に必ず変更の保存をクリックしてください。">添付削除</button>

</td>
</tr>
</table>



	<form>
	<fieldset>
	<label for="tenpu" class="wait">添付ファイル</label>
		<table width=100% height=20px class="text ui-widget-content ui-corner-all" ><tr><td name="tenpu"  id="htenput" align=left></td></tr></table>
		<textarea name="tenpu"  rows=1 id="htenpu" value="" class="text ui-widget-content ui-corner-all" style="display:none"></textarea>

		<input type="hidden" name="number" id="number" class="text ui-widget-content ui-corner-all" />
		<br>
<div align="left">
掲載開始日<input type="text" name="kikan_s" id="hkikan_s" value="" class=" ui-widget-content ui-corner-all" />
　　　掲載終了日<input type="text" name="kikan_e" id="hkikan_e" value="" class=" ui-widget-content ui-corner-all" />
</div>
<br>
<div align="left" title="「下書き」にチェックを入れる（@下書きを挿入する）と、作成者以外には表示されません">
		件名<font size=-1>　　<input type="checkbox" id="sitagaki2" name="sitagaki2" value="sitagaki">下書き</font>
		</div>
		<input type="text" name="kenmei" id="hkenmei" value="" class="text ui-widget-content ui-corner-all" />
<%@ include file="shushoku2.jsp" %>
    <p>

        <div id="editArea2" style="height:120px;border-style:inset;text-align:left"  class="htmlbox scr ui-widget-content ui-corner-all"  contentEditable="true">

        </div>

    </p>
	<textarea name="naiyo"  rows=6 id="hnaiyo" value="" class="text ui-widget-content ui-corner-all" style="display:none;"></textarea>


			<label for="name">作成者</label>
		<input type="text" name="name" id="hname" class="text ui-widget-content ui-corner-all" />
	</fieldset>


	</form>


<div id="imgtmp2"></div>
<input type="file" name="file" id="file2" class="fileup" style="display:none;">
</div>


<script>

//focus はずれると　全角を半角に　　DOMの読み込みを完了したときの処理　$(function)
$(function(){
$("#kikan_s,#kikan_e,#hkikan_s,#hkikan_e").change(function(){
    var str = $(this).val();
    str = str.replace( /[Ａ-Ｚａ-ｚ０-９－！”＃＄％＆’（）＝＜＞，．？＿［］｛｝＠＾～￥／]/g, function(s) {
        return String.fromCharCode(s.charCodeAt(0) - 65248);
    });
    $(this).val(str);
}).change();
});

//rich text
   //innerText をサポートしない Web ブラウザと共通で使用するための
 //setText 関数を定義
 function setAlter_innerText(element) {
     if (element.innerText) {
         element.setText = function (text) { element.innerText = text; }
     } else {
         element.setText = function (text) { element.textContent = text; }
     }
     return element;
 }

 //getElementById の短縮
 var $id = function (id) { return document.getElementById(id); };

 //コンテンツのロードが完了したら winload start
 window.onload = function () {



		editArea = $id("editArea");
         ritchTextHtmlArea = $id("naiyo");

        //innerText を設定するためのメソッドを追加
        setAlter_innerText(editArea);
        setAlter_innerText(ritchTextHtmlArea);


        editArea2 = $id("editArea2");
        ritchTextHtmlArea2 = $id("hnaiyo");

       //innerText を設定するためのメソッドを追加
       setAlter_innerText(editArea2);
       setAlter_innerText(ritchTextHtmlArea2);


//*************************************************************************************
        //フォントサイズを指定するドロップダウンリストのイベントハンドラ
        $id("fontSizeSelecter")
            .addEventListener("change", function () {
                if (checkSelectionText()) {
                    document.execCommand('fontSize', false, this.value);
                }

            });


        //フォントカラーを指定するドロップダウンリストのイベントハンドラ
        $id("fontColorSelecter").addEventListener("change", function () {
            if (checkSelectionText()) {
                document.execCommand('ForeColor', false, this.value);
            }
        });

        //背景色を指定するドロップダウンリストのイベントハンドラ
        $id("bgColorSelecter").addEventListener("change", function () {
            if (checkSelectionText()) {
                document.execCommand('backColor', false, this.value);
            }
        });


        //[太字] ボタン
        $id("boldButton").addEventListener("click", function () {
            if (checkSelectionText()) {
                document.execCommand("bold", false);
            }
        });

        //[下線] ボタン
        $id("underLineButton").addEventListener("click", function () {
            if (checkSelectionText()) {
                document.execCommand("underline", false);
            }
        });

        //[イタリック] ボタン
        $id("ialicBotton").addEventListener("click", function () {
            if (checkSelectionText()) {
                document.execCommand("italic", false);
            }
        });
//*************************************
//フォントサイズを指定するドロップダウンリストのイベントハンドラ
        $id("fontSizeSelecter2")
            .addEventListener("change", function () {
                if (checkSelectionText()) {
                    document.execCommand('fontSize', false, this.value);
                }

            });


        //フォントカラーを指定するドロップダウンリストのイベントハンドラ
        $id("fontColorSelecter2").addEventListener("change", function () {
            if (checkSelectionText()) {
                document.execCommand('ForeColor', false, this.value);
            }
        });

        //背景色を指定するドロップダウンリストのイベントハンドラ
        $id("bgColorSelecter2").addEventListener("change", function () {
            if (checkSelectionText()) {
                document.execCommand('backColor', false, this.value);
            }
        });


        //[太字] ボタン
        $id("boldButton2").addEventListener("click", function () {
            if (checkSelectionText()) {
                document.execCommand("bold", false);
            }
        });

        //[下線] ボタン
        $id("underLineButton2").addEventListener("click", function () {
            if (checkSelectionText()) {
                document.execCommand("underline", false);
            }
        });

        //[イタリック] ボタン
        $id("ialicBotton2").addEventListener("click", function () {
            if (checkSelectionText()) {
                document.execCommand("italic", false);
            }
        });

//************************************************************************
        //[生成された HTMLの取得] ボタン
        $id("getHtmlButton").addEventListener("click", function () {
            ritchTextHtmlArea.setText(editArea.innerHTML);
            $('#naiyo').show();
            $('#editArea').hide();
        });

        $id("getHtmlButton2").addEventListener("click", function () {
            ritchTextHtmlArea2.setText(editArea2.innerHTML);
            $('#hnaiyo').show();
            $('#editArea2').hide();
        });


        //文字が選択されているか判断
        function checkSelectionText() {
             selectionFlag = (document.getSelection().toString().length > 0);
            if (!selectionFlag) {
                alert("文字が選択されていません。\n文字を選択してください。");
            }
            return selectionFlag;
        }

 }
//********************winload start おわり

var tid=null;
tid=setTimeout("location.reload()",1000*60*60);//60分おきリロード　ただし入力画面ではリロードしない

function tstop(timeout_id){
if(timeout_id !== null){

	// setTimeout() メソッドの動作をキャンセルする
	clearTimeout(timeout_id);

	timeout_id = null;
}
}

function tstart(tid){
tid=null;
tid=setTimeout("location.reload()",1000*60*60);
}
//*******************************************一ケタ数字を０つけて２けたに***********

toDoubleDigits = function(num) {
num += "";
if (num.length === 1) {
num = "0" + num;
}
return num;
};


//*********Ajax系メソッドはキャッシュを無視して毎回必ずサーバにデータを取得しに行ku***************
$.ajaxSetup({ cache: false });



//**********************$(function start************************
$( function() {
setTimeout(function(){
$("#aisatu").fadeTo(1000,0);
},5000)


   $("#kensaku1").val("<%=datestr_180%>");
   $("#kensaku2").val("<%=kensaku2%>");
   $("#kensaku3").val("<%=kensaku3%>".replace("%","").replace("%",""));


   $('.flg').val('oimg');//お知らせoimgか回覧kimgか　imgsaveのためのフラグ（画像挿入 UploadImage関連）




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    　$.post(
							'sette_p',
							{
                              'flg':'yomi'
                            },
                            function(data){
                             var st=data;
                             var  dt=st.split('\t');
                               $('#opath').val(dt[0]);
                                $('#opath2').val(dt[1]);
                                $('#myicon').attr('src',dt[1]+'mylogo/<%=sidval%>.jpg?<%=ransu%>');
                                $('#myicon').error(function() {
                            		//ファイルが存在しない画像はimgタグ自体を削除 or default.jpg
                                    $('#myicon').remove();
                                	// $(this).attr('src', 'default.jpg');
                                });


        });

   $.get('poi',	{'freset':'<%=freset%>','month':'00','hiduke':'<%=datestr_s%>', 'hiduke2':'<%=datestr_e%>','sfiltermoji':'<%=sfiltermoji%>' },
             function(data){
                              st=data;
                              var d2t=st.split('\t');
                               $(d2t[0].replace('<br><br>','')).appendTo('#yotei');
                             $(d2t[1]).appendTo('#yotei2');
        });

 //mailcheck**********************************************************


   $.get('maillist',	{'shokuinid':'<%=shokuinid%>' },
             function(data){
             　　　　　　　　　　　　　　　　　　
                     if(data.replace(/\s+$/, "")=="設定なし" || data.replace(/\s+$/, "")=="メールなし" || data==null) {
                          //  $("<div style='font-size:130%;'><b><font color='red'>>>></font>"+data+"</b> </div>").appendTo("#todaycheck");
                     }else
                     {    //mail があった場合　　通知だけ表示　　リンククリックすると　タイトル表示
                       ssst=data.split("\t");

                             $("<div style='font-size:120%;'><b><font color='red'>>>>"+ssst[0]+"</font></b> </div>").appendTo("#todaycheck");
                             $("<p style='font-size:90%;display:none;' class='tmail'>"+ssst[1]+"</font></b> </p>").appendTo("#todaycheck");
                      }
        });

      $('#todaycheck').hover(function() {
       $('.tmail').attr('style','display:inline');
     },
      function() {
       $('.tmail').attr('style','display:none');
       }
     );

//**************jugyo henko check*******************************
    $.get('henkolist',	{'hiduke':'<%=datestr_s%>','hiduke2':'<%=datestr_s2%>' },
             function(data){
             　　　　　　　　　　　　　　　　　　
                     if(data.replace(/\s+$/, "")=="設定なし" || data.replace(/\s+$/, "")=="変更なし" || data==null) {
                          //  $("<div style='font-size:130%;'><b><font color='red'>>>></font>"+data+"</b> </div>").appendTo("#todaycheck");
                          $("#henkocheckr").remove();

                     }else
                     {    //mail があった場合　　通知だけ表示　　リンククリックすると　タイトル表示
                       ssst=data.split("\t");

                             $("<div style='font-size:120%;'><b><font color='green'>>>>"+ssst[0]+"</font></b> </div>").appendTo("#henkocheck");
                             $("<p style='font-size:90%;display:none;' class='henko'>"+ssst[1]+"</font></b> </p>").appendTo("#henkocheck");
                      }
                     $('#kyo').attr('style','display:none');
                     $('#asu').attr('style','display:none');
        });

    $('#henkocheck').click(function() {
    	   $('#kyo').attr('style','display:inline-table');
          $('#asu').attr('style','display:inline-table');

    });

      $('#henkocheck').hover(function() {
     //  $('#kyo').attr('style','display:inline-table');
     //  $('#asu').attr('style','display:inline-table');
      $('#henkodisp').attr('style','color:red')
     },
      function() {
    	 $('#henkodisp').attr('style','color:green')
       $('#kyo').attr('style','display:none');
       $('#asu').attr('style','display:none');
       }
     );

      $('#filter_form').css("display","none");
      $('#filter_bot').click(function() {
    	  $('#filter_bot').css("display","none");
           $('#filter_form').toggle();
         });

      $('#kensaku_form').css("display","none");
      $('#kensaku_bot').click(function() {
    	  $('#kensaku_bot_osirase').css("display","none");
           $('#kensaku_form').toggle();
         });



      $('#linkurls').css("display","none");
      $('#link_gazo').click(function() {
    	  $('#link_gazo').css("display","none");
           $('#linkurls').toggle();
         });
      $('#get').click(function() {
    	  $('#link_gazo').css("display","block");
           $('#linkurls').toggle();
         });

      $('#linkurls2').css("display","none");
      $('#link_gazo2').click(function() {
    	  $('#link_gazo2').css("display","none");
           $('#linkurls2').toggle();
         });
      $('#get2').click(function() {
    	  $('#link_gazo2').css("display","block");
           $('#linkurls2').toggle();
         });



      $('#submitBtn').click(function() {
    	 // $('#img_gazo').css("display","block");
         //  $('#imgurls').toggle();
         });



      $('#submitBtn2').click(function() {
    	 // $('#img_gazo2').css("display","block");
          // $('#imgurls2').toggle();
         });


      $('#imgurls').css("visibility","hidden");
      $('#img_gazo').change(function() {
    	   if($("#img_gazo").prop('checked')){
    		   $('#imgurls').css("visibility","visible");
    	   }else{
    		   $('#imgurls').css("visibility","hidden");
    	   }

         });

      $('#imgurls2').css("visibility","hidden");
      $('#img_gazo2').change(function() {
    	   if($("#img_gazo2").prop('checked')){
    		   $('#imgurls2').css("visibility","visible");
    	   }else{
    		   $('#imgurls2').css("visibility","hidden");
    	   }

         });



//＊＊＊＊＊＊＊＊＊＊＊＊＊＊******************************************************************
$('#pdf').click(function() {
 var data = {'naiyo': $('#yotei').html(), 'nichime':'<%=datestr%>','fontsize':'25'};
 postForm('pdf.jsp', data);
         });

$('#pdf1').click(function() {
 var data = {'naiyo': $('#yotei2').html(), 'nichime':'1','fontsize':'25'};
 postForm('pdf.jsp', data);
         });
$('#pdf2').click(function() {
 var data = {'naiyo': $('#yotei2').html(), 'nichime':'2','fontsize':'25'};
 postForm('pdf.jsp', data);
         });
$('#pdf3').click(function() {
 var data = {'naiyo': $('#yotei2').html(), 'nichime':'3','fontsize':'25'};
 postForm('pdf.jsp', data);
         });

var postForm = function(url, data) {
 var $form = $('<form/>', {'action': url, 'method': 'post'});
 for(var key in data) {
         $form.append($('<input/>', {'type': 'hidden', 'name': key, 'value': data[key]}));
 }
 $form.appendTo(document.body);
 $form.submit();
};

//*******************************************************************************************************


	// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
	$( "#dialog:ui-dialog" ).dialog( "destroy" );

	var name = $( "#name" ),
		kikan_s = $( "#kikan_s" ),
		kikan_e = $( "#kikan_e" ),
		kenmei = $( "#kenmei" ),
		naiyo = $("#naiyo"),
		tenpu = $("#tenpu"),
		allFields = $( [] ).add( name ).add( kikan_s ).add( kikan_e ).add( kenmei ).add(naiyo).add(tenpu),
		tips = $( ".validateTips" );

	function updateTips( t ) {
		tips
			.text( t )
			.addClass( "ui-state-highlight" );
		setTimeout(function() {
			tips.removeClass( "ui-state-highlight", 1500 );
		}, 500 );
	}

	function checkLength( o, n, min, max ) {
		if ( o.val().length > max || o.val().length < min ) {
			o.addClass( "ui-state-error" );
			updateTips(  n + "の文字数は " +
				min + " ～ " + max + "の範囲にしてください" );
			return false;
		} else {
			return true;
		}
	}

	function checkRegexp( o, regexp, n ) {
		if ( !( regexp.test( o.val() ) ) ) {
			o.addClass( "ui-state-error" );
			updateTips( n );
			return false;
		} else {
			return true;
		}
	}


	function mailhaisin(ssbcc,tenpuval,sname,skenmei,snaiyo,flg){
	  //宛先準備
				//var ssbcc='gh6141@gmail.com,hgoto1@mail.goo.ne.jp';

				// var ssbcc='<%=stbc%>';

				 var sbcc=ssbcc.split(',');
				 for (i=0;i<sbcc.length;i++){
				 sbcc[i]=sbcc[i].replace(/^\s+/, "");//trim
				 }

				//添付ファイル配列準備
				 var sstnp=tenpuval.replace('<N>','').replace(/<br>/g,',').replace(/<.+?>/g,'').replace(/^,/,'');// *,*,*
				 var stnp=sstnp.split(',')
				 if(tenpuval!="<N>"){
				  for (i=0;i<stnp.length;i++){
				  stnp[i]=$('#opath').val()+stnp[i].replace(/^[\s　]+|[\s　]+$/g, "");//trim
				  }
				 }

					 $.post(
							'haisin_mail',
							{
							  'name': sname,
                             'subject':flg+skenmei+"("+sname+")",
                              'honbun': snaiyo,
                              'tenpu[]':stnp,//hairetu
                              'bcc[]':sbcc//hairetu
                            },
                            function(data){
                              //alert(data);

                             }
					 );




	}




	function henkan(moji){
						moji = moji.replace(/\r\n/g, "<br>");
						moji = moji.replace(/(\n|\r)/g, "<br>");
						return moji;

	}

	$( "#dialog-form" ).dialog({
		autoOpen: false,
		height: 560,
		width: 700,
		modal: true,
		buttons: {
			"保存": function() {



				var bValid = true;
				allFields.removeClass( "ui-state-error" );
				bValid = bValid && checkLength( name, "作成者", 0, 20 );
				bValid = bValid && checkLength( kikan_s, "掲載開始期間", 8, 10 );
				bValid = bValid && checkLength( kikan_e, "掲載終了期間", 8, 10);
				bValid = bValid && checkLength( kenmei, "件名", 1, 50 );
				//bValid = bValid && checkLength( naiyo, "内容", 1, 1500 );
				//bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
				// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
				//bValid = bValid && checkRegexp( kikan, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );
				//bValid = bValid && checkRegexp( kenmei, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
                bValid = bValid && checkRegexp( kikan_s, /^(?:19|20)\d\d\/(\d{1,2})\/(\d{1,2})$/, "YYYY/MM/DDにしてください" );
                bValid = bValid && checkRegexp( kikan_e, /^(?:19|20)\d\d\/(\d{1,2})\/(\d{1,2})$/, "YYYY/MM/DDにしてください" );

              if(tenpu.val().length>0){
              txtVal= henkan(naiyo.val()+tenpu.val());
            	//  txtVal= naiyo.val()+tenpu.val();
              }else{
              txtVal= henkan(naiyo.val());
             //txtVal= naiyo.val();
              tenpu.val('<N>');
              }
				if ( bValid ) {


					//ここでまとめて　複数IMG挿入
					$("#editArea").html($("#editArea").html()+"\n"+$("#imgtmp").html());
		try{
		ritchTextHtmlArea.setText(editArea.innerHTML);
		}

		catch(e){
		alert("エラーです。互換表示を解除してますか？解除後、「TOP」をクリックして、再度お試しください。");
		}




					//月日　1/1を01/01に
					var ki_s = kikan_s.val();
					var ki_e = kikan_e.val();
					//alert(ki_s);
					var st_ki_s=ki_s.split("/");
					var st_ki_e=ki_e.split("/");
					var ki_s2=st_ki_s[0].trim()+"/"+toDoubleDigits(st_ki_s[1]).trim()+"/"+toDoubleDigits(st_ki_s[2]).trim();
					var ki_e2=st_ki_e[0].trim()+"/"+toDoubleDigits(st_ki_e[1]).trim()+"/"+toDoubleDigits(st_ki_e[2]).trim();
//alert(ki_s2+ki_e2)
//alert(naiyo.val()+" "+txtVal);
				 //*************メール配信******************************************************

					 mailhaisin('<%=stbc%>',tenpu.val(),name.val(),kenmei.val(),naiyo.val(),'お知らせ＞');
					 mailhaisin('<%=stbc2%>','<N>',name.val(),'新着メッセージ','件名「'+kenmei.val()+'」の新着メッセージが投稿されていますのでご覧ください。','お知らせ＞');
				//通常の書き込み************************************
					$.post(
							'RequestServ_osirase',
							{
                              'oper': 'add',
                              'name': name.val(),
                             // 'kikan_s': kikan_s.val(),
                             // 'kikan_e': kikan_e.val(),
                               'kikan_s': ki_s2,
                              'kikan_e': ki_e2,
                              'title':kenmei.val(),
                              'msg': naiyo.val().replace("<p>","").replace("</p>","").trim().replace("</br>","").replace(/&#10;/g,""),
                              'tenpu':tenpu.val(),
                              'user':'<%=user%>',
                              'userid':'<%=shokuinid%>'
                            },
                            function(data){
                              // alert(data);
                           //   location.reload(true);
                            	   if(data.length>0){
                            		   alert(data);
                            		   }else{
                            			   $( "#users tbody" ).prepend( "<tr><td>" + name.val() + "<br>[" + kikan_s.val()+"~" + kikan_e.val() + "]</td>" +
       	            							"<td><b>" + kenmei.val() + "</b><br>" + txtVal.trim() + "</td></tr>" );

       	            						$( "#dialog-form" ).dialog( "close" );
       	            						location.reload();
                            		   }

                             }
					 );

				}//if
				else{
					alert("もういちど確認してください。（未入力の欄・文字数が多すぎる・日付の形式が異なる等）");
				}
				tstart(tid);
			},
			Cancel: function() {
				$( this ).dialog( "close" );
				tstart(tid);
				location.reload();
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "ui-state-error" );
		}
	});


	$( "#dialog-form_henko" ).dialog({
		autoOpen: false,
		height: 560,
		width: 700,
		modal: true,
		buttons: {
			"変更の保存": function() {






				var	bValid = true;
				allFields.removeClass( "ui-state-error" );


				if ( bValid ) {

					//ここでまとめて　複数IMG挿入
					$("#editArea2").html($("#editArea2").html()+"\n"+$("#imgtmp2").html());

					  ritchTextHtmlArea2.setText(editArea2.innerHTML);


					txtVal= henkan(naiyo.val());

  		            if($("#htenpu").val().length>0){
 		             }else{
 		             $("#htenpu").val("<N>")
 		             }


  		            	//月日　1/1を01/01に
					var ki_s = $("#hkikan_s").val();
					var ki_e = $("#hkikan_e").val();
					//alert(ki_s);
					var st_ki_s=ki_s.split("/");
					var st_ki_e=ki_e.split("/");
					var ki_s2=st_ki_s[0].trim()+"/"+toDoubleDigits(st_ki_s[1]).trim()+"/"+toDoubleDigits(st_ki_s[2]).trim();
					var ki_e2=st_ki_e[0].trim()+"/"+toDoubleDigits(st_ki_e[1]).trim()+"/"+toDoubleDigits(st_ki_e[2]).trim();

					//メール配信
					mailhaisin('<%=stbc%>',$("#htenpu").val(),$("#hname").val(),$("#hkenmei").val(),$("#hnaiyo").val(),'お知らせの変更＞');


					$.post(
							'RequestServ_osirase',
							{
                              'oper':   'update','number': $("#number").val(),'name': $("#hname").val(),'kikan_s': ki_s2,
                              'kikan_e': ki_e2,'title':   $("#hkenmei").val(), 'msg':$("#hnaiyo").val().replace(/&#10;/g,""),'tenpu':$("#htenpu").val()
                            },
                            function(data){
                              // alert(data);
                            	 if(data.length>0){
                            		   alert(data);
                            		   }else{
                            			   $("#nm"+$("#number").val()).replaceWith("<td>" + $("#hname").val() + "<br>[" +$("#hkikan_s").val()+"~" +$("#hkikan_e").val() + "]</td>");
       	                                $("#tm"+$("#number").val()).replaceWith("<div><b>" +$("#hkenmei").val() + "</b><br>" + $("#hnaiyo").val() +"</div>");
       	                                $("#tp"+$("#number").val()).replaceWith("<div>"+$("#htenpu").val()+ "</div>");
                   						$( "#dialog-form_henko" ).dialog( "close" );
                   							            							location.reload();
                            		   }

                            }
					 );
				}
				else{
					//alert("もう一度確認してください。（未入力の欄・日付の形式が異なる等）");
				}
				tstart(tid);
			},

			Cancel: function() {
				$( this ).dialog( "close" );
				tstart(tid);
				location.reload();
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
			$( "#name" ).val('<%=userN%>');
			$( "#kikan_s" ).val('<%=datestr_s%>');
			$( "#kikan_e" ).val('<%=datestr_e%>');
			tstop(tid);
		});


	$( ".henko" )
		.button()
		.click(function(e) {
		//***************************
		$( "#dialog-form_henko" ).dialog( "open" );
			var cid = e.currentTarget.id;

			 nm=$("#nm"+cid).text();
			 nmx=nm.split("[");

			 nmx1=nmx[1].split("]");
			 kis=nmx1[0].split("~");

			$( "#hname" ).val(nmx[0].trim());
			$( "#hkikan_s" ).val(kis[0]);
			$( "#hkikan_e" ).val(kis[1]);

			 tm=$("#tm"+cid).text();
			 htm=$("#tm"+cid).html();
			 tmx=htm.split("]");
			 kk=tmx[0];
			 //x=kk.replace('[','').replace('<b>','').replace(/<.+?>/g,'');
			 x=kk.replace('[','').replace('<b>','');
			$( "#hkenmei" ).val(x);

			//＠下書きあれば、チェックボックスにチェック
			if(x.indexOf('@下書き') != -1){
				 $("#sitagaki2").prop("checked", true);
			}


			//ここで、文末にIMGがあればそれを抽出し、imgtmp2に移動
			htm=htm.replace(/\\/g,'\\\\');//こうしないと、\が変更保存でへってしまう
			result = htm.search(/<img/);
			result2= tmx[1].search(/<img/);
			if (result!=-1){
			$("#imgtmp2").empty();
			//alert(tmx[1].slice(result));

			$("#imgtmp2").append(htm.slice(result));
			//$("#imgtmp2").append(result);
			tmx[1]=tmx[1].slice(0,result2-1);
			}


			hnaiyo_s=tmx[1].replace('</b>','').replace(/<br>/,'');

			hnaiyo_s=hnaiyo_s.replace(/\\/g,'\\\\');



			$( "#editArea2" ).html(hnaiyo_s);

			htmtp=$("#tp"+cid).html();
			//htenp_s=htmtp.replace('<b>','').replace('</b>','').replace(/<br>/,'');
			htenp_s=htmtp;
			htenp_s=htenp_s.replace(/\\/g,'\\\\');
			$( "#htenpu" ).val(htenp_s);
			$( "#htenput" ).empty();//こうしないと、ダイアログ切り替えたとき残っている？
			$( "#htenput" ).append(htenp_s);

			$("#number").val(cid);

			tstop(tid);




		});


   $( ".sakujo" )
		.button()
		.click(function(e) {
			var cid = e.currentTarget.id;
			cid=cid.replace('del','');


				answer=confirm('削除すると他の人も閲覧できなくなります。削除してもよろしいですか？');
					if(answer==true){
　　　					　$.post(
							'RequestServ_osirase',
							{
                              'oper':'del','number':cid,'opath':$('#opath').val(),'tenpu':$("#tm"+cid).html(),'opath2':$('#opath2').val()
                            },
                            function(data){
                              // alert(data);
                                $("#nm"+cid).remove();
                                $("#tm"+cid).remove();
                                $("#tp"+cid).remove();
        						$( "#dialog-form_henko" ).dialog( "close" );
        						$(location).attr("href", "top.jsp");
                            }
					   );
					}else{
　						$( "#dialog-form_henko" ).dialog( "close" );　　
						　}


		});


    $("#kikan_s,#kikan_e,#hkikan_s,#hkikan_e,#kensaku1,#kensaku2").datepicker({
    });


    	 $( "#clear2" )
		.button()
		.click(function() {
			$.post(
					'RequestServ_osirase',
					{
                      'oper':'deltenpu','tenpu':$("#htenpu").val(),'opath':$('#opath').val(),'number':$('#number').val()
                    },
                    function(data){

                    }
			   );
			$("#htenput").empty();
			$("#htenpu").val('');
			$("#tp"+$('#number').val()).val('');


				$.post(
						'RequestServ_osirase',
						{
	                      'oper':'delimg','tenpu':$("#imgtmp2").html(),'opath':$('#opath').val(),'opath2':$('#opath2').val()
	                    },
	                    function(data){

	                    }
				   );
				$("#imgtmp2").empty();





		});

		 $( "#clear" )
		.button()
		.click(function() {
			$.post(
					'RequestServ_osirase',
					{
                      'oper':'deltenpu','tenpu':$("#tenpu").val(),'opath':$('#opath').val()
                    },
                    function(data){

                    }
			   );
			$("#tenput").empty();
			$("#tenpu").val('');
			$("#tp"+$('#number').val()).val('');



				$.post(
						'RequestServ_osirase',
						{
	                      'oper':'delimg','tenpu':$("#imgtmp").html(),'opath':$('#opath').val(),'opath2':$('#opath2').val()
	                    },
	                    function(data){

	                    }
				   );
				$("#imgtmp").empty();




		});



		 //************************************************URL挿入
		 $(function() {
			    $("#get").click(function(){
			       $("#editArea").html($("#editArea").text()+"\n<a href=\""+$("#linkurl").val()+"\">"+$("#linkurl").val()+"</a>");
			       return false;
			    });
			});



		$(function() {
			    $("#get2").click(function(){
			       $("#editArea2").html($("#editArea2").text()+"\n<a href=\""+$("#linkurl2").val()+"\">"+$("#linkurl2").val()+"</a>");
			       return false;
			    });
			});




//**********************************
$('#link').on("change", function() {
    	 var filename = this.files[0];

        var file = $(this).val();

            var rt=file.replace(/[\\]/g,"\/");
            if(file.indexOf("\\\\")!=-1){
 				$('#naiyo').val($('#naiyo').val()+"<br><span title=\"インターネットエクスプローラでのみ使用可能\"><a href=\"file:"+rt+"\">"+"共有へのリンク＞"+filename.name+"</a></span>");
           　			}else{
            　　				     alert("共有にあるファイルを指定してください。");
            }

    });

$('#link2').on("change", function() {
 var filename = this.files[0];

var file = $(this).val();

    var rt=file.replace(/[\\]/g,"\/");
    if(file.indexOf("\\")!=-1){
    //	alert(file);
　　　        $('#hnaiyo').val($('#hnaiyo').val()+"<br><span title=\"インターネットエクスプローラでのみ使用可能\"><a href=\"file:"+rt+"\">"+"共有へのリンク＞"+filename.name+"</a></span>");
　　　}else{
       alert(file+":共有にあるファイルを指定してください。");
　　　}
});






//imgに日時_ユーザ名でファイル名をつける  時刻が更新ならない？？？？？？？
$('#imgfileup1').change(function(e) {

   var flggazo=false;
	$(".wait").replaceWith("<label for='tenpu' class='wait'><font color='red'>処理中です...少しお待ち下さい</font></label>");
	 var file = $(this).prop('files')[0];
	 fext=file.name.split('.')[1];
     if(  (fext=='jpg'||fext=='JPG') &&  $("#img_gazo").prop('checked')  ){
    	 flggazo=true;
    	 <%
 	    String imgFileName=format_yyyyMMddHHmmss.format(calimg.getTime());
 		%>
 		$('.jpgname').val('<%=imgFileName %>_'+file.name);

 		//****************************************

    	    var $form, fd;
    	    $form = $("#myForm");
    	    fd = new FormData($form[0]);
    	    $.ajax($form.attr("action"), {
    	      type: 'post',
    	      processData: false,
    	      contentType: false,
    	      data: fd,
    	      dataType: 'html',
    	      success: function(data){
    	    	//  alert(data);
    	    	data=data.trim();
    	       	$("#imgtmp").append("<img src='"+data+"' alt='"+data+"'>");

    	        $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");

    	      }
    	    });
     }

	   //*********tmp tuika

    $(this).upload('fileupload', function(res) {
	      tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+res;
  tuika2="<a href=\""+tuikad2+"\">"+res+"</a>";//保存は通常文字で
	  $('#tenpu').val($('#tenpu').val()+'<br>'+tuika2);
	  $('#tenput').append(tuika2+'　');
	 if(flggazo==false){
		 $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");

	 }

}, 'text');
//***********************************


   	    return false;

		//===========================================
});

$('#imgfileup2').change(function(e) {
	var flggazo2=false;
	$(".wait").replaceWith("<label for='tenpu' class='wait'><font color='red'>処理中です...少しお待ち下さい</font></label>");
	 var file = $(this).prop('files')[0];
	 fext=file.name.split('.')[1];
     if( (fext=='jpg'||fext=='JPG')  &&  $("#img_gazo2").prop('checked') ){
    	 flggazo2=true;
    	 <%
		    String imgFileName2=format_yyyyMMddHHmmss.format(calimg.getTime());
			%>
			$('.jpgname').val('<%=imgFileName2 %>_'+file.name);

			//****************************************

			var $form, fd;
	 	    $form = $("#myForm2");
	 	    fd = new FormData($form[0]);
	 	    $.ajax($form.attr("action"), {
	 	      type: 'post',
	 	      processData: false,
	 	      contentType: false,
	 	      data: fd,
	 	      dataType: 'html',
	 	      success: function(data){
	 	    	 data=data.trim();
	 	       	$("#imgtmp2").append("<img src=\""+data+"\" alt=\""+data+"\">");
	 	       $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");

	 	      }
	 	    });
     }


	    	   //*********tmp tuika

	             $(this).upload('fileupload', function(res) {
		  	      tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+res;
                  tuika2="<a href=\""+tuikad2+"\">"+res+"</a>";//保存は通常文字で
     			 $('#htenpu').val($('#htenpu').val()+'<br>'+tuika2);
    			 $('#htenput').append(tuika2+'　');
    			 if(flggazo2==false){
    				 $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");
    			 }

		 }, 'text');
	    //***********************************
	 	    return false;


});



$('#sitagaki1').change(function(){

	if($(this).is(':checked')){
       $('#kenmei').val($('#kenmei').val()+"@下書き");
	}else{
		 $('#kenmei').val($('#kenmei').val().replace("@下書き",""));
	}

});

$('#sitagaki2').change(function(){

	if($(this).is(':checked')){
       $('#hkenmei').val($('#hkenmei').val()+"@下書き");
	}else{
		 $('#hkenmei').val($('#hkenmei').val().replace("@下書き",""));
	}

});





		//****************************upload



	$('.fileup').change(function(e) {
	 $(".wait").replaceWith("<label for='tenpu' class='wait'>添付<font color='red'>>>しばらくそのままお待ちください...</font></label>");
    <%
	String nowtime=format3.format(cal.getTime());
	%>
	  fln=$(this).val();
   			  sst=fln.split("\\");
   			  tuikao=jQuery.trim($('#opath').val())+jQuery.trim(sst[sst.length-1]);
   	 			  tuikad=jQuery.trim(sst[sst.length-1]);



         $(this).upload('fileupload', function(res) {
        	// alert(res); //ファイルアップロード　確認表示だせるが、、まぎらわしいので　なしにする

        	//こちらは、通常のリンクからのダウンロード
        	// tuikad2=jQuery.trim($('#opath2').val())+res;
   			//こちらは、専用のダウンロードサーブレット　zipファイルになる不具合あり
   			 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+res;

   			//tuika2="<a href=\""+encodeURI(tuikad2)+"\">"+res+"</a>";
tuika2="<a href=\""+tuikad2+"\">"+res+"</a>";//保存は通常文字で
    			if (e.currentTarget.id=='file1'){
    			 $('#tenpu').val($('#tenpu').val()+'<br>'+tuika2);
    			  $('#tenput').append(tuika2+'　');
    			 }else{
    			 $('#htenpu').val($('#htenpu').val()+'<br>'+tuika2);
    			 $('#htenput').append(tuika2+'　');
    			 }

					$(".wait").replaceWith("<label for='tenpu' class='wait'>添付<font color='green'>ファイルのアップロード終了！次の操作に移ってもだいじょうぶです</font></label>");

			 }, 'text');
     });

$(function(){
 $(".tooltip input").hover(function() {
    $(this).next("span").animate({opacity: "show", top: "-75"}, "slow");}, function() {
           $(this).next("span").animate({opacity: "hide", top: "-85"}, "fast");
 });
});

$("#editArea").on("paste",function(event){
	//editAreaに貼り付けしたとき 余分なタグを除去して　エラー防止
setTimeout( function() {
	$("#editArea").html($("#editArea").text().replace(/(\n|\r)(\n|\r)/g,'<br>').trim());
	//naiyo.val($("#editArea").text().replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'').replace(/<br>/,'').tirm());
    }, 10 );
});

$("#editArea2").on("paste",function(event){
	//editAreaに貼り付けしたとき 余分なタグを除去して　エラー防止
  setTimeout( function() {
// alert($("#editArea2").html());
 $("#editArea2").html($("#editArea2").html().replace(/<br>/g,'\r'));

$("#editArea2").html($("#editArea2").text().replace(/(\n|\r)(\n|\r)/g,'<br>').replace(/(\r|\n)/g,'<br>').trim());
//alert($("#editArea2").html());
$("#editArea2").html($("#editArea2").html().replace(/<br><br>/g,'<br>'));

    }, 10 );
});



});
//*$(function start**はここで終わり**********************************************************************************************


		//************************************************************************************

	  // Drop領域にドロップした際のファイルのプロパティ情報読み取り処理
function onDrop(event) {

	   event.preventDefault();

    // （1）ドロップされたファイルのfilesプロパティを参照
    var files = event.dataTransfer.files;


	 $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='red'>>>しばらくそのままお待ちください...</font></label>");

    for (var i = 0; i < files.length; i++) {
      var f = files[i];

		  var fd = new FormData();
	        fd.append('file', files[i]);
	        if (i==files.length-1) {
	        	last='true';
	        }else{
	        	last='false';
	        }
	       // alert("01 targetId="+event.currentTarget.id+"  fd="+fd);
	        sendFileToServer(fd,event.currentTarget.id,last,files[i]);

    }

    // （3）ブラウザ上でファイルを展開する挙動を抑止

  }

  function onDragOver(event) {
    // （4）ブラウザ上でファイルを展開する挙動を抑止
	   event.preventDefault();
  }

  function sendFileToServer(formData,ct,last,file)
  {



		// file=formData.get('file');
		 fext=file.name.split('.')[1];

         // alert("file.name="+file.name);


	     if(  (fext=='jpg'||fext=='JPG') && ( $("#img_gazo").prop('checked')&& ct=='dialog-form' ||  $("#img_gazo2").prop('checked')&& ct=='dialog-form_henko') ){
	      	 <%
	  	    String imgFileName3=format_yyyyMMddHHmmss.format(calimg.getTime());
	  		%>
	  		//$('.jpgname').val('<%=imgFileName3 %>_'+file.name);
	  		formData.append('flg','oimg');
	  		formData.append('userID2',<%=imgFileName%>);
	  		if(ct=='dialog-form'){
	  			formData.append('height',$('#height1').val());
	  		}else{
	  			formData.append('height',$('#height2').val());
	  		}

	  		//****************************************
	  		//alert("jpg de dousa ");
	     }else{
	    	 formData.append('flg','');
	     }




      var uploadURL ="fileupload"; //Upload URL
      var extraData ={}; //Extra Data.
      $.ajax({
          url: uploadURL,
          type: "POST",
          contentType:false,
          processData: false,
          cache: false,
          data: formData,
          error: function(xhr, error) {
        	    console.log('uploadに失敗しました');
        	    console.log(error);
        	   },
          success: function(data){

        	  if(data.indexOf('\n') != -1){
        		  var stmp=data.split('\n');
         	     if(  (fext=='jpg'||fext=='JPG') &&  $("#img_gazo").prop('checked') && ct=='dialog-form' ){
           	 	       	$("#imgtmp").append("<img src='"+stmp[1].trim()+"' alt='"+stmp[1].trim()+"'>");
         	     }else if( (fext=='jpg'||fext=='JPG') &&  $("#img_gazo2").prop('checked') && ct=='dialog-form_henko' ){
 	                 	$("#imgtmp2").append("<img src='"+stmp[1].trim()+"' alt='"+stmp[1].trim()+"'>");
         	     }
        		 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+stmp[0].trim();//サーブレットによるダウンロード方式に変更
            	 tuika2="<a href=\""+tuikad2+"\">"+stmp[0].trim()+"</a>";
        	  }else{
        			 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+data;//サーブレットによるダウンロード方式に変更
                	 tuika2="<a href=\""+tuikad2+"\">"+data+"</a>";
        	  }





			if (ct=='dialog-form'){
			 $('#tenpu').val($('#tenpu').val()+'<br>'+tuika2);
			  $('#tenput').append(tuika2+'　');


			}
			  else	{
				 $('#htenpu').val($('#htenpu').val()+'<br>'+tuika2);
       			 $('#htenput').append(tuika2+'　');

			  }




		  if(last=='true'){
				$(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>ファイルのアップロード終了！次の操作に移ってもだいじょうぶです</font></label>");
			  }

          }
      });






  }




  //********************************************自動リロード 30min


$.post(
	'sette_p',
	{
      'flg':'yomi'
    },
    function(data){
     var st=data;
   dtdt=st.split('\t');
   jQuery('.igazo').each(function(){
		jQuery(this).attr('src',dtdt[1]+'mylogo/'+$(this).attr('src'));
		 $(this).error(function() {
				//ファイルが存在しない画像はdefault.jpg or dell
              //   $(this).attr('src', 'default.jpg');
		        $(this).remove();
		    });
	});
});





</script>







