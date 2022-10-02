import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;



public class poi extends HttpServlet {
  /**
	 *
	 */
	private static final long serialVersionUID = 1L;
//private static final Exception Cachex = null;


	  public static String ZtoH(String s) {
		    StringBuffer sb = new StringBuffer(s);
		    for (int i = 0; i < sb.length(); i++) {
		      char c = sb.charAt(i);
		      if (c >= '０' && c <= '９') {
		        sb.setCharAt(i, (char)(c - '０' + '0'));
		      }
		    }
		    return sb.toString();
		  }

	  public static String HtoZ(String str) {
	        if (str == null){
	            throw new IllegalArgumentException();
	        }
	        StringBuffer sb = new StringBuffer(str);
	        for (int i = 0; i < str.length(); i++) {
	            char c = str.charAt(i);
	            if ('0' <= c && c <= '9') {
	                sb.setCharAt(i, (char) (c - '0' + '０'));
	            }
	        }
	        return sb.toString();
	    }


public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException{

			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();

		    String hiduke = request.getParameter("hiduke");
		    String hiduke2 = request.getParameter("hiduke2");
		    String month = request.getParameter("month");
		    String sfiltermoji= request.getParameter("sfiltermoji");
		    String freset=request.getParameter("freset");

		    String[] w = {"日","月","火","水","木","金","土"};

			 Calendar calendar = Calendar.getInstance();
			    int hour = calendar.get(Calendar.HOUR_OF_DAY);
			    int minute = calendar.get(Calendar.MINUTE);
			    int cmin=hour*60+minute;//現在時刻　整数値
try{
    ServletContext sc = getServletContext();
    String ptime = (String)sc.getAttribute("time");//前回のキャッシュ時の時刻
    String Cachex=(String)sc.getAttribute("cache");

    if(freset.equals("false")&&month.equals("00") && cmin>=Integer.parseInt(ptime)&&cmin<=1+Integer.parseInt(ptime) && Cachex!=null){
    	//１０日以内表示で、もし、前回のキャッシュ作成から5分以上経過してないときは、キャッシュ利用
//通常は　fresetはfalseでリセットしない
    	out.print(Cachex);
        return;

	 }else{
		 //fresetをTrueにすると、強制的にリセット

	 }
}catch(Exception e){
	//System.out.println(e.getMessage()+":error");
}






  try	{
String pst="0000/00/00";
			String path3 = getServletContext().getRealPath("/WEB-INF/excel_path.txt");
			String path4k = getServletContext().getRealPath("/WEB-INF/excel_komoku.txt");
			 String str3 = null;String str4k = null;	String tmp3=null;String tmp4k=null;

		BufferedReader in3=new BufferedReader(new FileReader(path3));
		while((str3=in3.readLine())!=null) {
tmp3=str3;
			//out.println("/"+tmp3+"/"+"/");
		}
		in3.close();


		BufferedReader in4k=new BufferedReader(new FileReader(path4k));
		while((str4k=in4k.readLine())!=null) {
tmp4k=str4k;

			//out.println("/"+"/"+tmp4+"/");
		}
		in4k.close();
		String kname = tmp4k;
//******************************************************

		File fl =new File(tmp3);
		if (fl.exists()){
			 InputStream inp = new FileInputStream(tmp3);

			    //（2）入力ファイルを表すワークブックオブジェクトの生成
			    Workbook wb;

			    String tuki,hi[];
			    Integer konnendo;

			    Calendar ffday  = new GregorianCalendar();
			    int fyear=ffday.get(Calendar.YEAR);
			    konnendo=fyear;
			    int fmonth=ffday.get(Calendar.MONTH)+1;//今月
			    if (fmonth<=3) konnendo=konnendo-1;

			    //9日後の年、月も算出しておく
			    ffday.add(Calendar.DATE,9);

			  String sfdate=hiduke;
			   String sfdate2=hiduke2;
			  //  out.println(sfdate+"~"+sfdate2+"<br>");

			   Calendar today = new GregorianCalendar();

			   today.add(Calendar.DATE,-1);

				    String gyo="";String gatu="";String dt="";String st[];String knm[];String nen;String his;
				    Integer nichi=0;String mae,ato;
                    String Cache="";
//				    Matcher m;
					wb = WorkbookFactory.create(inp);



					if(!month.equals("00")){//月予定表示の場合*******************************************************

          			  out.print("<div><table id=hyo width=95% border=1 style='font-size:12px;border-collapse:collapse;'>");
                      boolean sento=true;
                      int im=Integer.parseInt(month)-4;

						if(Integer.parseInt(month)>0 && Integer.parseInt(month)<=3){
							im=Integer.parseInt(month)+8;
						}

                      Sheet sheet2 = wb.getSheetAt(im);


                      List<List<String>> Asheet=new ArrayList<List<String>>();
                      int maxcol=0;

                      for (Row row : sheet2) {//各行移動
                    	  List<String> kakugyo=new ArrayList<String>();
                          for (Cell cell : row) {//各セル移動
				                String cellValue = null;
				                int cellType = cell.getCellType();

				                switch (cellType) {
				                case Cell.CELL_TYPE_NUMERIC:
				                    double dValue = cell.getNumericCellValue();
				                    cellValue = String.valueOf(dValue);
				                    break;
				                case Cell.CELL_TYPE_STRING:
				                    cellValue = cell.getStringCellValue();
				                    break;
				                case Cell.CELL_TYPE_BLANK:
				                	cellValue=" ";
				                	break;
				                default:
				                	 cellValue="";
				                    break;
				                }
				                // セル値の出力
				                cellValue=cellValue.replace(".0","").replace(",","、");
                                kakugyo.add(cellValue);

				            }
                          if(kakugyo.size()>maxcol) {maxcol=kakugyo.size();}
                          Asheet.add(kakugyo);
                      }


                      for(List<String> kgyo:Asheet){
                    	     out.print("<tr>");

                    	  for(int cct=0 ;cct<maxcol;cct++){
                    		  String cel="";
                    		  try{
                    			  cel=kgyo.get(cct);
                    		  }catch(Exception e){

                    		  }
                    		 // if (cct+1>=kgyo.size()){
                    		//	  cel=kgyo.get(cct);
                    		 // }

                              if (sento) {
				                	String width="";
				                	switch (cct){
				                	case 0:
				                		width="width=25";
				                		break;
				                	case 1:
				                		width="width=15";
				                		break;

				                	default:
				                		width="";
				                		break;

				                	}
				                	out.print("<td "+width+" align=left>"+cel+"</td>");
				                }else{
				                	out.print("<td align=left>"+cel+"</td>");
				                }

                    	  }
                          out.print("</tr>");
				            sento=false;
                      }
                      out.print("</table><div>");




					}else{//Top画面表示の場合******************************************************************
						//高速化のため、今月、１０日分表示では、今月と来月しか読み込まない
						//************シートは４月から順に並んでいる必要あり

                        String stuki[]=new String[12];
                        for(int i=0 ;i<12;i++){
                            Sheet sheet = wb.getSheetAt(i);
					        gatu=wb.getSheetName(i);//シート名は　○月の形式だとする
				         	tuki="00"+ZtoH(gatu).replace("月","");
			            	 tuki = tuki.substring(tuki.length()-2,tuki.length());
			            	 stuki[i]=tuki;
                        }



						int shnum[]=new int[2];
						shnum[0]=fmonth-4;
						shnum[1]=fmonth-3;
						if(fmonth>0 && fmonth<4){
							shnum[0]=fmonth+8;
                            shnum[1]=(fmonth+9) % 12;
						}


						// シート数分繰返す
					    for (int i = 0; i < 2; i++) {

					    	Sheet sheet = wb.getSheetAt(shnum[i]);
                            tuki=stuki[shnum[i]];

		            		  // 行数分繰返す
						        for (Row row : sheet) {
						           // out.print("<" + row.getRowNum()+"> ");

						            for (Cell cell : row) {
						                String cellValue = null;
						                int cellType = cell.getCellType();

						                switch (cellType) {
						                case Cell.CELL_TYPE_NUMERIC:
						                    double dValue = cell.getNumericCellValue();
						                    cellValue = String.valueOf(dValue);
						                    break;
						                case Cell.CELL_TYPE_STRING:
						                    cellValue = cell.getStringCellValue();
						                    break;
						                default:
						                	 cellValue="";
						                    break;
						                }
						                // セル値の出力
						                //out.print(cellValue+",");
						                gyo=gyo+cellValue.replace(",","、")+",";
						            }
						            //月日がそろっているかチェック	 *************************************

					            	dt=tuki+"/"+gyo;
					            	st=dt.split(",",-1);
					            	st[0]=st[0].replace(".0", "");//  MM/D

					            	hi=st[0].split("/");
					            	if(hi.length>1)	{
					            	 hi[1]="00"+hi[1];//日付がないとエラーになる

					           		 hi[1]=hi[1].substring(hi[1].length()-2,hi[1].length());


					            	  his=hi[1];
					            	}else{
					            	  his="00";
					            	}


						            if (tuki.matches("[0-9][0-9]") && his.matches("[0-9][0-9]") && !(his.equals("00"))){ //月のシートで日付が０でないとき
						            	 //  System.out.println(gatu+"月"+gyo+"<br>");


		                                    if (tuki.matches("[0-9][0-9]")){
	    	                                    if(Integer.parseInt(tuki)<=3 && Integer.parseInt(tuki)>0){
	     	                                      	nen=Integer.toString(konnendo+1);
	     	                                    }else if( Integer.parseInt(tuki)>=4 ){
	                                        		nen=Integer.toString(konnendo);
	                                         	 }else {
	     	                                 	 nen=Integer.toString(konnendo);
	     	                                     }
	                                       }else{
	                                           	nen="0000";
	                                        	tuki="00";
	                                        	his="00";
	                                       }


	                                       //当月が３月で、予定表示したいものが４月の時だけ、次年度の４月を表示させる
	                                      if (fmonth==3 && Integer.parseInt(tuki)==4) nen=Integer.toString(konnendo+1);



							           	st[0]=nen+"/"+tuki+"/"+his; // YYYY/MM/DD に整形

						            	knm=kname.split(",");

						              if((st[0].compareTo(sfdate)>=0) && (st[0].compareTo(sfdate2)<=0) && (pst.compareTo(st[0])<0)){
						            	  //pst前の日付よりCurrentの日付が大きくなっていないと表示しないようにした
						            	  pst=st[0];
						            	 //out.print(gatu+gyo+"<br>");
						            	  gyo="";

							            	for (int j=0;j<st.length;j++){
							            		if (st[j].equals("") || knm[j].equals("") || sfiltermoji.indexOf(knm[j])!=-1){}else{
							            			//out.println(st[j]+"<br>");
							            			//out.println(sfiltermoji+" "+knm[j]+"<br>");
							 	            		gyo=gyo+"<span style=font-size:80%;>"+knm[j]+st[j]+"</span><br>";
							 	            		gyo=gyo.replaceAll("\n","<br>");
							            		}//if owari
							            	}// for owari


							            	if(st[1].length()<1){
							            		//曜日が取得できないときは、ここで計算
							            		today.add(Calendar.DATE, 1);
							            		int dayOfWeek = today.get(Calendar.DAY_OF_WEEK);
							            		st[1]=w[dayOfWeek-1];
							            	}
							            	 nichi=nichi+1;


							                switch(nichi){
							                    case 1:
						                		    mae="";ato="\t";

						                		    break;
							                	case 2:
							                		mae="<b>明日　　";ato="";
							                		gyo=st[0].substring(st[0].length()-5,st[0].length())+"("+st[1]+")</b><br>"+gyo;
							                		break;
							                	case 3:
							                		mae="<b>明後日　";ato="";
							                		gyo=st[0].substring(st[0].length()-5,st[0].length())+"("+st[1]+")</b><br>"+gyo;
							                		break;
							                	default:
							                    	mae="<b>"+HtoZ(Integer.toString(nichi-1))+"日後　";ato="";
							                    	gyo=st[0].substring(st[0].length()-5,st[0].length())+"("+st[1]+")</b><br>"+gyo;
							                    	break;
							                }

							            	out.print("<tt>"+mae+gyo+"<br>"+ato+"</tt>");//kaigyo
							            	Cache=Cache+"<tt>"+mae+gyo+"<br>"+ato+"</tt>";//ここで、高速化のためのキャッシュ作成

						              }// if owari hiduke kakunin
						            } //1gyo owari
						            gyo="";
		            	       }// 1sheet owari


					    }// all sheet owari


						//-------------------------------------------------------
						ServletContext scc = getServletContext();
					    scc.setAttribute("cache", Cache);
					    String pptime="";
					    pptime=Integer.toString(cmin);//hhmm形式の時刻記録
					    scc.setAttribute("time",pptime);
					}



			       inp.close();

		}else{
			 //System.out.println(path3+":見つかりません！");
			 out.print("<tt>*****</tt>\t<tt>予定表示のためには["+tmp3+"]のファイルが必要です</tt>");
		}


	} catch (Exception e) {
		//System.out.println("エラー！予定ファイルの項目の設定は、実際のファイルと対応していますか？");
		out.print("<tt>読み取りエラー。"+e.getMessage()+"</tt>");

		//e.printStackTrace();
	}


  }
}