<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Movie Flex</title>
    <style>
        body{
            background-image: url("<c:url value='/imgs/theater image.jpg'/>");
            background-attachment:fixed;
            background-size:cover;
            color:white;
            display:flex;
            flex-direction:column;
            padding: 0px;
            margin: 0px;

            /* 드래그 방지 */
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -o-user-select: none;
            user-select: none;
            -webkit-user-drag: none;
            -khtml-user-drag: none;
            -moz-user-drag: none;
            -o-user-drag: none;
        }

        body button{
            background:transparent;
            color:white;
            border-radius: 5px;
            font-weight:bold;
            border:2px solid white;
            padding:5px 10px;
            cursor:pointer;
            margin:3px;
        }

        .commentHeader{
            margin:0 auto;
        }

        .commentList{
            display:flex;
            justify-content: center;
            margin: 70px 0 100px 0;
        }

        .commentList .li_comment_container{
            /*display:flex;*/
            /*align-items: center;*/
        }

        .commentList .comment_container{
            border-bottom:1px solid slategrey;
            padding:20px 0;
            height:50px;
        }

        .commentList .reply_container{
            border:1px solid white;
            margin-left:30px;
            margin-top:10px;
            padding: 10px 0;
            height:50px;
        }

        .commentList .commenter{
            margin-right:100px;
        }

        .commentList .comment{
            cursor:pointer;
            padding-right:500px;
        }

        .commentList .reg_date, .commentmodifyBtn, .removeBtn{
            float:right;
        }

        .writeContainer #form{
            display:flex;
            justify-content:center;
        }

        .writeContainer #form .commentValue{
            resize:none;
            width:60%;
            height:100px;
            background:rgba(255,255,255, 0.1);
            color:white;
        }

        .writeContainer #form .writer{
            color:white;
            font-size:20px;
            font-weight:bold;
            margin-right:30px;
        }



        .modifyComment, .replyComment{
            height:25px;
        }
    </style>
    <link rel="stylesheet" href="<c:url value="/css/Header.css"/>"/>
</head>
<body>

<header class="headerTag">
    <div class="timer">
        <span id="timer"></span>
    </div>

    <div id="Logo" class="top_menu">
        <ul class="menu_list">
            <li><a href="<c:url value="/"/>" class="logo">MOVIE FLEX</a></li>

            <div class="menus">
                <li><a href="<c:url value="/movies/main"/>" class="menu_movies_list menu">MOVIES</a></li>
                <li><a href="<c:url value="/board/list"/>" class="menu_board menu">BOARD</a></li>
                <li><a href="<c:url value="/login/logout"/>" class="menu_login menu">LOGOUT</a></li>
                <li><a href="<c:url value=''/>" class="menu">MY PAGE</a></li>
            </div>
        </ul>
    </div>
</header>

<h1 class="commentHeader">CommentList</h1>
<br>
<!-- commentList가 XHR을 통해 서버에서 데이터를 받아 js를 통해 동적으로 만들 부분 -->
<div id="commentList" class="commentList">

</div>

<!-- 댓글을 작성할 form -->
<div class="writeContainer">
    <div id="form">
<%--        <input type="text" name="comment" id="commentValue" />--%>
        <span id="writer" class="writer">${writer}</span>
        <textarea name="comment" id="commentValue" class="commentValue"></textarea>
        <button type="button" id="commentWrtBtn">댓글작성</button>
    </div>
</div>


    <!-- 답글을 눌렀을때 그 댓글 바로 밑에 작성할 수 있도록 동적으로 append해준다. (평소에는 hidden으로 숨김처리 한다.)-->
<div>
    <div id="replyForm">
        <input type="text" name="comment" class="replyComment" id="replyComment" />
        <button type="button" id="commentReplyBtn">답글작성</button>
    </div>

    <!-- 댓글 수정 버튼을 누르면 수정할 수 있는 form이 붙음 -->
    <div id="modifyForm">
        <input type="text" name="comment" class="modifyComment" id="modifyComment" />
        <button type="button" id="commentModifyBtn">댓글수정</button>
    </div>
</div>
</body>
<script src="<c:url value="/js/timer.js"/>"></script>
<script>
    let commentList = document.querySelector("#commentList");

    let form = document.querySelector("#form");
    let modifyForm = document.querySelector("#modifyForm");
    let replyForm = document.querySelector("#replyForm");

    let commentValue = document.querySelector("#commentValue");
    let modifyComment = document.querySelector("#modifyComment");
    let replyComment = document.querySelector("#replyComment");

    let commentWrtBtn = document.querySelector("#commentWrtBtn");
    let commentModifyBtn = document.querySelector("#commentModifyBtn");
    let commentReplyBtn = document.querySelector("#commentReplyBtn");
    // let bno = 1;
    let bno = "${bno}";

    replyForm.style.display = "none";
    modifyForm.style.display = "none";

    //xss prevent function
    function XSSFilter(content) {
        return content.replace(/</g, "&lt;").replace(/>/g, "&gt;");
    }


    //showList
    let showList = (bno) => {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "comments/"+bno);
        xhr.send();

        xhr.onload = () => {
            if(xhr.status == 200){
                console.log(Array.from(JSON.parse(xhr.response)));
                commentList.innerHTML = makeHTML(JSON.parse(xhr.response));

            } else{
                console.log("error");
            }
        }
    }

    let makeHTML = (data) => {
        let ulTag = "<ul>";
        data.forEach((element) => {
            let change_regDate = new Date(element.reg_date);
            console.log(change_regDate);

            let regDate_Year = change_regDate.getFullYear();
            let regDate_Month = change_regDate.getMonth()+1 < 10 ? "0" + (change_regDate.getMonth()+1) : change_regDate + 1;
            let regDate_Day = change_regDate.getDate() < 10 ? "0" + change_regDate.getDate() : change_regDate.getDate();
            let regDate_Hours = change_regDate.getHours() < 10 ? "0" + change_regDate.getHours() : change_regDate.getHours();
            let regDate_Minutes = change_regDate.getMinutes() < 10 ? "0" + change_regDate.getMinutes() : change_regDate.getMinutes();
            let regDate_Seconds = change_regDate.getSeconds() < 10 ? "0" + change_regDate.getSeconds() : change_regDate.getSeconds();

            let total_regDate = regDate_Year + "." + regDate_Month + "." + regDate_Day + " " + regDate_Hours + ":" + regDate_Minutes + ":" + regDate_Seconds;
            console.log(total_regDate);


            if(element.pcno == element.cno) {   ulTag += "<div class='comment_container'>";  }
            else {    ulTag += "<div class='reply_container'>";    }
            ulTag += "<li class='li_comment_container' data-cno=" + element.cno + " data-bno=" + element.bno + " data-pcno=" + element.pcno + ">"
            ulTag += element.pcno != element.cno ? "      ㄴ" : "";
            ulTag += "<span class='commenter'>" + element.commenter + "</span>";
            ulTag += "<span class='comment'>" + element.comment + "</span>";
            // ulTag += "<div class='time_btns'>";
            ulTag += " <button type='button' class='removeBtn'>삭제</button>";
            ulTag += " <button type='button' class='commentModifyBtn'>수정</button>";
            ulTag += "<span class='reg_Date'>" + total_regDate + "</span>";
            // ulTag += "</div>";
            // ulTag += " <button type='button' class='commentReplyBtn'>답글</button>";
            ulTag += "</li>";
            ulTag += "</div>";

        })

        return ulTag + "</ul>";
    }

    showList(bno);



    // Delete
    // 동적으로 만든 element는 부모 태그를 사용하여 이벤트를 만들어야한다.
    commentList.addEventListener("click", (e) => {
        if(e.target.className == "removeBtn"){
            if(!confirm("삭제하겠습니까?")) return;
            // alert("click " + e.target.parentElement.dataset.cno);
            let cno = e.target.parentElement.dataset.cno;


            let xhr = new XMLHttpRequest();
            xhr.open("DELETE", "comments/" + cno + "?bno=" + bno);
            xhr.send();

            xhr.onload = () => {
                if(xhr.status == 200){
                    console.log("delete OK");
                    showList(bno);
                } else{
                    alert("error");
                }
            }
        }
    })



    //Post
    commentWrtBtn.addEventListener("click", writeEvent);
    //pressEnter Event
    window.addEventListener("keypress", (e) => {
        // console.log(e.key);
        if(e.key == "Enter" && commentValue == document.activeElement){
            e.preventDefault(); // Enter 누르면 refresh됨
            writeEvent();
            showList(bno);
        }
    })


    function writeEvent(){
        let commentValue = document.querySelector("#commentValue");

        if(commentValue.value.trim() == ""){
            alert("내용을 입력하세요");
            commentValue.value = "";
            commentValue.focus();
            return;
        }


        let xhr = new XMLHttpRequest();
        xhr.open("POST", "comments");
        xhr.setRequestHeader("Content-type", "application/json");

        //data에 들어갈 내용 comment, bno, pcno comment는 xss를 막기 위해서 XSSFilter함수를 만들었음
        let data = {bno : bno, comment : XSSFilter(commentValue.value)};
        xhr.send(JSON.stringify(data));

        xhr.onload = () => {
            if(xhr.status == 200){
                console.log("작성 성공");
                commentValue.value = "";
                showList(bno);
            } else{
                alert("error");
            }
        }
    }




    //modify

    //댓글에 있는 수정 버튼을 누르면 댓글 바로 밑에 수정 form을 append해줌
    commentList.addEventListener("click", (e) => {
        if(e.target.className == "commentModifyBtn"){
            // alert("click");
            e.target.parentElement.append(modifyForm);
            modifyForm.style.display = "block";
            replyForm.style.display = "none";

            modifyComment.value = e.target.parentElement.querySelector(".comment").innerHTML;
        }
    });

    commentModifyBtn.addEventListener("click", modifyEvent);

    function modifyEvent(e){
        if(modifyComment.value.trim() == ""){
            alert("수정할 내용을 작성하세요.");
            modifyComment.innerHTML = "";
            modifyComment.focus();
            return;
        }
        console.log(e.target.parentElement.parentElement.dataset.cno);
        let cno = e.target.parentElement.parentElement.dataset.cno;

        let xhr = new XMLHttpRequest();
        xhr.open("PATCH", "comments/" + cno);
        xhr.setRequestHeader("Content-type", "application/json");
        let data = {cno : cno, bno : bno, comment : XSSFilter(modifyComment.value)};
        xhr.send(JSON.stringify(data));

        xhr.onload = () => {
            if(xhr.status == 200){
                console.log("수정 성공");
                showList(bno);
                modifyForm.style.display = "none";
            } else{
                alert("error");
            }
        }
    }

    //수정 form에 있는 text안에 focus를 하고 Enter키를 누르면 댓글이 수정되는로직
    window.addEventListener("keypress", (e) => {
        // console.log(e.key);
        if(e.key == "Enter" && modifyComment == document.activeElement){
            e.preventDefault(); // Enter 누르면 refresh됨
            modifyEvent(modifyComment);
            showList(bno);
        }
    })




    //reply
    // commentReplyBtn 눌렀을대 replyForm은 block하고 modifyForm은 없앰;
    commentList.addEventListener("click", (e) => {
        if(e.target.className == "commentReplyBtn"){
            e.target.parentElement.append(replyForm);
            replyForm.style.display = "block";
            modifyForm.style.display = "none";
        }
    })

    //comment를 눌렀을대 reply창이 뜨게
    commentList.addEventListener("click", (e) => {
        if(e.target.className == "comment"){
            e.target.parentElement.append(replyForm);
            replyForm.style.display = "block";
            modifyForm.style.display = "none";
        }
    })

    commentReplyBtn.addEventListener("click", replyEvent);

    function replyEvent(e){
        if(replyComment.value.trim() == ""){
            alert("답글을 작성하세요");
            replyComment.innerHTML = "";
            replyComment.focus();
            return
        }

        let pcno = e.target.parentElement.parentElement.dataset.pcno;
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "comments");
        xhr.setRequestHeader("Content-type", "application/json");

        let data = {bno : bno, comment : XSSFilter(replyComment.value), pcno : pcno};
        xhr.send(JSON.stringify(data));


        xhr.onload = () => {
            if(xhr.status == 200){
                showList(bno);
                replyComment.value = "";
                replyForm.style.display="none";
            } else{
                alert("error");
            }
        }
    }

    //replyComment에 focus되어있고 enter눌렀을때 replyEvent메소드가 호춣
    window.addEventListener("keypress", (e) => {
        if(e.key == "Enter" && replyComment == document.activeElement){
            e.preventDefault();
            replyEvent(replyComment);
            showList(bno);
        }
    })





</script>
</html>
