
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>

<%@ page session="true" %>
<%@page import="java.io.*"%>



<%


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
 Cookie cookies[] = request.getCookies();

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




 }

 // 表示する文字列
 String sidval;
 String sfiltermoji;

 // 該当するクッキーがみつからなかった場合
 if(idval == null) {
     sidval = "";
     %><marquee scrolldelay="200" scrollamount="80" width="900">
     <font color="red" size=+2>いったん、「終了」し「ログイン」してからご利用ください！(cookie設定要確認)</font></marquee><%
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








//******session shutoku*************************************


session.setAttribute("shokuinid",shokuinid);




      GregorianCalendar cal = new GregorianCalendar();
      SimpleDateFormat format = new SimpleDateFormat("yyyy年M月d日");
      SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
      SimpleDateFormat format3 = new SimpleDateFormat("HHmm");
      SimpleDateFormat format4 = new SimpleDateFormat("HH時mm分");


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

//request.setCharacterEncoding("UTF-8");
  String kensaku1=request.getParameter("kensaku1");
  if (kensaku1==null){kensaku1=datestr_s;}
  String kensaku2=request.getParameter("kensaku2");
  if (kensaku2==null){kensaku2=datestr_s;}
  String kensaku3=request.getParameter("kensaku3");
   if (kensaku3==null){kensaku3="%";}
   else{kensaku3="%"+kensaku3+"%";}


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


 	<!--***********************************　**************今日の予定-->
 <table id="sotowaku" >
  <tr>
   <td valign="top" id="users" >
     <table class="ui-widget ui-widget-content nakawaku" width=100% >
      <thead>
		<tr class="ui-widget-header">
		 <th id="sento" title="今日の予定以外に、回覧・メールの未読、授業変更の情報を表示します。予定は５分毎に最新データを読み込みます。">　　　<%=datestr%>　　　</th>
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

 				cal.add(Calendar.DATE,-14);
    		  	String datestr_s_1nen = format2.format(cal.getTime());

 				rs6=stmt6.executeQuery("SELECT count(*) as cnt from kairan LEFT JOIN ( SELECT DISTINCT kairanlog.kairanid FROM kairanlog where date >= '"+datestr_s_1nen+ "' and shokuinid="+shokuinid+") LOG_TEMP ON LOG_TEMP.kairanid = kairan.id WHERE LOG_TEMP.kairanid is null and date >= '"+datestr_s_1nen+ "' and  FIND_IN_SET('"+shokuinid+"',hyoji) ");
				String kairanid,kidoku;
 				Integer cou=0;
 				if(rs6.next())
 				cou=Integer.parseInt(rs6.getString("cnt"));




 				if (cou>0 && cou<=20) { %><div id="chui" ><b><font color='red'>>>><a href='kairan.jsp?rmsg=NULL'><font color='red' >直近２週間の未読回覧は<%=cou%>件です。</font></b></a><br> </div><% }
 				else if (cou>20) { %><div id="chui" ><b><font color='red'>>>><a href='kairan.jsp?rmsg=NULL'><font color='red' size='<%=cou/4%>'>直近２週間の未読回覧は<%=cou%>件です。</font></b></a><br> </div><% }%>


 	    	<!--メールないかチェック**ここに追加******************************-->

        </td>
        </tr>
        <tr><td id="henkocheck"></td></tr>

        </tbody>
       </table>

     <!--***************************おしらせ**************************************************************  -->
　　　　　　
		<table id="users" class="ui-widget ui-widget-content nakawaku" >
			<thead >
				<tr class="ui-widget-header ">

					<th > </th>
					<th>
						<b>　　お知らせ　　</b>



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
			String Swhere=" where kikan_s <= '"+kensaku2+"' and kikan_e >= '"+kensaku1+"' "
          		  +"and (title like '"+kensaku3+"' or msg like '"+kensaku3+"') "+joken;

            Collator cmp2 = Collator.getInstance();




				 strSql = "SELECT * FROM keijiban "+Swhere+" order by id desc";



            rs = stmt.executeQuery(strSql);

            	String scolor="";

			  String tmpid="";
			  while(rs.next()){ tmpid=rs.getString("id");userid=rs.getString("userid");
			     if (cmp2.compare(rs.getString("kikan_s"),  datestr_s)<=0 && cmp2.compare(rs.getString("kikan_e"), datestr_s)>=0) {
			      scolor="black";
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

               </td>
              <td class="nakawaku" style="word-break: break-all;"><div class="title_msg htmlbox" id="tm<%=tmpid%>" ><b>[<%=rs.getString("title")%>]</b><BR><%=rs.getString("msg").replace("\n","<br>")%></div>
              <div id="tp<%=tmpid%>"><%=rs.getString("tenpu").replace("\n","<br>").replace("<N>","")%></div></td>
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
		 <th id="sento">明日以降　</th>
		</tr>
	   </thead>
	   <tbody>
        <tr><td id="yotei2" ></td></tr>
       </tbody>
    </table>



   </td></tr>
 </table></td>
  　<div align="Right"><font size=-1 >SGW　ReadOnly</font></div>


</div><!-- End demo -->
<input type='hidden' id='opath'>
<input type='hidden' id='opath2'>




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


   $("#kensaku1").val("<%=kensaku1%>");
   $("#kensaku2").val("<%=kensaku2%>");
   $("#kensaku3").val("<%=kensaku3%>".replace("%","").replace("%",""));

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
                               $(d2t[0]).appendTo('#yotei');
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



//＊＊＊＊＊＊＊＊＊＊＊＊＊＊******************************************************************


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







	function henkan(moji){
						moji = moji.replace(/\r\n/g, "<br>");
						moji = moji.replace(/(\n|\r)/g, "<br>");
						return moji;

	}




		 //************************************************URL挿入



$(function(){
 $(".tooltip input").hover(function() {
    $(this).next("span").animate({opacity: "show", top: "-75"}, "slow");}, function() {
           $(this).next("span").animate({opacity: "hide", top: "-85"}, "fast");
 });
});




});
//*$(function start**はここで終わり**********************************************************************************************





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







