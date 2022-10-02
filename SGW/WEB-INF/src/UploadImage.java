import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FileUtils;

@WebServlet("/UploadImage")
// マルチパートデータの設定(保存位置、ファイルサイズの制限)
@MultipartConfig(location = "", maxFileSize = 1024 * 1024 * 10)
public class UploadImage extends HttpServlet {

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// パラメータ"filename"のマルチパートデータ値を取得
		Part part = request.getPart("filename");
		String sosa=request.getParameter("sosa");
		String flg=request.getParameter("flg");



		// HTTPヘッダの値を取得

		//System.out.println("L41 sosa:"+sosa+" flg:"+flg+"  userID2"+request.getParameter("userID2"));
		String contentType = part.getHeader("content-type");
		//System.out.println("contentType:"+contentType);
			String contentDisposition = part.getHeader("content-disposition");
		//System.out.println("contentDispostion:"+contentDisposition);

			// ファイルサイズの取得
			long size = part.getSize();


			//System.out.println("L48 sosa:"+sosa+" flg:"+flg);


		// uploadフォルダの絶対パスを調べる
		//String path = getServletContext().getRealPath("upload");
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


		ServletContext sc = getServletContext();
		//System.out.println(path);
			path = (String)sc.getInitParameter("master_tenpu");
			//System.out.println(path);
		if(path==null){
			 System.out.println("web.xmlのmaster_tenpuに書き込みようのtenpuのパスを正しく記載してください");
		}


		/* アップロードしたファイル名の取得 */
		// 変数contentDispositionから"filename="以降を抜き出す
		int filenamePosition = contentDisposition.indexOf("filename=");
		String filename = contentDisposition.substring(filenamePosition);
		// "filename="と"を除く
		filename = filename.replace("filename=", "");
		filename = filename.replace("\"", "");
		// 絶対パスからファイル名のみ取り出す
		filename = new File(filename).getName();

		//System.out.println("L93 filename:"+filename);

		//dirないとき作成
		File dirs = new File(path+"mylogo");
		if (!dirs.exists()) {
		    dirs.mkdir();    //make folders
		}
		File dirs2 = new File(path+"oimg");
		if (!dirs2.exists()) {
		    dirs2.mkdir();    //make folders
		}
		File dirs3 = new File(path+"kimg");
		if (!dirs3.exists()) {
		    dirs3.mkdir();    //make folders
		}

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();


		if (sosa.trim().equals("del")){
			 File f3=new File(path+"mylogo/"+request.getParameter("userID2")+".jpg");
			    f3.delete();
			    out.println("削除しました。");


				// 乱数書き込み　　キャッシュ画像のリセットのため

				  FileWriter fnod = new FileWriter(path+"mylogo/rnd.txt");
				  fnod.write(Double.toString(Math.round( Math.random()*10000)).replace(".0",""));
				  fnod.close();

		}else if (sosa.trim().equals("save")){

			if ( size > 10000000 ){
				 out.println("画像サイズが大きすぎて、変換できません。");
			}else{
				boolean isJpegFile = false;
				// JPEG形式のチェック
				if ((contentType.equals("image/jpeg"))
						|| (contentType.equals("image/pjpeg"))) {
					// 画像ファイルをpath+filenameとして保存
					part.write(path +"mylogo/"+  filename);
					isJpegFile = true;

					// サムネール画像の作成
					createThumbnail(path + "mylogo/"+filename, path + "mylogo/small_" + filename, Integer.parseInt(request.getParameter("height")));


					// 乱数書き込み　　キャッシュ画像のリセットのため

					  FileWriter fno = new FileWriter(path+"mylogo/rnd.txt");
					  fno.write(Double.toString(Math.round( Math.random()*10000)).replace(".0",""));
					  fno.close();


				}



				if (isJpegFile) {
					 File f1 = new File(path + "mylogo/small_" + filename);
					    File f2 = new File(path +"mylogo/"+  filename);

					    f2.delete();
					    File f3=new File(path+"mylogo/"+request.getParameter("userID2")+".jpg");
					    f3.delete();

					    FileUtils.moveFile(f1, f3);

					out.println("<br>　　　　<font color='blue'>変更しました。　</font>");
					out.println("　size="+size);
				} else {
					out.println("JPEG形式の画像をアップロードしてください。");
				}
			}




		}else if (sosa.trim().equals("imgsave")){



			if ( size > 10000000 ){
				 out.println("画像サイズは10MB以下にしてください。");
			}else{
				boolean isJpegFile = false;
				// JPEG形式のチェック
				//System.out.println(path +flg.trim()+"/"+  filename);
				if ((contentType.equals("image/jpeg"))
						|| (contentType.equals("image/pjpeg"))) {
					// 画像ファイルをpath+filenameとして保存
					//System.out.println("L186");
					part.write(path +flg.trim()+"/"+  filename);
					//System.out.println("L188");
					isJpegFile = true;

					// サムネール画像の作成
					createThumbnail(path + flg.trim()+"/"+filename, path + flg.trim()+"/small_" + filename, Integer.parseInt(request.getParameter("height")));


				}



				if (isJpegFile) {
					 File f1 = new File(path + flg.trim()+"/small_" + filename);
					    File f2 = new File(path +flg.trim()+"/"+  filename);

					    f2.delete();
					    String filnamePath=path+flg.trim()+"/"+request.getParameter("userID2");
					    String filnamePathH=pathH+flg.trim()+"/"+request.getParameter("userID2");
					    File f3=new File(filnamePath);
					    f3.delete();

					    FileUtils.moveFile(f1, f3);

					//out.println(filnamePath);//書き込みは、PC内のパスでいいが、IE以外はimg表示がうまくいかないのでhttpに
					    out.println(filnamePathH);


				} else {
					out.println("ファイル名が取得できません。JPEG形式の画像かどうか確認ください。");
				}
			}


		}else if (sosa.trim().equals("imgdel")){
			//File f3=new File(path+flg.trim()+"/"+request.getParameter("userID2"));
		   // f3.delete();
		   // out.println("削除しました。");
		}



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