<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginout" value="${sessionScope.id == null || sessionScope.id == '' ? 'login' : 'logout'}"/>
<c:set var="loginoutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login/login' : '/login/logout'}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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

        .writeBoardContainer{
            margin-top: 100px;
            border:3px solid white;
            width:50%;
            height:700px;
            display:flex;
            flex-direction:column;
            margin: 0 auto;
            padding:70px;
        }

        .writeBoardContainer .titleContainer{
            border:1px solid white;
            height:70px;
            margin-bottom:70px;

        }

        .writeBoardContainer .titleContainer .title{
            width:100%;
            height:100%;
            box-sizing: border-box;
            background:transparent;
            color:white;
            font-weight:bold;
            font-size:20px;
        }

        .writeBoardContainer .contentContainer{
            border:1px solid white;
            height:550px;
        }

        .writeBoardContainer .contentContainer .content{
            resize:none;
            border:none;
            box-sizing: border-box;
            width: 100%;
            height: 100%;
            background: transparent;
            color:white;
            font-weight:bold;
            font-size:15px;
            padding:10px;
            height: 100%;
        }


        .form .btns{
            display:flex;
            justify-content: center;
            margin:100px 0;
        }

        .form .btns .btn{
            background:transparent;
            color:white;
            border-radius: 5px;
            font-weight:bold;
            border:2px solid white;
            padding:5px 10px;
            margin:10px;
            cursor:pointer;
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

<form id="formTag" class="form">
    <div class="writeBoardContainer">
        <div class="boardInfo">
            <input type="hidden" name="bno" value="${boardDto.bno}"/>
            <input type="hidden" name="writer" value="${boardDto.writer}" />
        </div>

        <div class="titleContainer">
            <input type="text" name="title" id="title" class="title" placeholder="제목을 입력하세요" value="<c:out value="${boardDto.title}"/>" readonly/>
        </div>

        <div class="contentContainer">
            <textarea name="content" id="content" class="content" placeholder="내용을 입력하세요" readonly><c:out value="${boardDto.content}"/></textarea>
        </div>
    </div>

    <div class="btns">
        <button type="button" id="listBtn" class="listBtn btn">목록</button>
        <button type="button" id="modBtn" class="modBtn btn">수정</button>
        <button type="button" id="writeBtn" class="writeBtn btn">등록</button>
        <button type="button" id="removeBtn" class="removeBtn btn">삭제</button>
        <button type="button" id="commentBtn" class="commentBtn btn">댓글보기</button>
    </div>
</form>



</body>
<script src="<c:url value="/js/timer.js"/>"></script>
<script>
    let formTag = document.querySelector("#formTag");
    let h1Tag = document.querySelector("#h1Tag");
    let listBtn = document.querySelector("#listBtn");
    let modBtn = document.querySelector("#modBtn");
    let removeBtn = document.querySelector("#removeBtn");
    let writeBtn = document.querySelector("#writeBtn");
    let commentBtn = document.querySelector("#commentBtn");
    let mode = "${mode}";
    console.log(mode);


    if(mode == "new"){
        removeBtn.style.display = "none";
        modBtn.style.display = "none";

        document.querySelector("#title").readOnly = false;
        document.querySelector("#content").readOnly = false;

    } else{
        writeBtn.style.display = "none";
    }


    listBtn.addEventListener("click", function(e){
        location.href = "<c:url value="/board/list"/>?page=${page}&pageSize=${pageSize}";
    });

    removeBtn.addEventListener("click", (e) => {
        location.href = "<c:url value="/board/remove"/>?bno=${boardDto.bno}&writer=${boardDto.writer}";
    });

    writeBtn.addEventListener("click", (e) => {
        formTag.setAttribute("action", "<c:url value="/board/write"/>");
        formTag.setAttribute("method", "post");

        formTag.submit();
    })

    modBtn.addEventListener("click", () => {
        // title이 readonly상태면 true가 나옴
        let isRead = document.querySelector("#title").readOnly;
        if(isRead){
            document.querySelector("#title").readOnly = false;
            document.querySelector("#content").readOnly = false;
            modBtn.innerHTML = "수정 후 등록";
            return;
        }

        formTag.setAttribute("action", "<c:url value="/board/modify"/>");
        formTag.setAttribute("method", "post");
        console.log("title = " + document.querySelector("#title").value + " content = " + document.querySelector("#content").value);

        formTag.submit();
    })

    commentBtn.addEventListener("click", () => {
        location.href = "<c:url value="/commentView"/>?bno=${boardDto.bno}";
    })
    console.log("bno = " + "${boardDto.bno}");
</script>
</html>