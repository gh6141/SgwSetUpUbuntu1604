import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ファイルダウンロードServlet
 */
public class FileDownloadServlet extends HttpServlet {

    /**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/*
     * (non-Javadoc)
     *
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
     *          javax.servlet.http.HttpServletResponse)
     */
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
          String path = req.getParameter("filename");
       // System.out.println(path);
       //   path=new String(path.getBytes("ISO-8859-1"));
        File fileOut = new File(path);    //出力ファイルのフルパス

        //ここで、Windowsの場合　/kyoyu8/をカレントドライブの:\kyoyu8\などに変更する。


        printOutFile(req, res, fileOut);

    }

    /*
     * (non-Javadoc)
     *
     * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest,
     *          javax.servlet.http.HttpServletResponse)
     */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }

    protected void printOutFile(HttpServletRequest req,
            HttpServletResponse res,
            File fileOut)
            throws ServletException, IOException {
        OutputStream os = res.getOutputStream();

        String errorline="line 65(fileOut.getPath)";

        try {

        	String fg=fileOut.getPath();
        	errorline="line 67(FileInputStream) fileOut.getPath()="+fg;
			FileInputStream hFile = new FileInputStream(fg);
			errorline="line 69( BufferedInputStream)";
            BufferedInputStream bis = new BufferedInputStream(hFile);

           // PrintWriter out = res.getWriter();
            //out.println("file="+ fileOut.getName());
          //  printmsg(res,fileOut.getName());
            //レスポンス設定
            errorline="line 73(res.setContentType)";
           res.setContentType("application/octet-stream");
          //  res.setContentType("application/octet-stream;charset=UTF-8");
          //res.setHeader("Content-Disposition", "filename=\"" + fileOut.getName() + "\"");
          //  res.setCharacterEncoding("UTF-8");
           // res.setHeader("Content-Disposition", "filename=\"" +fileOut.getName().getBytes("ISO-8859-1")  + "\"");
           errorline="line 79: (req.getHeader,,,)";
            if (req.getHeader("User-Agent").indexOf("MSIE") == -1 & req.getHeader("User-Agent").indexOf("Trident") == -1) {
            	  // Firefox, Opera 11
            	errorline="line 82(setHeader for chrome or firefox )";
            	  res.setHeader("Content-Disposition", String.format(Locale.JAPAN, "attachment; filename*=utf-8'jp'%s", URLEncoder.encode(fileOut.getName(), "utf-8").replace("+", "%20")));
           } else {
            	  // IE7, 8, 9
        	   errorline="line 86(setHeader for Internet Explorer )";
            	 res.setHeader("Content-Disposition", String.format(Locale.JAPAN, "attachment; filename=\"%s\"", new String(fileOut.getName().getBytes("MS932"), "ISO8859_1")));
            	//  res.setCharacterEncoding("UTF-8");
               //  res.setHeader("Content-Disposition", "filename=\"" +fileOut.getName().getBytes("ISO-8859-1")  + "\"");
//System.out.println(fileOut.getName());
           }


            int len = 0;
            byte[] buffer = new byte[1024*10];
            //byte[] buffer = new byte[4096];

            errorline="line 93:os.write(buffer,,,,)";

            while ((len = bis.read(buffer)) >= 0) {
                os.write(buffer,0, len);
            }

            bis.close();
        } catch (IOException e) {
            printOutNotFound(res,errorline);
        } finally {

            if (os != null) {
                try {
                    os.close();
                } catch (IOException e) {

                } finally {
                    os = null;
                }
            }
        }
    }

    private void printOutNotFound(HttpServletResponse res,String msg) {

        try {
            OutputStream toClient = res.getOutputStream();
            res.setContentType("text/html;charset=utf-8");
            toClient.write(("Download Error in "+msg+" of FileDownload.java").getBytes());
            toClient.close();
        } catch (IOException e) {
            // do nothing
        }
    }

   // private void printmsg(HttpServletResponse res,String msg) {

   //     try {
   //         OutputStream toClient = res.getOutputStream();
   //         res.setContentType("text/html;charset=utf-8");
   //         toClient.write(msg.getBytes());
   //         toClient.close();
   //     } catch (IOException e) {
            // do nothing
    //    }
   // }


}
