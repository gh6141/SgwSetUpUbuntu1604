<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>
<%@ page session="true" %>
<%
 String userN="";
  String shokuinid="";
  String user="";
  String userid="";
 // 内容: クッキーを使用する(クッキーの取得)
 // クッキーの配列を取得
 Cookie cookies[] = request.getCookies();
 // 目的のクッキーを格納する変数
 Cookie idval = null;
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
 // 該当するクッキーがみつからなかった場合
 if(idval == null) {
     sidval = "";
 } else { // クッキーがみつかった場合は値を取得(URLデコードする)
    sidval = URLDecoder.decode(idval.getValue());
 }


 if (sidval == null){
	 request.setCharacterEncoding("UTF-8");
	 sidval= request.getParameter("user");


 }else {
	 request.setCharacterEncoding("UTF-8");
	 sidval= request.getParameter("user");
 }
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

//*********************************メール配信のアドレスは先にセット


//******session shutoku*************************************
session.setAttribute("shokuinid",shokuinid);

      GregorianCalendar cal = new GregorianCalendar();
      SimpleDateFormat format = new SimpleDateFormat("yyyy年M月d日(E)");
      SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
      SimpleDateFormat format3 = new SimpleDateFormat("HHmm");
      SimpleDateFormat format4 = new SimpleDateFormat("HH時mm分");
      String datestr = format.format(cal.getTime());
      String datestr_s = format2.format(cal.getTime());
      cal.add(Calendar.DATE,9);
      String datestr_e = format2.format(cal.getTime());

 cal.add(Calendar.DATE,-9+180);
String osirase_mirai=format2.format(cal.getTime());
 cal.add(Calendar.DATE,-180*2);
String osirase_kako=format2.format(cal.getTime());

request.setCharacterEncoding("UTF-8");
  String kensaku1=request.getParameter("kensaku1");
  if (kensaku1==null){kensaku1=datestr_s;}
  String kensaku2=request.getParameter("kensaku2");
  if (kensaku2==null){kensaku2=datestr_s;}
  String kensaku3=request.getParameter("kensaku3");
   if (kensaku3==null){kensaku3="%";}
   else{kensaku3="%"+kensaku3+"%";}

    %>

<%=userN%>,未読回覧
  		  <%
				Statement stmt6 = conn.createStatement();
				Statement stmt5 = conn.createStatement();
				ResultSet rs5;
				ResultSet rs6;

 				cal.add(Calendar.DATE,-14);
    		  	String datestr_s_1nen = format2.format(cal.getTime());
    			String addsql="(((title like '%@下書き%' or title like '%＠下書き%') and FIND_IN_SET('"+shokuinid+"',hyoji)=1)  or (title not like '%@下書き%' and title not like '%＠下書き%') ) and ";

 				rs6=stmt6.executeQuery("SELECT count(*) as cnt from kairan LEFT JOIN ( SELECT DISTINCT kairanlog.kairanid FROM kairanlog where  shokuinid="+shokuinid+") LOG_TEMP ON LOG_TEMP.kairanid = kairan.id WHERE "+addsql+" LOG_TEMP.kairanid is null and  FIND_IN_SET('"+shokuinid+"',hyoji) ");
				String kairanid,kidoku;
 				Integer cou=0;
 				if(rs6.next())
 				cou=Integer.parseInt(rs6.getString("cnt"));

 				if (cou>0) { %>,<%=cou%> <% }
 				 else { %>,0<% } %>


<input type='hidden' id='opath'>
<input type='hidden' id='opath2'>


</body>
</html>
