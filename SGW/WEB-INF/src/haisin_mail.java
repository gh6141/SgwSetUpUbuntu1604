
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/haisin_mail")
public class haisin_mail extends HttpServlet {
	private static final long serialVersionUID = 1L;






		public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("utf-8");
			//PrintWriter out = response.getWriter();

//yomikomi*************************************************************

			String path6 = getServletContext().getRealPath("/WEB-INF/smtp.txt");
			String path7 = getServletContext().getRealPath("/WEB-INF/port.txt");


			String str6 = null;String str7 = null;

			String smtp=null;
			String port=null;




			BufferedReader in6=new BufferedReader(new FileReader(path6));
			while((str6=in6.readLine())!=null) {
				//out.print(str6);
				smtp=str6;
			}
			in6.close();

			BufferedReader in7=new BufferedReader(new FileReader(path7));
			while((str7=in7.readLine())!=null) {
				//out.print(str6);
				port=str7;
			}
			in7.close();

//********************************************
			//  System.out.println("0.1");

			try	{

				//以下はcc、bccを使用する場合の変数
				//String to[]=null;
				///String cc[]=null;//  = null;//CCあて先
				//String  bcc[]=null;// = null;//BCCあて先

			//request.setCharacterEncoding("JISAutoDetect");
			String to[] = request.getParameterValues("to[]");//あて先
			String cc[] = request.getParameterValues("cc[]");//あて先
			String bcc[] = request.getParameterValues("bcc[]");//あて先
			String subject = request.getParameter("subject");//題名
			String sendMsg = request.getParameter("honbun");//本文
			String hname = request.getParameter("name");

			//String filename[] = request.getParameterValues("tenpu[]");

//*********修正*********************************************************************************************************
			//String[] bcc = {"gh6141@gmail.com"};  //ここで、bccをDBを参照して作成する...
			//String subject = "テストtest";//題名
			//String sendMsg ="テスト";//本文

//**********修正**************************************************************************************************
			//String tenpu = request.getParameter("tenpu");
			//tenpuをもとに、filename[]を作成する。。。
			String filename[]=request.getParameterValues("tenpu[]");


			//String[] filename = {"\\\\192.168.1.1\\HomeICT\\1620_P2280007.JPG"};


			//アドレスなどの設定

			String  smtphost = smtp;//SMTPサーバーURL
			String  personal = "SGW配信メール";//送信元（受信側メーラーで表示される文字）


			//String  mailer = "My Java mailer";//メーラー名（何でもお好きに）
			//SMTPホストの設定
			Properties props = System.getProperties();
			props.put("mail.smtp.host", smtphost);

			if(port!=null){
				props.setProperty("mail.smtp.port", port);
			}

			 // System.out.println("0.2");

			 //sosin_passチェック
			  String pathx = getServletContext().getRealPath("/WEB-INF/sosin_pass.txt");
				BufferedReader inx=new BufferedReader(new FileReader(pathx));
				String strx = null;String sosin_passx=null;
				while((strx=inx.readLine())!=null) {
					//out.print(str6);
					sosin_passx=strx;
				}
				inx.close();


				MimeMessage msg;

			if(sosin_passx!=null){
			//送信の認証が必要なとき
		    	props.setProperty("mail.smtp.auth", "true");

		    	// System.out.println("0.23ninsho");

		   	  class myAuth extends Authenticator {

		   	      protected PasswordAuthentication getPasswordAuthentication(){
		   	    	String path5 = getServletContext().getRealPath("/WEB-INF/sosin_ad.txt");
		   	    	String str5 = null;String sosin_ad=null;
		   	    	String path8 = getServletContext().getRealPath("/WEB-INF/sosin_pass.txt");
					BufferedReader in8;
		   	    	BufferedReader in5;

					try {
						in5 = new BufferedReader(new FileReader(path5));
						while((str5=in5.readLine())!=null) {
							//out.print(str5);
							sosin_ad=str5;
						}
						in5.close();

						in8 = new BufferedReader(new FileReader(path8));
						String str8 = null;String sosin_pass=null;
						while((str8=in8.readLine())!=null) {
							//out.print(str6);
							sosin_pass=str8;
						}
						in8.close();
						return new PasswordAuthentication(sosin_ad,sosin_pass);
					} catch (FileNotFoundException e) {
						// TODO 自動生成された catch ブロック
						e.printStackTrace();
						System.out.println("err4:"+e.getMessage());
					} catch (IOException e) {
						// TODO 自動生成された catch ブロック
						e.printStackTrace();
						System.out.println("err5:"+e.getMessage());
					}
					return null;

		   	      }
		   	  }

//**********************************************************************************************************************************
				// System.out.println("0.244ninsho");
					Session s = Session.getInstance(props,new myAuth());
				//s = Session.getDefaultInstance(props,null);
					 msg = new MimeMessage(s);




			}else{//smtp 認証なしのとき
			//Sessionオブジェクトの取得
				Session s2 = Session.getInstance(props, null);
				 msg = new MimeMessage(s2);
				// System.out.println("0.245ninshonasi");
			}

			//  System.out.println("0.25");

			//あて先TO、CC、BCCの設定


			//from toridasi
			String pathf = getServletContext().getRealPath("/WEB-INF/sosin_ad.txt");
   	    	String strf = null;String sosin_ad=null;
   	    	BufferedReader inf=new BufferedReader(new FileReader(pathf));
			while((strf=inf.readLine())!=null) {
				//out.print(str5);
				sosin_ad=strf;
			}
			inf.close();

			msg.setFrom(new InternetAddress(sosin_ad,personal));

           if(to!=null){
        	   for (int i=0;i<to.length;i++){
					msg.addRecipient(Message.RecipientType.TO,new InternetAddress(to[i]));
				}
           }
			//cc, bccが設定される可能性がある場合、以下を使用
           if(cc!=null){
        	   for (int i=0;i<cc.length;i++){
					msg.addRecipient(Message.RecipientType.CC,new InternetAddress(cc[i]));
				}
           }
           if(bcc!=null){
        	   for (int i=0;i<bcc.length;i++){
					msg.addRecipient(Message.RecipientType.BCC,new InternetAddress(bcc[i]));
					//System.out.println(bcc[i]);
				}
           }

           //System.out.println("0.26");
			//その他の設定
 		//srcはメール本文
 		 //String subj = new String(subject.getBytes("MS932"),"Shift_JIS");

			msg.setSubject(subject+" 投稿者："+hname);//SUBJECTの設定
			//msg.setHeader("X-Mailer", "javamail");//メーラーの設定
			msg.setSentDate(new Date());//日付の設定
			//msg.setText(sendMsg);//本文の設定
			//送信＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
			  msg.setSubject(subject);



		      /* 添付ファイルの処理 */
		      MimeBodyPart mbp1 = new MimeBodyPart();

             //**********************************************************************************************************************
		      // String sendM = new String(sendMsg.getBytes("MS932"),"Shift_JIS");
		      //mbp1.setText(sendM, "text/html;charset=iso-2022-jp");
		       mbp1.setText(sendMsg,"iso-2022-jp");



		      Multipart mp = new MimeMultipart();
		      mp.addBodyPart(mbp1);

		      MimeBodyPart mbp2;
		      FileDataSource fds;

		   //   System.out.println("filename[0]"+filename[0]);


		      if(filename[0].length()!=0){
		    	  for (int i=0;i<filename.length;i++){
		    		  filename[i].replace("　","");
			    	  fds= new FileDataSource(filename[i]);
				      mbp2= new MimeBodyPart();
				      mbp2.setDataHandler(new DataHandler(fds));
				      mbp2.setFileName(MimeUtility.encodeWord(fds.getName()));
				      mp.addBodyPart(mbp2);
				     // System.out.println("file:"+filename[i]);
			      }
		      }
		     // System.out.println("0.27配信メール準備完了");

		      msg.setContent(mp);

		   //   System.out.println("0.29mpSet完了");

		     // msg.setHeader("Content-Transfer-Encoding", "7bit");
		      Transport.send(msg);

	         // out.println("送信しました。");
	         // System.out.println("配信メール送信OK");
	        //  System.out.println(sendMsg+subject);

			} catch(Exception e) {
				//System.out.println("配信メール(mail delivery) Error:"+e.getMessage());
			}

	}

}
