<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<div id="page-wrap" >
        <ul class="dropdown" >
        	<li><a href="top.jsp">ＴＯＰ</a>
        	</li>
        	<li><a href="kairan.jsp?rmsg=NULL">回　覧</a>
           	</li>
        	<li><a href="schedule.jsp">月予定</a>
           	</li>
           	<li><a href="henko.jsp">授業変更</a>
           	</li>
           	<li><a href="link.jsp">リンク</a>
           	</li>
           	<li><a href="#">設　定</a>
        		<ul class="sub_menu">
					<li><a href="/SGW/passet.jsp" title="ログイン（メールチェックも含む）のパスワードを変更できます">ログインパスワードの変更</a></li>
        			 <li><a href="/SGW/mylogo.jsp" title="自分のロゴを登録できます">ロゴ登録</a></li>
        		     <li>
        				<a href="#">メール</a>
        				<ul>
        					<li><a href="/SGW/mailset.jsp"　title="この設定により自分へのメールの有無をチェックすることができます">メールチェック設定</a></li>
        					<li><a href="/SGW/haisin.jsp"　title="お知らせや回覧に新しく投稿があったことを通知することができます">メール配信（連絡）設定</a></li>
        				</ul>
        			</li>
        			 <li>
        				<a href="#">職員</a>
        				<ul>
        					<li><a href="/SGW/shokuin_list.jsp">ID一覧</a></li>
        					<li><a href="/SGW/group.jsp" title="ここで、自分がよく使うグループの登録ができます">グループ登録</a></li>
        				</ul>
        			 </li>
        			 <li>
        				<a href="#">各種設定（担当者用）</a>
        				<ul>
        					<li><a href="/SGW/settei.jsp">ファイル保存場所他</a></li>
							<li><a href="/SGW/pwreset.jsp">仮パスワード発行</a></li>
        				</ul>
        			 </li>
        		</ul>
        	</li>
        	<li><a href="/SGW/Logout1">終　了</a>
        	</li>
        </ul>
</div >


