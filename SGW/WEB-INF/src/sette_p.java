
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/sette_p")
public class sette_p extends HttpServlet {


	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		//入力情報の取得
		request.setCharacterEncoding("UTF-8");
		String flg = request.getParameter("flg");
		String contents = request.getParameter("osirase_path");
		String contents2 = request.getParameter("osirase_path2");
		String contents3 = request.getParameter("excel_path");
		//String contents4 = request.getParameter("regex_pattern");
		String contents4k = request.getParameter("excel_komoku");
		String contents5 = request.getParameter("sosin_ad");
		String contents6 = request.getParameter("smtp");
		String contents7 = request.getParameter("port");
		String contents8 = request.getParameter("sosin_pass");

		//response準備
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String path = getServletContext().getRealPath("/WEB-INF/opath.txt");
		String path2 = getServletContext().getRealPath("/WEB-INF/opath2.txt");
		String path3 = getServletContext().getRealPath("/WEB-INF/excel_path.txt");
		//String path4 = getServletContext().getRealPath("/WEB-INF/regex_pattern.txt");
		String path4k = getServletContext().getRealPath("/WEB-INF/excel_komoku.txt");
		String path5 = getServletContext().getRealPath("/WEB-INF/sosin_ad.txt");
		String path6 = getServletContext().getRealPath("/WEB-INF/smtp.txt");
		String path7 = getServletContext().getRealPath("/WEB-INF/port.txt");
		String path8 = getServletContext().getRealPath("/WEB-INF/sosin_pass.txt");
	//	out.println("<html><head><title>sette_p</title></head><body>");
	//	out.println("<h2>設定の保存</h2>");
		//ファイル書き込み
		if (flg.equals("kaki")) {
			try	{

			BufferedWriter fout = new BufferedWriter(new FileWriter(path,false));
			BufferedWriter fout2 = new BufferedWriter(new FileWriter(path2,false));
			BufferedWriter fout3 = new BufferedWriter(new FileWriter(path3,false));
			//BufferedWriter fout4 = new BufferedWriter(new FileWriter(path4,false));
			BufferedWriter fout4k = new BufferedWriter(new FileWriter(path4k,false));
			BufferedWriter fout5 = new BufferedWriter(new FileWriter(path5,false));
			BufferedWriter fout6 = new BufferedWriter(new FileWriter(path6,false));
			BufferedWriter fout7 = new BufferedWriter(new FileWriter(path7,false));
			BufferedWriter fout8 = new BufferedWriter(new FileWriter(path8,false));
			fout.write(contents);
			fout.newLine();
			fout.close();
			fout2.write(contents2);
			fout2.newLine();
			fout2.close();
			fout3.write(contents3);
			fout3.newLine();
			fout3.close();
			//fout4.write(contents4);
			//fout4.newLine();
			//fout4.close();
			fout4k.write(contents4k);
			fout4k.newLine();
			fout4k.close();
			fout5.write(contents5);
			fout5.newLine();
			fout5.close();
			fout6.write(contents6);
			fout6.newLine();
			fout6.close();
			fout7.write(contents7);
			fout7.newLine();
			fout7.close();
			fout8.write(contents8);
			fout8.newLine();
			fout8.close();
			out.println("正常に書き込みました。");
			} catch (IOException e)	{
			out.println("エラー：" + e.getMessage() + "<p>");
			e.printStackTrace(out);
			}
	//	out.println("</body></html>");
		}else { //yomi no baai
			String str = null;String str2 = null;String str3 = null;String str4k = null;String str5 = null;String str6 = null;
			String str7 = null;String str8 = null;
			try	{
				BufferedReader in=new BufferedReader(new FileReader(path));
				while((str=in.readLine())!=null) {
					out.print(str+'\t');
				}
				in.close();

				BufferedReader in2=new BufferedReader(new FileReader(path2));
				while((str2=in2.readLine())!=null) {
					out.print(str2+'\t');
				}
				in2.close();

				BufferedReader in3=new BufferedReader(new FileReader(path3));
				while((str3=in3.readLine())!=null) {
					out.print(str3+'\t');
				}
				in3.close();

				//BufferedReader in4=new BufferedReader(new FileReader(path4));
				//while((str4=in4.readLine())!=null) {
					//out.print(str4+'\t');
				//}
			//	in4.close();

				BufferedReader in4k=new BufferedReader(new FileReader(path4k));
				while((str4k=in4k.readLine())!=null) {
					out.print(str4k+'\t');
				}
				in4k.close();

				BufferedReader in5=new BufferedReader(new FileReader(path5));
				while((str5=in5.readLine())!=null) {
					out.print(str5+'\t');
				}
				in5.close();

				BufferedReader in6=new BufferedReader(new FileReader(path6));
				while((str6=in6.readLine())!=null) {
					out.print(str6+'\t');
				}
				in6.close();

				BufferedReader in7=new BufferedReader(new FileReader(path7));
					while((str7=in7.readLine())!=null) {
						out.print(str7+'\t');
					}
					in7.close();

				BufferedReader in8=new BufferedReader(new FileReader(path8));
					while((str8=in8.readLine())!=null) {
						out.print(str8);
				}
				in8.close();


			} catch (IOException e)	{
				out.println("エラー：" + e.getMessage() );
				e.printStackTrace(out);
			}
		}//if
		out.close();
	} //post

} //class
