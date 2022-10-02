<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="java.net.*,java.io.*, com.itextpdf.text.Document,com.itextpdf.text.DocumentException,com.itextpdf.text.Font,com.itextpdf.text.PageSize, com.itextpdf.text.Paragraph,com.itextpdf.text.pdf.BaseFont,com.itextpdf.text.pdf.PdfWriter"%><%

response.setContentType( "application/pdf" );



// step 1: ドキュメントオブジェクトの作成
Document document = new Document();

// step 2: 出力のためのストリームを作成

ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter.getInstance( document, buffer );

// step 3: ドキュメントを開く
document.open();

request.setCharacterEncoding("UTF-8");
String naiyo=new String(request.getParameter("naiyo").getBytes("UTF-8"),"UTF-8");
String nichime=new String(request.getParameter("nichime").getBytes("UTF-8"),"UTF-8").trim();
String fontsize=new String(request.getParameter("fontsize").getBytes("UTF-8"),"UTF-8").trim();


Font font=new Font( BaseFont.createFont( "HeiseiKakuGo-W5", "UniJIS-UCS2-H", BaseFont.NOT_EMBEDDED ),Integer.parseInt(fontsize) );

if (nichime.equals("0")){
	naiyo=naiyo.replaceAll("<br>","\n").replaceAll("<.+?>", "").replace("(未読者は青)","");


}else if (nichime.equals("1")){
	naiyo=naiyo.replaceAll("<br>","\n").replaceAll("<.+?>", "");
	String ny[]=naiyo.split("\n\n",-1);
	naiyo=ny[0].replace("明日","");
}else if (nichime.equals("2")){
	naiyo=naiyo.replaceAll("<br>","\n").replaceAll("<.+?>", "");
	String ny2[]=naiyo.split("\n\n",-1);
	naiyo=ny2[1].replace("明後日","");
}else if (nichime.equals("3")){
	naiyo=naiyo.replaceAll("<br>","\n").replaceAll("<.+?>", "");
	String ny3[]=naiyo.split("\n\n",-1);
	naiyo=ny3[2].replace("３日後","");
}else {
	naiyo=nichime+"\n"+naiyo.replaceAll("<br>","\n").replaceAll("<.+?>", "");
}



// step 4: ドキュメントにパラグラフ(文字列)を追加
  Paragraph preface = new Paragraph();
  preface.add( new Paragraph(naiyo, font));
document.add(preface);


// step 5: ドキュメントを閉じる
document.close();

// step 6: JSPのストリームにPDFを出力する
DataOutput output = new DataOutputStream( response.getOutputStream() );
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for( int i = 0; i < bytes.length; i++ ) { output.writeByte( bytes[i] ); }
%>