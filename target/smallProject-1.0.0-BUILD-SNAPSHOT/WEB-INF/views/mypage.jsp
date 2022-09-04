<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyPage</title>

    <link rel="stylesheet" href="<c:url value="/css/Header.css"/>"/>
    <style>
        body{
            background:linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url("<c:url value='imgs/mypage.jpg'/>");
            background-size:cover;
            color:white;
            padding:0;
            margin:0;
        }

        .checkAccountContainer{
            position:absolute;
            left:50%;
            top:50%;
            transform:translate(-50%, -50%);
            width:30%;
            height:60%;
        }

        .checkAccountContainer > form{
            height:100%;
            border:3px solid white;
            position:relative;
        }

        .checkAccountContainer > form > h3{
            text-align:center;
            font-size:35px;
            margin-top:100px;
        }

        .checkAccountContainer > form .userId{
            text-align:center;
            font-size:25px;
            font-weight:bold;
            color:gray;
            margin-bottom:90px;
        }

        .checkAccountContainer .errorMsg{
            text-align:center;
            font-size:15px;
            color:red;
            margin-bottom:30px;
        }

        .hidden{
            visibility: hidden;
        }

        .checkAccountContainer .passwordContainer{
            display:flex;
            flex-direction:column;
            background:transparent;
            width:80%;
            margin:0 auto;
        }

        .checkAccountContainer .passwordContainer > p{
            margin:0;
            padding:5px;
            font-size:13px;
        }

        .checkAccountContainer .passwordContainer .password{
            background:transparent;
            color:white;
            border:none;
            border-bottom:3px solid white;
            /*height:60px;*/
            font-size:40px;
        }


        .checkAccountContainer .passwordContainer .password:focus{
            outline:none;
        }

        .checkAccountContainer .btns{
            display:flex;
            justify-content: center;
            margin-top:50px;
        }

        .checkAccountContainer .btns .btn{
            background:transparent;
            color:white;
            border-radius: 5px;
            font-weight:bold;
            border:2px solid white;
            padding:5px 10px;
            cursor:pointer;
        }

    </style>

</head>
<body>
<header class="headerTag">
    <div class="timer">
        <span id="timer"></span>
    </div>

    <div id="Logo" class="top_menu">
        <ul class="menu_list">
            <li><a href="<c:url value="/"/>" class="logo">MOVIE FLEX</a></li>
        </ul>
    </div>
</header>


<div class="checkAccountContainer">
    <form id="form" action="<c:url value="/mypage"/>" method="post" onsubmit="return checkId()">
        <h3>지금 로그인된 계정은</h3>
        <p id="userId" class="userId" name="id"></p>
        <p class="errorMsg hidden" id="errorMsg">비밀번호가 틀렸습니다!</p>
        <div class="passwordContainer">
            <p>비밀번호</p>
            <input type="password" id="password" class="password" name="password"/>
        </div>
        <div class="btns">
            <button id="btn" class="btn">확인</button>
        </div>
    </form>
</div>
</body>

<script src="<c:url value="/js/timer.js"/>"></script>
<script>
    let id = "${id}";
    console.log(id);

    //세션에 저장된 아이디를 끌고와서 viwe에 뿌려줌
    let userId = document.querySelector("#userId");
    userId.innerHTML = id;


    let form = document.querySelector("#form");
    let btn = document.querySelector("#btn");
    let pwd = document.querySelector("#password");
    let errorMsg = document.querySelector("#errorMsg");

    function checkId(){
        console.log(pwd.value.length);
        if(pwd.value.length < 4){
            errorMsg.classList.remove("hidden");
            return false;
        }
        return true;
    }

//    db정보와 일치하지 않아서 error가 넘어올때
    let msg = "${param.error}";
    console.log(msg);
    if(msg != ""){
        errorMsg.classList.remove("hidden");
    }



</script>
</html>
