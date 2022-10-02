<%@ page pageEncoding="utf-8" %>

	  function onDrop(event) {

		   event.preventDefault();

	    // （1）ドロップされたファイルのfilesプロパティを参照
	    var files = event.dataTransfer.files;


		 $(".wait").replaceWith("<label for='tenpu' class='wait'>添付<font color='red'>>>しばらくそのままお待ちください...</font></label>");

	    for (var i = 0; i < files.length; i++) {
	      var f = files[i];
	    //  tuikao=jQuery.trim($('#opath').val())+jQuery.trim(f);
			//  tuikad=jQuery.trim(f);
	      // （2）ファイル名とサイズを表示
	     // disp.innerHTML += f.name;
			  var fd = new FormData();
		        fd.append('file', files[i]);
		        if (i==files.length-1) {
		        	last='true';
		        }else{
		        	last='false';
		        }
		        sendFileToServer(fd,event.currentTarget.id,last,files[i]);
	    }

	    // （3）ブラウザ上でファイルを展開する挙動を抑止

	  }

	  function onDragOver(event) {
	    // （4）ブラウザ上でファイルを展開する挙動を抑止
		   event.preventDefault();
	  }

	  function sendFileToServer(formData,ct,last,file)
	  {

		// file=formData.get('file');
		 fext=file.name.split('.')[1];



	     if(  (fext=='jpg'||fext=='JPG') && ( $("#img_gazo").prop('checked')&& ct=='dialog-form' ||  $("#img_gazo2").prop('checked')&& ct=='dialog-form_henko') ){
	      	 <%

	  	     String imgFileName3=format_yyyyMMddHHmmss.format(calimg.getTime());
	  		%>

	  		formData.append('flg','kimg');
	  		formData.append('userID2',<%=imgFileName3 %>);
	  		if(ct=='dialog-form'){
	  			formData.append('height',$('#height1').val());
	  		}else{
	  			formData.append('height',$('#height2').val());
	  		}
	  		//****************************************
	  		//alert("jpg de dousa ");
	     }else{
	    	 formData.append('flg','');
	     }



	      var uploadURL ="fileupload"; //Upload URL
	      var extraData ={}; //Extra Data.
	      $.ajax({
	          url: uploadURL,
	          type: "POST",
	          contentType:false,
	          processData: false,
	          cache: false,
	          data: formData,
	          error: function(xhr, error) {
	        	    console.log('uploadに失敗しました');
	        	    console.log(error);
	        	   },
	          success: function(data){

	            if(data.indexOf('\n') != -1){
	              var stmp=data.split('\n');
         	      if(  (fext=='jpg'||fext=='JPG') &&  $("#img_gazo").prop('checked') && ct=='dialog-form' ){
           	 	       	$("#imgtmp").append("<img src='"+stmp[1].trim()+"' alt='"+stmp[1].trim()+"'>");
         	      }else if( (fext=='jpg'||fext=='JPG') &&  $("#img_gazo2").prop('checked') && ct=='dialog-form_henko' ){
 	                 	$("#imgtmp2").append("<img src='"+stmp[1].trim()+"' alt='"+stmp[1].trim()+"'>");
         	      }
        		  tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+stmp[0].trim();//サーブレットによるダウンロード方式に変更
            	  tuika2="<a href=\""+tuikad2+"\">"+stmp[0].trim()+"</a>";

	            }else{
	                 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+data;//サーブレットによるダウンロード方式に変更
                	 tuika2="<a href=\""+tuikad2+"\">"+data+"</a>";
	            }



    			if (ct=='dialog-form'){
    			 $('#tenpu').val($('#tenpu').val()+'<br>'+tuika2);
    			  $('#tenput').append(tuika2+'　');

    			  //alert(ct);
    			}
    			  else	{
    				 $('#htenpu').val($('#htenpu').val()+'<br>'+tuika2);
	       			 $('#htenput').append(tuika2+'　');
	       			// alert(ct+'2');
    			  }
    		  if(last=='true'){
  				$(".wait").replaceWith("<label for='tenpu' class='wait'>添付<font color='green'>ファイルのアップロード終了！次の操作に移ってもだいじょうぶです</font></label>");
  			  }

	          }
	      });

	      //status.setAbort(jqXHR);
	  }
