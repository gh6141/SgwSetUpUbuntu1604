<%@ page pageEncoding="utf-8" %>
<div align="left" title="強調したい文字を選択してから、各種修飾ができます。また、「リンク」をクリックして、URLを指定してするとリンクが挿入できます。">
内容　　<font size=-1>
文字サイズ:
    <select id="fontSizeSelecter">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3" selected>3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
    </select>

文字色:
    <select id="fontColorSelecter">
        <option value="#2980b9">黒</option>
        <option value="blue">青</option>
        <option value="red">赤</option>
        <option value="yellow">黄</option>
        <option value="green">緑</option>
        <option value="violet">紫</option>
    </select>

背景色:
    <select id="bgColorSelecter">
        <option value="white">白</option>
        <option value="black">黒</option>
        <option value="blue">青</option>
        <option value="red">赤</option>
        <option value="yellow">黄</option>
        <option value="green">緑</option>
        <option value="violet">紫</option>
    </select>
   <button type="button" id="boldButton" class="min">太字</button>
        <button id="underLineButton" type="button" class="min">下線</button>
        <button id="ialicBotton" type="button" class="min">イタリック</button>
         <button id=link_gazo type="button" class="min">リンク</button>
         <br>
	 <span id=linkurls>
<input id="linkurl" type="text" value="http://"/>のリンクを<button id="get" type="button" class="min">挿入</button>

</span>



</font>
</div>