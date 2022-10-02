
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

//@WebServlet("/fileupload")
public class fileupload extends HttpServlet {
	private static final long serialVersionUID = 1L;




	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String patht = getServletContext().getRealPath("/WEB-INF/opath.txt");
		String pathHtml = getServletContext().getRealPath("/WEB-INF/opath2.txt");

		String str2 = "";String stmp="";
		BufferedReader in2=new BufferedReader(new FileReader(patht));
		while((str2=in2.readLine())!=null) {
			//out.println(str2);
			stmp=stmp.trim()+str2.trim();
		}
		in2.close();
		String path =stmp.trim() ;

		String str3 = "";String stmp3="";
		BufferedReader in3=new BufferedReader(new FileReader(pathHtml));
		while((str3=in3.readLine())!=null) {
			//out.println(str2);
			stmp3=stmp3.trim()+str3.trim();
		}
		in3.close();
		String pathH =stmp3.trim() ;
		//System.out.println(pathH+"<h  >"+path);


		//pathに上書き
		ServletContext sc = getServletContext();

			path = (String)sc.getInitParameter("master_tenpu");

		if(path==null){
			 System.out.println("web.xmlのmaster_tenpuに書き込みようのtenpuのパスを正しく記載してください");
		}


		//dirないとき作成
		File dirs = new File(path+"tmp");
		if (!dirs.exists()) {
		    dirs.mkdir();    //make folders
		}



		 FileItemFactory factory = new DiskFileItemFactory();
	     ServletFileUpload upload = new ServletFileUpload(factory);



	 	try	{

	     Iterator<FileItem> iterator = upload.parseRequest(request).iterator();


	     HashMap<String,String> map = new HashMap<String,String>();

	     String filename="";

	     while (iterator.hasNext()) {

	                    FileItem item = iterator.next();
	                    if (!item.isFormField()) {
	                    	//System.out.println("pathカット前＝"+item.getName());

	                    	final char UNIX_SEPARATOR = '/';
	                    	final char WINDOWS_SEPARATOR = '\\';
	                    	//String path = "C:\\test\\aaa.txt";
	                    	final int lastUnixPos = item.getName().lastIndexOf(UNIX_SEPARATOR);
	                    	final int lastWindowsPos = item.getName().lastIndexOf(WINDOWS_SEPARATOR);
	                    	int point = Math.max(lastUnixPos, lastWindowsPos);
	                    	filename=item.getName().substring(point + 1);

	                       // filename=  new File(item.getName()).getName();
	                       //System.out.println("pathカット後＝"+filename);

	                        item.write(new File(path+"tmp/" + filename));
	                    }
	                    else {
	                      String otherFieldName = item.getFieldName();
	                      String otherFieldValue = item.getString();
	                      map.put(otherFieldName ,otherFieldValue);
	                    }
	               }


		String flg=map.get("flg");


		//System.out.println("flg="+flg);


							String fn= filename.trim();//tomcatのルートディレクトリに保存→でなく、添付ファイルフォルダのtmpフォルダに保存　に変更






	//******************************************************tuika
							String fno= fn;
							String fno2,forg,fext,fnam,suji;		fno2=fno;
							String fnd=path + filename.trim();

							//同一ファイル名がないかチェック　あったら順次(1)、（２）をつけていく
							File file = new File(fnd);
						//	String[] fna;
							String[] tmpf;

							//out.println(fno);
							//fna=fno.split("\\.");//javaでは正規表現で.は特別な意味あるので\\つける >これだと、ファイル名に.があるとうまくいかない

							//forg=fna[0];//最初のファイル名（拡張子なし） >これだと、ファイル名に.があるとうまくいかない
							forg=getPreffix(fno);
							//out.println(fna[0]);
							//out.println(fna[1]);
							//fext=fna[1];//拡張子  これだと、ファイル名に.があるとうまくいかない
							fext=getSuffix(fno);
							//out.println(fext);
							fnam="";
							while(file.exists()){

								fnam=getPreffix(fno2);
								if(fnam.matches(".*\\(\\d+\\)")){
									tmpf=fnam.split("\\(");
									suji=tmpf[tmpf.length-1].replace(")","");
									suji=Integer.toString(Integer.parseInt(suji)+1);
									fnam=forg+"("+suji+")";
								}else{
									fnam=forg+"(1)";
								}


								fno2=fnam+"."+fext;
								fnd=path +fno2;
								file = new File(fnd);
							}


							//ここで、親ディレクトリから、本来のところへ移動

							File f1 = new File(path+"tmp/"+fno);//添付ファイルフォルダのtmpフォルダに保存　に変更
							    File f2 = new File(fnd);

							    FileUtils.moveFile(f1, f2);

							out.print(fno2);

							//System.out.println(flg);
							//*************************************************************************
							//画像圧縮
							if(flg!=null){
								if(flg.equals("oimg")||flg.equals("kimg")){
									//System.out.println("l206 2");

									    String filnamePath=path+flg.trim()+"/"+map.get("userID2")+"_"+fno2;
									    String filnamePathH=pathH+flg.trim()+"/"+map.get("userID2")+"_"+fno2;
									 //System.out.println(filnamePath+" 0 "+filnamePathH);
									    File f3=new File(filnamePath);

									   // System.out.println(filnamePath+" 1 "+filnamePathH);
									    f3.delete();
									  // System.out.println("f2abs="+f2.getAbsolutePath()+" f3.abs="+ f3.getAbsolutePath()+" height="+map.get("height"));

									createThumbnail(f2.getAbsolutePath(), f3.getAbsolutePath(), Integer.parseInt(map.get("height")));
									//  System.out.println(filnamePath+" 3 "+filnamePathH);
									out.print("\n"+filnamePathH);
								}
							}






		} catch (Exception e)	{
			System.out.println("添付ファイルのアップロードがうまくきませんでした。"+e.getMessage());
			//e.printStackTrace(out);
		}




		out.close();
	}

	/**
	 * ファイル名から拡張子を返します。
	 * @param fileName ファイル名
	 * @return ファイルの拡張子
	 */
	public static String getSuffix(String fileName) {
	    if (fileName == null)
	        return null;
	    int point = fileName.lastIndexOf(".");
	    if (point != -1) {
	        return fileName.substring(point + 1);
	    }
	    return fileName;
	}

	/**
	 * ファイル名から拡張子を取り除いた名前を返します。
	 * @param fileName ファイル名
	 * @return ファイル名
	 */
	public static String getPreffix(String fileName) {
	    if (fileName == null)
	        return null;
	    int point = fileName.lastIndexOf(".");
	    if (point != -1) {
	        return fileName.substring(0, point);
	    }
	    return fileName;
	}


	private void createThumbnail(String originFile, String thumbFile, int height) {
		try {
			// 元画像の読み込み
			BufferedImage image = ImageIO.read(new File(originFile));
			// 元画像の情報を取得
			int originWidth = image.getWidth();
			int originHeight = image.getHeight();
			int type = image.getType();
			// 縮小画像の高さを計算
			//int height = originHeight * width / originWidth;
			int width = originWidth * height / originHeight;

			//縮小画像の作成
			BufferedImage smallImage = new BufferedImage(width, height, type);
			Graphics2D g2 = smallImage.createGraphics();

			// 描画アルゴリズムの設定(品質優先、アンチエイリアスON)
			g2.setRenderingHint(RenderingHints.KEY_RENDERING,  RenderingHints.VALUE_RENDER_DEFAULT);
			g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,  RenderingHints.VALUE_ANTIALIAS_ON);

			// 元画像の縮小&保存
			g2.drawImage(image, 0, 0, width, height, null);
			ImageIO.write(smallImage, "jpeg", new File(thumbFile));
		} catch (Exception e) {
			log("画像の縮小に失敗: " + e);
		}
	}


}
