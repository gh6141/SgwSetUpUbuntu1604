<%@ page pageEncoding="utf-8" %>

<input type='hidden' id='opath'>
<input type='hidden' id='opath2'>


<div class="demo">

<div id="dialog-form" title="回覧の作成" ondragover="onDragOver(event)" ondrop="onDrop(event)">
<table>
<tr>
<td>
<form id="myForm" name="myForm" action="UploadImage" method="post" enctype="multipart/form-data">
<input type="file" id="imgfileup1" name="filename" size="10" class="imgfileup" title="Drag&Dropも可" >
<span title="JPEG画像ファイルを添付する前にチェックすると画像も表示可能。"><input type="checkbox" id="img_gazo"  >画像挿入</span><span  id="imgurls">　縦<input type="text" name="height" size=3 value="120" id="height1">に縮小</span>

<input type="hidden" value="" id="flg" name="flg" class="flg">
<input type="hidden" value="imgsave" id="sosa" name="sosa">
<input type="hidden" value="NULL" id="userID2" name="userID2" class="jpgname">
</form>
</td>
<td>
　<button  id="clear" title="添付ファイルを変更したいときは、すべて削除してから再度、操作してください。削除したときは最後に必ず保存をクリックしてください。">添付削除</button>

</td>
</tr>
</table>



	<form>
	<fieldset>
			<label for="tenpu" class="wait">添付ファイル</label>
		<span title="下の「参照」をクリックして、添付したいファイルを探してください。"><table width=102% height=20px class="text ui-widget-content ui-corner-all" ><tr><td name="tenpu"  id="tenput" align=left　></td></tr></table></span>
		<textarea name="tenpu"  rows=1 id="tenpu" value="" class="text ui-widget-content ui-corner-all" style="display:none"></textarea>
	<br>


	<div align="left" title="「下書き」にチェックを入れる（@下書きを挿入する）と、作成者以外には表示されません">
		件名<font size=-1>　　<input type="checkbox" id="sitagaki1" name="sitagaki1" value="sitagaki">下書き</font>
		</div>
		<input type="text" name="kenmei" id="kenmei" value="" class="text ui-widget-content ui-corner-all" />

<%@ include file="shushoku1.jsp" %>

    <p>
        <div id="editArea" style="height:120px;border-style:inset;text-align:left"  class="htmlbox scr ui-widget-content ui-corner-all"  contentEditable="true">
        </div>
    </p>

		<textarea name="naiyo" cols=60 rows=6 id="naiyo" value="" class="text ui-widget-content ui-corner-all" style="display:none;"></textarea>

		<label for="atesaki">宛先</label>
		<input type="hidden" name="atesaki" id="atesaki" value="" />
		<table width=102% height=30px name="atesakitt" id="atesakitt" class="text ui-widget-content ui-corner-all" >
		   <tr><td width=95% height=95% name="atesakit"  id="atesakit" align=left　>
			</td></tr></table>
			<br>
		<label for="name">作成者</label>
		<input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
	<!-- <label for="kikan_s">作成日</label> -->
		<input type="hidden" name="kikan_s" id="kikan_s" value="" class="text ui-widget-content ui-corner-all" />

	</fieldset>
<!--	<span title="この機能はインターネットエクスプローラーでのみ使用可能です"></span>共有へのリンク作成<input type="file" name="link" id="link" class="link"></span>
-->

	</form>

<div id="imgtmp"></div>
	<input type="file" name="file" id="file1" class="fileup" style="display:none;">
</div>

<div id="dialog-form_henko" title="回覧の編集" ondragover="onDragOver(event)" ondrop="onDrop(event)">
<table>
<tr>
<td>
  <form id="myForm2" name="myForm2" action="UploadImage" method="post" enctype="multipart/form-data">
<input type="file" id="imgfileup2" name="filename" size="10" class="imgfileup" title="Drag&Dropも可">
<span title="JPEG画像ファイルを添付する前にチェックすると画像も表示可能。">
<input type="checkbox" id="img_gazo2"  >画像挿入
</span>
<span  id="imgurls2">　縦<input type="text" name="height" size=3 value="120" id="height2">pxに縮小</span>

<input type="hidden" value="" id="flg2" name="flg" class="flg">
<input type="hidden" value="imgsave" id="sosa2" name="sosa">
<input type="hidden" value="NULL" id="userID22" name="userID2" class="jpgname">
</form>
</td>
<td>
　<button id="clear2" title="添付ファイルを変更したいときは、すべて削除してから再度、操作してください。削除したときは最後に必ず変更の保存をクリックしてください。">添付削除</button>

</td>
</tr>
</table>



       <input type='hidden' id='smsg'>

	<form>
	<fieldset>
	<label for="tenpu" class="wait">添付ファイル</label>
		<span title="上の「参照」をクリックして、添付したいファイルを探してください。"><table width=102% height=20px class="text ui-widget-content ui-corner-all" ><tr><td name="tenpu"  id="htenput" align=left></td></tr></table></span>
		<textarea name="tenpu"  rows=1 id="htenpu" value="" class="text ui-widget-content ui-corner-all" style="display:none"></textarea>
 	<input type="hidden" name="number" id="number" class="text ui-widget-content ui-corner-all" />
 	<br>

		<div align="left" title="「下書き」にチェックを入れる（@下書きを挿入する）と、作成者以外には表示されません" >
		件名<font size=-1>　　<input type="checkbox" id="sitagaki2" name="sitagaki2" value="sitagaki">下書き</font>
		</div>
		<input type="text" name="kenmei" id="hkenmei" value="" class="text ui-widget-content ui-corner-all" />
<%@ include file="shushoku2.jsp" %>
    <p>

        <div id="editArea2" style="height:120px;border-style:inset;text-align:left"  class="htmlbox scr ui-widget-content ui-corner-all"  contentEditable="true">

        </div>

    </p>

    <textarea name="naiyo" cols=60 rows=6 id="hnaiyo" value="" class="text ui-widget-content ui-corner-all" style="display:none;"></textarea>

       <label for="kikan">宛先</label>
		<input type="hidden" name="atesaki" id="hatesaki" value="" class="text ui-widget-content ui-corner-all" />
        <table width=102% height=30px class="text ui-widget-content ui-corner-all" >
            <tr><td width=95% height=95% name="atesaki"  id="hatesakit" align=left></td></tr></table>
            <bR>
       	<label for="name">作成者</label>
		<input type="text" name="name" id="hname" class="text ui-widget-content ui-corner-all" />
	<!-- <label for="kikan">作成日</label> -->
		<input type="hidden" name="kikan_s" id="hkikan_s" value="" class="text ui-widget-content ui-corner-all" />
	</fieldset>
	<!-- <span title="この機能はインターネットエクスプローラーでのみ使用可能です"></span>共有へのリンク作成<input type="file" name="link2" id="link2" class="link2"></span>
 -->

	</form>

<div id="imgtmp2"></div>
<input type="file" name="file" id="file2" class="fileup" style="display:none;">


</div>


<!--***************************************************-->
<div id="dialog-form_atesaki" title="宛先の選択">
<table>
<tr><td>右欄に表示したいグループ</td><td>送付先を選択</td></tr>
<tr>
<td>
<div class="ScrollBox" id="group"  style="padding:10px;"　 title="グループ名を選択すると、メンバーが右欄に現れます。">
　<input type="radio" name="radio" class='radioｚ' id='radioall' checked >「全職員」の表示<br><br>
</div>
</td>

<td>
<div class="ScrollBox" id="alist"  style="padding:10px;"　 title="「全員」をクリックすると、下に現れているメンバー全員にチェックが入ります。もう一度クリックすると、全員のチェックがはずれます。送付したい人のチェックを確認したら、「適用」をクリックしてください。">
　<input type="checkbox" id="checkall"><div id="chall" style="display:inline;"　>「全員」を選択</div><br><br>
</div>
</td>
</tr>
</table>
</div>
<!--****************************************************-->



<script>
//rich text
//innerText をサポートしない Web ブラウザと共通で使用するための
 //setText 関数を定義
 function setAlter_innerText(element) {
     if (element.innerText) {
         element.setText = function (text) { element.innerText = text; }
     } else {
         element.setText = function (text) { element.textContent = text; }
     }
     return element;
 }

 //getElementById の短縮
 var $id = function (id) { return document.getElementById(id); };

 //コンテンツのロードが完了したら
 window.onload = function () {
//********************* reply kanren**********************************************
	 $( "#name" ).val('<%=userN%>');
		$( "#kikan_s" ).val('<%=datestr_s%> <%=format3.format(cal.getTime())%>');
		//tstop(tid);
			$("#atesakit").text('<%=ratesakit%>');
			$("#atesaki").val('<%=ratesaki%>');
			$("#kenmei").val('<%=rkenmei%>');
$("#editArea").html('<%=rmsg%>');

	 //************editArea kanren
     <%@ include file="shushoku.jsp" %>


 }



//*********************************************************************************************************
//**********************************************************************
var tid=null;
tid=setTimeout("location.reload()",1000*60*60);//60minおきリロード　ただし入力画面ではリロードしない ????

function tstop(timeout_id){
	if(timeout_id !== null){

		// setTimeout() メソッドの動作をキャンセルする
		clearTimeout(timeout_id);

		timeout_id = null;
	}
}

function tstart(tid){
	tid=null;
	tid=setTimeout("location.reload()",1000*60*60);

}
//******************************************************



	$(function() {

		$('.flg').val('kimg');//お知らせoimgか回覧kimgか　imgsaveのためのフラグ（画像挿入 UploadImage関連）


//*************************************宛先　選択ダイアログの　グループ　職員読み込み
		<%
		ResultSet rs4 = stmt4.executeQuery("SELECT * FROM groupname");
		while(rs4.next()){ %>
		    $("<input type='hidden' id='hra<%=rs4.getString("id")%>' value='<%=rs4.getString("member")%>'><input type='radio' name='radio' class='radio' id='ra<%=rs4.getString("id")%>'>「<%=rs4.getString("name")%>」を表示<br>").appendTo("#group");
		<% }
		rs4.close();
		stmt4.close();
		%>

		<%
		ResultSet rs3 = stmt3.executeQuery("SELECT * FROM shokuin order by sid");
		Integer ic=0;
		while(rs3.next()){ %>
 		   $("<div id='ch<%=ic%>'><input type='hidden' id='revhd<%=rs3.getString("id")%>' value='<%=ic%>'><input type='hidden' id='hd<%=ic%>' value='<%=rs3.getString("id")%>'><input type='checkbox' class='checkbox' id='cb<%=ic%>'><span id='snm<%=ic%>'><%=rs3.getString("name")%></span><br></div>").appendTo("#alist");
 		   $('#user_srch').append($('<option>').html('<%=rs3.getString("name")%>').val('<%=rs3.getString("user")%>'));

		<% ic=ic+1;}
		Integer imax=ic;
		rs3.close();
		stmt3.close();
		%>

//宛先　選択　操作********************************************************************
//グループメンバ取り出す関数
		function gmen(gnum){
	//	alert($('#hra'+gnum).val());
			var tmp=$('#hra'+gnum).val().split(',');
		return tmp;
		}


//全員チェックの選択・非選択　操作
	$('#checkall').change(function() {
	   if(this.checked){
	      for (i = 0; i < <%=imax%>; i = i +1){
	        if(    $('#ch'+String(i)).is(':hidden')   ){

	         } //表示されているチェック欄だけ　すべてチェック入れる
	         else{
	           $('#cb'+String(i)).attr('checked','checked');
	         }
	       }
	　　　}else{

	　　　　　for (i = 0; i < <%=imax%>; i = i +1){
	        if( $('#ch'+String(i)).is(':hidden')  ){

	        } //表示されているチェック欄だけ　すべてチェックはずす
	        else{
	         $('#cb'+String(i)).removeAttr('checked');
	        }

	      }
	    }
    });


//グループの選択

	$('#radioall').change(function() {

	   if(this.checked){
	   $('#checkall').removeAttr('checked');
		$('#chall').replaceWith('<div id=chall style=display:inline;>「全員」を選択</div>');
	       for (i = 0; i < <%=imax%>; i = i +1){
		   $('#ch'+String(i)).attr('style','display:inline');
		    //  $('#ch'+String(i)).show();

	       }
      }else{

      }

    });

	 $('.radio').change(function(e) {
	 //全員選択　という表示を変更
      $('#chall').replaceWith('<div id=chall style=display:inline; >グループ「全員」を選択</div>');
	 $('#checkall').removeAttr('checked');

	     var tmp=gmen(e.target.id.replace('ra',''));//メンバーの配列(ID)
	    // var xp=0;
           for (i = 0; i < <%=imax%>; i = i +1){
               $('#ch'+String(i)).attr('style','display:none');
           }
             // $('#ch'+String(i)).hide();
              for (x = 0; x < tmp.length; x = x +1) {
               //  alert(tmp[x]+'*'+$('#revhd'+tmp[x]).val()+'=='+String(i)+'*');
                for (i = 0; i < <%=imax%>; i = i +1){//メンバー一人ずつ、表示していく
           		  if($('#revhd'+tmp[x]).val()==String(i)){
            		   $('#ch'+String(i)).attr('style','display:inline');
            		   //$('#ch'+String(i)).show();
            	//	   xp=x;
           		  }else{
           		  }
                }
		      }

    });

	 //***************************************page*********************************************************************************************

	 $('#pages').change(function(){
         //alert($('#pages').val());

       $('#form1').submit();

     });


	    $('#kensaku_form').css("display","none");

	      $('#kensaku_bot').click(function() {
	    	  $('#kensaku_bot_kenmei').css("display","none");
	    	  $('#kensaku_form').toggle();
	         });




	 $('#linkurls').css("display","none");
     $('#link_gazo').click(function() {
   	  $('#link_gazo').css("display","none");
          $('#linkurls').toggle();
        });

     $('#get').click(function() {
   	  $('#link_gazo').css("display","block");
          $('#linkurls').toggle();
        });

     $('#linkurls2').css("display","none");
     $('#link_gazo2').click(function() {
   	  $('#link_gazo2').css("display","none");
          $('#linkurls2').toggle();
        });
     $('#get2').click(function() {
   	  $('#link_gazo2').css("display","block");
          $('#linkurls2').toggle();
        });



     $('#submitBtn').click(function() {
   	  //$('#img_gazo').css("display","block");
         // $('#imgurls').toggle();
        });



     $('#submitBtn2').click(function() {
   	 // $('#img_gazo2').css("display","block");
         // $('#imgurls2').toggle();
        });


     $('#imgurls').css("visibility","hidden");
     $('#img_gazo').change(function() {
   	   if($("#img_gazo").prop('checked')){
   		   $('#imgurls').css("visibility","visible");
   	   }else{
   		   $('#imgurls').css("visibility","hidden");
   	   }

        });

     $('#imgurls2').css("visibility","hidden");
     $('#img_gazo2').change(function() {
   	   if($("#img_gazo2").prop('checked')){
   		   $('#imgurls2').css("visibility","visible");
   	   }else{
   		   $('#imgurls2').css("visibility","hidden");
   	   }

        });







//*************************初期の設定**********************************************************************************************************************************************

	　　　　$.post(
								'sette_p',
								{
	                              'flg':'yomi'
	                            },
	                            function(data){
	                              var st=data;
                                   var dt=st.split('\t');

	                               $('#opath').val(dt[0]);
	                                $('#opath2').val(dt[1]);
	        });



		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );

		var name = $( "#name" ),
			kikan_s = $( "#kikan_s" ),
			atesaki = $( "#atesaki" ),
			kenmei = $( "#kenmei" ),
			naiyo = $("#naiyo"),
			tenpu =$("#tenpu"),
			allFields = $( [] ).add( name ).add( kikan_s ).add( atesaki ).add( kenmei ).add(naiyo).add(tenpu),
			tips = $( ".validateTips" );




//************function***************
		function updateTips( t ) {
			tips
				.text( t )
				.addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}

		function checkLength(o, n, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {

				if (atesaki.val().length<1) {alert("宛先を入力してください");}
				else {o.addClass("ui-state-error"); }

				updateTips(  n + "の文字数は " +min + " ～ " + max + "の範囲にしてください" );
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp( o, regexp, n ) {
			if ( !( regexp.test( o.val() ) ) ) {
				o.addClass( "ui-state-error" );
				updateTips( n );
				return false;
			} else {
				return true;
			}
		}


		function henkan(moji){
							moji = moji.replace(/\r\n/g, "<br>");
							moji = moji.replace(/(\n|\r)/g, "<br>");
		return moji;
		}




		//*************************************メール配信関数
		function mailhaisin(atesaki,ssbccN,ssbcc,tenpuval,sname,skenmei,snaiyo,flg){
		  //宛先準備
				//atesakiにある番号だけにメール　その番号はssbccN（職員ID）でチェック　ssbccNとssbcc(実際のアドレス）は、同じ順序で並んでいる

					 var sbcc=ssbcc.split(',');
					 for (i=0;i<sbcc.length;i++){
					 sbcc[i]=sbcc[i].replace(/^\s+/, "");//trim mailadress
					 }

					 var sbccN=ssbccN.split(',');//id number
					 var ates=atesaki.split(',');//kairan atesaki

					 var newBcc="";
					 for(i=0;i<ates.length;i++){
					   for(j=0;j<sbccN.length;j++){
					     if(ates[i]==sbccN[j]){
					       newBcc=newBcc+","+sbcc[j];
					      }
					   }
					 }

					 newBcc=newBcc.replace(',','');

					 var HnewBcc=newBcc.split(',');

					//添付ファイル配列準備
					//alert(tenpuval)
					 var sstnp=tenpuval.replace('<N>','').replace('/a>　<a','/a>,<a').replace('/a><a','/a>,<a').replace('/a>　<br><a','/a>,<a').replace(/<.+?>/g,'');// *,*,*

					 var stnp=sstnp.split(',')
					 if(tenpuval!="<N>"){
					  for (i=0;i<stnp.length;i++){
					  stnp[i]=$('#opath').val()+stnp[i].replace(/^[\s　]+|[\s　]+$/g, "");//trim
					  }
					 }
					 else{

					 }

						 $.post(
								'haisin_mail',
								{
								  'name': sname,
	                             'subject':flg+skenmei+"("+sname+")",
	                              'honbun': snaiyo,
	                              'tenpu[]':stnp,//hairetu
	                              'bcc[]':HnewBcc//hairetu
	                            },
	                            function(data){
	                              //alert(data);

	                             }
						 );




		}



//*********************************新規　dialog	入力すべて終わって　POST後　最初の画面にもどる

		$( "#dialog-form" ).dialog({
			autoOpen: <%=openflg%>,
			height: 580,
			width: 700,
			modal: true,
			buttons: {
				"保存": function() {



					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkLength( name, "作成者", 0, 20 );
					bValid = bValid && checkLength( kikan_s, "作成日", 0, 25 );
					bValid = bValid && checkLength( kenmei, "件名", 1, 50 );
					//bValid = bValid && checkLength( naiyo, "内容", 1, 600 );
					bValid = bValid && checkLength( atesaki, "宛先番号", 1, 300 );

					if(bValid){
						//ここでまとめて　複数IMG挿入
						$("#editArea").html($("#editArea").html()+"\n"+$("#imgtmp").html());
					}


					try{
						ritchTextHtmlArea.setText(editArea.innerHTML);
					}

					catch(e){
						alert("エラーです。互換表示を解除してますか？解除後、再度、「回覧」をクリックして再試行してみてください。");

					}




                  if(tenpu.val().length>0){
                  }else{
                  tenpu.val('<N>');
                  }



					if ( bValid && naiyo.val().replace("<p>","").replace("</p>","").trim().replace("<br>","").length>0) {




					//***************メール配信

				<%	String col1="haisin_ad";//転送希望

                     Statement stmt7 = conn.createStatement();
			  		 ResultSet rs7;
                     rs7 = stmt7.executeQuery("SELECT * FROM shokuin where "+col1+" like '%@%' " );
                     String stbc="";String stbcN="";

                       if(rs7.next()) {stbc=rs7.getString(col1); stbcN=rs7.getString("id"); }
			  			while(rs7.next()){

			  			 stbc=stbc+","+rs7.getString(col1);
			  			 stbcN=stbcN+","+rs7.getString("id");
			  			}
			  			rs7.close();
			  			stmt7.close();


                        col1="renraku_ad";//タイトルのみ希望
                     Statement stmt8 = conn.createStatement();
			  		 ResultSet rs8;
                     rs8 = stmt8.executeQuery("SELECT * FROM shokuin where "+col1+" like '%@%' " );
                     String stbc2="";String stbc2N="";
                        if(rs8.next()) { stbc2=rs8.getString(col1);stbc2N=rs8.getString("id");}
			  			while(rs8.next()){
			  			 stbc2=stbc2+","+rs8.getString(col1);
			  			 stbc2N=stbc2N+","+rs8.getString("id");
			  			}
			  			rs8.close();
			  			stmt8.close();
			  		%>

						 mailhaisin(atesaki.val(),'<%=stbcN%>','<%=stbc%>',tenpu.val(),name.val(),kenmei.val(),naiyo.val(),'回覧＞');
						 mailhaisin(atesaki.val(),'<%=stbc2N%>','<%=stbc2%>','<N>',name.val(),'新着メッセージ','件名「'+kenmei.val()+'」の新着メッセージが投稿されていますのでご覧ください。','回覧＞');


						$.post(
								'RequestServ_kairan',
								{
	                              'oper': 'add',
	                              'name': name.val(),
	                              'kikan_s': kikan_s.val(),
	                              'atesaki': atesaki.val(),
	                              'title':kenmei.val(),
	                              'msg': naiyo.val().replace("<p>","").replace("</p>","").trim().replace(/&#10;/g,""),
	                              'tenpu':tenpu.val(),
	                              'user':'<%=user%>'
	                            },
	                            function(data){
	                              if(data.length>0){
	                            	  alert(data);
	                            	  }else{
	                            	       $( "#users tbody" ).prepend( "<tr><td></td><td>[" + kikan_s.val()+"]" + name.val() + "</td><td><b>"
	                     	                      + kenmei.val() + "</b></td><td>編集には再読込</td></tr>" );

	                     	                  	$( "#dialog-form" ).dialog( "close" );
	                     	                  	location.href="kairan.jsp?rmsg=NULL";
	                            	  }

	                          }
						 );
						//location.reload();
					}
					else{
						if(naiyo.val().replace("<p>","").replace("</p>","").trim().replace("<br>","").length==0){
							alert("本文が未入力です");
						}else{
							alert("未入力の欄があります");
						}


					}
					tstart(tid);
				},
				Cancel: function() {
					$( this ).dialog( "close" );
					tstart(tid);
					location.href="kairan.jsp?rmsg=NULL";
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
				//location.reload();
			}
		});
// 変更のダイアログ

		$( "#dialog-form_henko" ).dialog({
			autoOpen: false,
			height: 580,
			width: 700,
			modal: true,
			buttons: {
				"変更の保存": function() {


					//ここでまとめて　複数IMG挿入
					$("#editArea2").html($("#editArea2").html()+"\n"+$("#imgtmp2").html());

					try {
					  ritchTextHtmlArea2.setText(editArea2.innerHTML);
					}
					catch(e){
						alert("エラーです。①本文にワードやエクセルから貼り付けてませんか？②互換表示を解除してますか？");
					}


					var	bValid = true;
					allFields.removeClass( "ui-state-error" );
					if ( bValid ) {






						txtVal= henkan(naiyo.val());

						   if($("#htenpu").html().length>0){

		     		             //メール配信
								mailhaisin($("#hatesaki").val(),'<%=stbcN%>','<%=stbc%>',$("#htenpu").val(),$("#hname").val(),$("#hkenmei").val(),$("#hnaiyo").val(),'回覧の変更＞');

     		             }else{
     		             //$("#htenpu").val("<N>")????

         		             //メール配信
    						mailhaisin($("#hatesaki").val(),'<%=stbcN%>','<%=stbc%>',"<N>",$("#hname").val(),$("#hkenmei").val(),$("#hnaiyo").val(),'回覧の変更＞');

     		             }

						$.post(
								'RequestServ_kairan',
								{
	                              'oper':   'update','number': $("#number").val(),'name': $("#hname").val(),'kikan_s': $("#hkikan_s").val(),
	                              'atesaki': $("#hatesaki").val(),'title':   $("#hkenmei").val(), 'msg':$("#hnaiyo").val().replace(/&#10;/g,""),'tenpu':$("#htenpu").val(),'user':'<%=user%>'
	                            },
	                            function(data){
	                              // alert(data);
	                          //    location.reload(true);
	                            	if(data.length>0){
		                            	  alert(data);
		                            	  }else{
		                            		  $("#nm"+$("#number").val()).replaceWith("<td>" + $("#hname").val() + "<br>[" +$("#hkikan_s").val()+"]</td>");
		  	                                $("#tm"+$("#number").val()).replaceWith("<td><b>" +$("#hkenmei").val() + "</b></td>");
		  	                                 $("#atesaki"+$("#number").val()).replaceWith($("#hatesaki").val());
		  	                                  $("#msg"+$("#number").text()).replaceWith($("#hnaiyo").val());


		              						$( "#dialog-form_henko" ).dialog( "close" );
		              						location.reload();
		                            	  }


	                            }
						 );
					}
					tstart(tid);
				},

				Cancel: function() {
					$( this ).dialog( "close" );
					tstart(tid);
					location.reload();
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});





		$( "#sinkitoroku" )
			.button()
			.click(function() {
				$( "#dialog-form" ).dialog( "open" );
				$( "#name" ).val('<%=userN%>');
				$( "#kikan_s" ).val('<%=datestr_s%> <%=format3.format(cal.getTime())%>');
				tstop(tid);
				//新規の場合 宛先リセット
			 　　　for (i = 0; i < <%=imax%>; i = i +1){
		            $('#cb'+String(i)).attr('checked',false);
				    }
					$("#atesakit").text("");
					$("#atesaki").val("");
					//キャンセルのときでも、添付、件名、内容すべて消す
					$( "#kenmei" ).val("");
					$( "#tenpu" ).val("");
					$( "#tenput" ).empty();

			});





//***********************ダイアログの　宛先欄をクリックして　　宛先ダイアログを開くとき

		$( "#atesakit,#hatesakit" )
			.button()
			.click(function(e) {

			if(e.currentTarget.id=='hatesakit'){ //変更の場合　データをよみこむ

			s_ate=$('#hatesaki').val();
			ss_ate=s_ate.split(",");


			for (i = 0; i < <%=imax%>; i = i +1){
				 $('#cb'+String(i)).attr('checked',false);
			}

			 //ss_ate[k]:職員番号　　i:データ上の番号
				 for (i = 0; i < <%=imax%>; i = i +1){
				    for (k=0;k<ss_ate.length;k=k+1)
				    {
				       if($('#revhd'+ss_ate[k]).val()==String(i)){
            		    $('#cb'+String(i)).attr('checked','checked');
				       }
				    }
			     }
			}else{
				//新規の場合
			//　　　for (i = 0; i < <%=imax%>; i = i +1){
	           	//	    $('#cb'+String(i)).attr('checked',false);
			//     }

			}

			$( "#dialog-form_atesaki" ).dialog( "open" );
        });

//-----------------------------------宛先　関連　関数
       function satesaki(){
        var  sate=<%=shokuinid%>;

         for(var i=0;i<<%=imax%>;i++){
         if($("#cb"+String(i)).attr('checked')　&& <%=shokuinid%>!=$("#hd"+String(i)).val() )
          sate=sate+","+$("#hd"+String(i)).val();
         }
		return sate;
		}

		function acheck(sate){
			return sate.indexOf(",");
		}

		function atesakiname(suji){
		 sujis=suji.split(',');
		var snm="";

		   for (var i=0;i<sujis.length;i++) {
		     //j:shokuinID   k:list number(max:imax)

		      for (var k=0;k<<%=imax%>;k++){
		         if($('#revhd'+sujis[i]).val()==String(k)){
		           snm=snm+'　'+$('#snm'+String(k)).text();
		         }
		      }
		   }
		   return snm;
		}
//********************宛先ダイアログですべて入力後　変更の保存クリックの時 →　編集ダイアログ、または新規ダイアログに　できたデータが表示される
		$( "#dialog-form_atesaki" ).dialog({
			autoOpen: false,
			height: 600,
			width: 600,
			modal: true,
			buttons: {
				"適用": function() {
                      $("#atesaki").val(satesaki);
                      $("#hatesaki").val(satesaki);

                   $("#hatesakit").text(atesakiname($("#hatesaki").val()));
                   $("#atesakit").text(atesakiname($("#atesaki").val()));


                   if(acheck($("#atesaki").val())==-1){
                	   alert("「全員」を選択　にチェックを入れてください（個別の職員にチェックを入れることもできます）");
                   }else{
                	   $( this ).dialog( "close" );
                   }

				},

				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {

			}
        });


//***********************************最初の画面の編集　削除　ボタン　クリックしたとき　→　編集又は新規ダイアログが開く

		$( ".henko" )
			.button()
			.click(function(e) {
			//*********************************
			$( "#dialog-form_henko" ).dialog( "open" );
				var cid = e.currentTarget.id;
				$("#number").val(cid);
				 nm=$("#nm"+cid).text();
				 nmx=nm.split("]");

				$( "#hname" ).val(jQuery.trim(nmx[1]));
				$( "#hkikan_s" ).val(nmx[0].replace('[',''));
				$( "#hatesaki" ).val($("#atesaki"+cid).val());//一覧にある宛先データから読み取る

				$("#hatesakit").text(atesakiname($("#atesaki"+cid).val()));

				 tm=$("#tm"+cid).text();

				$( "#hkenmei" ).val(tm);

				//＠下書きあれば、チェックボックスにチェック
				if(tm.indexOf('@下書き') != -1){
					 $("#sitagaki2").prop("checked", true);
				}



				hnaiyo_s=$("#msg"+cid).text();
							//ここで、文末にIMGがあればそれを抽出し、imgtmp2に移動
				htm=hnaiyo_s.replace(/\\/g,'\\\\');//こうしないと、\が変更保存でへってしまう
				hnaiyo_s=hnaiyo_s.replace(/\n/g,'<br>');
				//alert(hnaiyo_s);
				result = htm.search(/<img/);
				result2=hnaiyo_s.search(/<img/);
				if (result!=-1){
				$("#imgtmp2").empty();
				//alert(htm.slice(result2));
				$("#imgtmp2").append(htm.slice(result));
				hnaiyo_s=hnaiyo_s.slice(0,result2-1);
				//alert(hnaiyo_s);
				}


				hnaiyo_s=hnaiyo_s.replace('<b>','').replace('</b>','');


				hnaiyo_s=hnaiyo_s.replace(/\\/g,'\\\\');
				//$( "#hnaiyo" ).val(hnaiyo_s);
				$( "#editArea2" ).html(hnaiyo_s);

				htmtp=$("#tp"+cid).text();
				//htenp_s=htmtp.replace('<b>','').replace('</b>','').replace(/<br>/,'');
				htenp_s=htmtp;
				htenp_s=htenp_s.replace(/\\/g,'\\\\');
				$( "#htenpu" ).val(htenp_s);
				$( "#htenput" ).empty();//こうしないと、ダイアログ切り替えたとき残っている？
				$( "#htenput" ).append(htenp_s);

				tstop(tid);

			});


	   $( ".sakujo" )
			.button()
			.click(function(e) {
				var cid = e.currentTarget.id;
				cid=cid.replace('del','');
				//alert(cid);
				nm=$("#nm"+cid).text();
				 nmx=nm.split("]");
                //alert(jQuery.trim(nmx[1]));
				//if(jQuery.trim(nmx[1])=='<%=userN%>') {
					answer=confirm('削除すると他の人も閲覧できなくなります。削除してもよろしいですか？');
					//alert($("#msg"+cid).text());
　　　　					if(answer==true){
　　　　　　　					　$.post(
								'RequestServ_kairan',
								{
	                              'oper':'del','number':cid,'opath':$('#opath').val(),'tenpu':$("#msg"+cid).text(),'opath2':$('#opath2').val()
	                            },
	                            function(data){
	                              // alert(data);
	                                $("#tr"+cid).remove();

            						$( "#dialog-form_henko" ).dialog( "close" );


            						//$(location).attr("href", "kairan.jsp?rmsg=NULL");
            						location.reload();//もとの一覧にもどるほうがよい
	                            }
						   );
　　　　					}else{
　　　　　						$( "#dialog-form_henko" ).dialog( "close" );　　
　　　						　}


				   // }else
				 //   {
				   //  alert("<%=userN%>作成者以外の方は削除できません");
				    //}

			});
	   //＋＋＋＋＋＋＋＋＋＋＋＋＋＋＋＋＋添付ファイルクリア++++++++++++++++++++++++++++

			 $( "#clear2" )//編集ダイアログ
			.button()
			.click(function() {
				$.post(
						'RequestServ_kairan',
						{
                          'oper':'deltenpu','tenpu':$("#htenpu").val(),'opath':$('#opath').val(),'number':$('#number').val()
                        },
                        function(data){

                        }
				   );
				$("#htenput").empty();
				$("#htenpu").val('');
				　$("#tp"+$('#number').val()).val('');


				$.post(
						'RequestServ_osirase',
						{
	                      'oper':'delimg','tenpu':$("#imgtmp2").html(),'opath':$('#opath').val(),'opath2':$('#opath2').val()
	                    },
	                    function(data){

	                    }
				   );
				$("#imgtmp2").empty();

			});

			 $( "#clear" )//新規ダイアログ
			.button()
			.click(function() {
				$.post(
						'RequestServ_kairan',
						{
                          'oper':'deltenpu','tenpu':$("#tenpu").val(),'opath':$('#opath').val()
                        },
                        function(data){

                        }
				   );


				$("#tenput").empty();
				$("#tenpu").val('');
				$("#tp"+$('#number').val()).val('');


				$.post(
						'RequestServ_osirase',
						{
	                      'oper':'delimg','tenpu':$("#imgtmp").html(),'opath':$('#opath').val(),'opath2':$('#opath2').val()
	                    },
	                    function(data){

	                    }
				   );
				$("#imgtmp").empty();

			});




//************************************link
 $('#link').on("change", function() {
        	 var filename = this.files[0];

            var file = $(this).val();

                var rt=file.replace(/[\\]/g,"\/");
                if(file.indexOf("\\\\")!=-1){
	 				$('#naiyo').val($('#naiyo').val()+"<br><span title=\"インターネットエクスプローラでのみ使用可能\"><a href=\"file:"+rt+"\">"+"共有ファイルを直接開きます＞"+filename.name+"</a></span>");
               　			}else{
                　　				     alert(file+":共有にあるファイルを指定してください。");
                }

        });

 $('#link2').on("change", function() {
	 var filename = this.files[0];

    var file = $(this).val();

        var rt=file.replace(/[\\]/g,"\/");
        if(file.indexOf("\\\\")!=-1){
 　　　　　　        $('#hnaiyo').val($('#hnaiyo').val()+"<br><span title=\"インターネットエクスプローラでのみ使用可能\"><a href=\"file:"+rt+"\">"+"共有ファイルを直接開きます＞"+filename.name+"</a></span>");
　　　　　　　}else{
	       alert("共有にあるファイルを指定してください。");
　　　　　　　}
});



 //************************************************URL挿入
 $(function() {
	    $("#get").click(function(){
	       $("#editArea").html($("#editArea").text()+"\n<a href=\""+$("#linkurl").val()+"\">"+$("#linkurl").val()+"</a>");
	       return false;
	    });
	});

 //$(function() {
//	    $("#gazo").click(function(){
	    	//$("#imgurl").val()番目の添付ファイルの画像がJPGなら、IMGに変換して　文末に追加


//	       $("#editArea").html($("#editArea").text()+"\n<img src=\""+$("#linkurl").val()+"\" alt=\""+$("#linkurl").val()+"\">");
//	       return false;
//	    });
//	});


$(function() {
	    $("#get2").click(function(){
	       $("#editArea2").html($("#editArea2").text()+"\n<a href=\""+$("#linkurl2").val()+"\">"+$("#linkurl2").val()+"</a>");
	       return false;
	    });
	});

//$(function() {
//    $("#gazo2").click(function(){
//       $("#editArea2").html($("#editArea2").text()+"\n<img src=\""+$("#linkurl2").val()+"\" alt=\""+$("#linkurl2").val()+"\">");
//       return false;
//    });
//});
///////////////////////////////////imgに日時_file名でファイル名をつける
//imgに日時_ユーザ名でファイル名をつける  時刻が更新ならない？？？？？？？
$('#imgfileup1').change(function(e) {
	flggazo=false;
	$(".wait").replaceWith("<label for='tenpu' class='wait'><font color='red'>処理中です...少しお待ち下さい</font></label>");

	 var file = $(this).prop('files')[0];

	  fext=file.name.split('.')[1];
      if((fext=='jpg'||fext=='JPG') &&  $("#img_gazo").prop('checked') ){
    	  flggazo=true;
    	  <%
  	    String imgFileName=format_yyyyMMddHHmmss.format(calimg.getTime());
  		%>
  		$('.jpgname').val('<%=imgFileName %>_'+file.name);

  		//****************************************

     	    var $form, fd;
     	    $form = $("#myForm");
     	    fd = new FormData($form[0]);
     	    $.ajax($form.attr("action"), {
     	      type: 'post',
     	      processData: false,
     	      contentType: false,
     	      data: fd,
     	      dataType: 'html',
     	      success: function(data){
     	    	//  alert(data);
     	    	data=data.trim();
     	       	$("#imgtmp").append("<img src='"+data+"' alt='"+data+"'>");

     	       $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");

     	       }
     	    });
      }


   	    //*************tempu file mo tuika

                $(this).upload('fileupload', function(res) {

	             			 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+res;
	               			 tuika2="<a href=\""+tuikad2+"\">"+res+"</a>";//保存は通常文字で
	               			 $('#tenpu').val($('#tenpu').val()+tuika2+"　");
	            			 $('#tenput').append(tuika2+"　");
	            			 if(flggazo==false){
	            				 $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");

	            			 }
	        			 }, 'text');
         //**********************

   	    return false;

		//===========================================
});

$('#imgfileup2').change(function(e) {
	 flggazo2=false;
		$(".wait").replaceWith("<label for='tenpu' class='wait'><font color='red'>処理中です...少しお待ち下さい</font></label>");
	 var file = $(this).prop('files')[0];
	  fext=file.name.split('.')[1];
      if((fext=='jpg'||fext=='JPG')  &&  $("#img_gazo2").prop('checked') ){
    	  flggazo2=true;
    	  <%
		    String imgFileName2=format_yyyyMMddHHmmss.format(calimg.getTime());
			%>
			$('.jpgname').val('<%=imgFileName2 %>_'+file.name);

			//****************************************
			$("#reply2").html("<font color='red'>しばらくお待ちください...数十秒しても表示されないときは、画像サイズ（10MB未満）を確認ください...</font>");
	 	    var $form, fd;
	 	    $form = $("#myForm2");
	 	    fd = new FormData($form[0]);
	 	    $.ajax($form.attr("action"), {
	 	      type: 'post',
	 	      processData: false,
	 	      contentType: false,
	 	      data: fd,
	 	      dataType: 'html',
	 	      success: function(data){
	 	    	 data=data.trim();
	 	       	$("#imgtmp2").append("<img src=\""+data+"\" alt=\""+data+"\">");

	 	       $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");

	 	      }
	 	    });
      }


	 	   //*************tempu file mo tuika

	                $(this).upload('fileupload', function(res) {

		             			 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+res;
		               			 tuika2="<a href=\""+tuikad2+"\">"+res+"</a>";//保存は通常文字で
	                 			 $('#htenpu').val($('#htenpu').val()+tuika2);
	                 			 $('#htenput').append(tuika2+"　");
	                 			if(flggazo2==false){
	               				 $(".wait").replaceWith("<label for='tenpu' class='wait'><font color='green'>処理終了！次の操作に移ってもだいじょうぶです</font></label>");
	               			 }
		        			 }, 'text');
	         //**********************

	 	    return false;


});

$('#sitagaki1').change(function(){

	if($(this).is(':checked')){
       $('#kenmei').val($('#kenmei').val()+"@下書き");
	}else{
		 $('#kenmei').val($('#kenmei').val().replace("@下書き",""));
	}

});

$('#sitagaki2').change(function(){

	if($(this).is(':checked')){
       $('#hkenmei').val($('#hkenmei').val()+"@下書き");
	}else{
		 $('#hkenmei').val($('#hkenmei').val().replace("@下書き",""));
	}

});



//*********************ファイルアップロード


		$('.fileup').change(function(e) {

			 $(".wait").replaceWith("<label for='tenpu' class='wait'>添付<font color='red'>>>しばらくそのままお待ちください...</font></label>");

	     		<%
	     		String nowtime=format3.format(cal.getTime());
	     		%>
	     		    fln=$(this).val();
	            			  sst=fln.split("\\");
	            			  tuikao=jQuery.trim($('#opath').val())+jQuery.trim(sst[sst.length-1]);

	            			  tuikad=jQuery.trim(sst[sst.length-1]);


	                  $(this).upload('fileupload', function(res) {

	                 	// tuikad2=jQuery.trim($('#opath2').val())+res;

	                 		//こちらは、専用のダウンロードサーブレット  zipファイルになることがある不具合あり
	                 		//jQuery.trim($('#opath').val())+res
	             			 tuikad2="FileDownloadServlet?filename="+jQuery.trim($('#opath').val())+res;

	            			//  tuika2="<a href=\""+encodeURI(tuikad2)+"\">"+res+"</a>";
	            			 tuika2="<a href=\""+tuikad2+"\">"+res+"</a>";//保存は通常文字で

	                 	 		 if (e.currentTarget.id=='file1'){
	                 			 $('#tenpu').val($('#tenpu').val()+tuika2+"　");
	                 			  $('#tenput').append(tuika2+"　");
	                 			 }else{
	                 			 $('#htenpu').val($('#htenpu').val()+tuika2);
	                 			 $('#htenput').append(tuika2+"　");

	                 			 }

	                                       $(".wait").replaceWith("<label for='tenpu' class='wait'>添付<font color='green'>ファイルのアップロード終了！次の操作に移ってもだいじょうぶです</font></label>");

	        			 }, 'text');



         });




		$("#editArea").on("paste",function(event){
			//editAreaに貼り付けしたとき 余分なタグを除去して　エラー防止
	 setTimeout( function() {
		 //alert($("#editArea").text().replace(/(\n|\r)(\n|\r)/g,'<br>').trim());
			$("#editArea").html($("#editArea").text().replace(/(\n|\r)(\n|\r)/g,'<br>').trim());
			//naiyo.val($("#editArea").text().replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'').replace(/<br>/,'').tirm());
	        }, 10 );
		});

		$("#editArea2").on("paste",function(event){
			//editAreaに貼り付けしたとき 余分なタグを除去して　エラー防止
	      setTimeout( function() {
		// alert($("#editArea2").html());
		 $("#editArea2").html($("#editArea2").html().replace(/<br>/g,'\r'));

		$("#editArea2").html($("#editArea2").text().replace(/(\n|\r)(\n|\r)/g,'<br>').replace(/(\r|\n)/g,'<br>').trim());
		//alert($("#editArea2").html());
		$("#editArea2").html($("#editArea2").html().replace(/<br><br>/g,'<br>'));

	        }, 10 );
		});




	});

	  // Drop領域にドロップした際のファイルのプロパティ情報読み取り処理
	<%@ include file="dragdrop_fileupload.jsp" %>



function checkx(n,mxp,kensu){
	 //選択枝追加してから、選択
	// couxi=parseInt(mxp,10)/parseInt(skensu,10)+1;
	 couxi=parseInt(mxp,10)/parseInt(kensu,10);

	 for (x=1;x<couxi+1;x=x+1){
		 $('#pages').append($('<option>').html(String(x)).val(String(x)));
	 }

	  $("select[name='page']").val(n);
	}

	 checkx(<%=pg%>,<%=couxs%>,<%=skensu%>);



	 $.post(
				'sette_p',
				{
		          'flg':'yomi'
		        },
		        function(data){
		         var st=data;
		       dtdt=st.split('\t');
		       jQuery('.igazo').each(function(){
		    		jQuery(this).attr('src',dtdt[1]+'mylogo/'+$(this).attr('src'));
		    		 $(this).error(function() {
		    				//ファイルが存在しない画像はimgタグ自体を削除
		    		        $(this).remove();
		    		    });
		    	});
		       if(<%=skensu%>=='2'){
		    		alert("１ページの最大表示件数は３以上に設定してください。２０～３０程度が適切です。");
		    	}
		 });





</script>
