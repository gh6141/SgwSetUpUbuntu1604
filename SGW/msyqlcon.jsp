<%
//JDBCドライバを登録
Class.forName("com.mysql.jdbc.Driver");
//データベース接続文字列を作成
String strConn = "jdbc:mysql://"+application.getInitParameter("hostname")+"/skt?user="+application.getInitParameter("mysqluser")+"&password="+application.getInitParameter("mysqlpass")+"&useUnicode=true&characterEncoding=utf-8";
//コネクションオブジェクトを取得
Connection conn = DriverManager.getConnection(strConn);
conn.setReadOnly(true);;//読み取り専用にして高速化
%>