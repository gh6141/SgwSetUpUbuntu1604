<%@ page pageEncoding="utf-8" %>

             editArea = $id("editArea");
             ritchTextHtmlArea = $id("naiyo");

            //innerText を設定するためのメソッドを追加
            setAlter_innerText(editArea);
            setAlter_innerText(ritchTextHtmlArea);


            editArea2 = $id("editArea2");
            ritchTextHtmlArea2 = $id("hnaiyo");

           //innerText を設定するためのメソッドを追加
           setAlter_innerText(editArea2);
           setAlter_innerText(ritchTextHtmlArea2);


//*************************************************************************************
            //フォントサイズを指定するドロップダウンリストのイベントハンドラ
            $id("fontSizeSelecter")
                .addEventListener("change", function () {
                    if (checkSelectionText()) {
                        document.execCommand('fontSize', false, this.value);
                    }

                });


            //フォントカラーを指定するドロップダウンリストのイベントハンドラ
            $id("fontColorSelecter").addEventListener("change", function () {
                if (checkSelectionText()) {
                    document.execCommand('ForeColor', false, this.value);
                }
            });

            //背景色を指定するドロップダウンリストのイベントハンドラ
            $id("bgColorSelecter").addEventListener("change", function () {
                if (checkSelectionText()) {
                    document.execCommand('backColor', false, this.value);
                }
            });


            //[太字] ボタン
            $id("boldButton").addEventListener("click", function () {
                if (checkSelectionText()) {
                    document.execCommand("bold", false);
                }
            });

            //[下線] ボタン
            $id("underLineButton").addEventListener("click", function () {
                if (checkSelectionText()) {
                    document.execCommand("underline", false);
                }
            });

            //[イタリック] ボタン
            $id("ialicBotton").addEventListener("click", function () {
                if (checkSelectionText()) {
                    document.execCommand("italic", false);
                }
            });
//*************************************
   //フォントサイズを指定するドロップダウンリストのイベントハンドラ
            $id("fontSizeSelecter2")
                .addEventListener("change", function () {
                    if (checkSelectionText()) {
                        document.execCommand('fontSize', false, this.value);
                    }

                });


            //フォントカラーを指定するドロップダウンリストのイベントハンドラ
            $id("fontColorSelecter2").addEventListener("change", function () {
                if (checkSelectionText()) {
                    document.execCommand('ForeColor', false, this.value);
                }
            });

            //背景色を指定するドロップダウンリストのイベントハンドラ
            $id("bgColorSelecter2").addEventListener("change", function () {
                if (checkSelectionText()) {
                    document.execCommand('backColor', false, this.value);
                }
            });


            //[太字] ボタン
            $id("boldButton2").addEventListener("click", function () {
                if (checkSelectionText()) {
                    document.execCommand("bold", false);
                }
            });

            //[下線] ボタン
            $id("underLineButton2").addEventListener("click", function () {
                if (checkSelectionText()) {
                    document.execCommand("underline", false);
                }
            });

            //[イタリック] ボタン
            $id("ialicBotton2").addEventListener("click", function () {
                if (checkSelectionText()) {
                    document.execCommand("italic", false);
                }
            });

//************************************************************************
            //[生成された HTMLの取得] ボタン
            $id("getHtmlButton").addEventListener("click", function () {
                ritchTextHtmlArea.setText(editArea.innerHTML);
                $('#naiyo').show();
                $('#editArea').hide();
            });

            $id("getHtmlButton2").addEventListener("click", function () {
                ritchTextHtmlArea2.setText(editArea2.innerHTML);
                $('#hnaiyo').show();
                $('#editArea2').hide();
            });


            //文字が選択されているか判断
            function checkSelectionText() {
                 selectionFlag = (document.getSelection().toString().length > 0);
                if (!selectionFlag) {
                    alert("文字が選択されていません。\n文字を選択してください。");
                }
                return selectionFlag;
            }

