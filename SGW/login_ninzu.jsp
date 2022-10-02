
<%
int cmin;
String strUname=(String)(application.getAttribute("uname"));
String strAtime=(String)(application.getAttribute("atime"));//アクセス時刻
if(strUname==null){
strUname="";
strAtime="";
cmin=0;
}else{
//strCnt=Integer.toString(Integer.parseInt(strCnt)+1);
strUname=strUname+","+user;
Calendar calendar = Calendar.getInstance();
int hour = calendar.get(Calendar.HOUR_OF_DAY);
int minute = calendar.get(Calendar.MINUTE);
cmin=hour*60+minute;
strAtime=strAtime+","+Integer.toString(cmin);
}


String Uname[];
String Atime[];
Uname=strUname.split(",");
Atime=strAtime.split(",");
strUname="";
strAtime="";
for (int i=1;i<Uname.length;i++){
	if(Integer.parseInt(Atime[i])< cmin-5 || Integer.parseInt(Atime[i])> cmin){//5分経過したか、日付かわったら前のデータ消去
		Uname[i]="";
	}else{
		strUname=strUname+","+Uname[i];
		strAtime=strAtime+","+Atime[i];
	}
}

TreeMap<String,Integer> tm = new TreeMap<String,Integer>();
for(String s : Uname){
if(!tm.containsKey(s)){
tm.put(s,1);
}else{
tm.put(s,tm.get(s).intValue()+1);
}
}
int cnt=0;
String strUnm="";
for(String s : tm.keySet()){
	strUnm=strUnm+" "+s;
cnt=cnt+1;
}
String strCnt="";
if (cnt<=1){
	strCnt=Integer.toString(1);
}else{
	 strCnt=Integer.toString(cnt-1);
}


application.setAttribute("uname",strUname);
application.setAttribute("atime",strAtime);



%>