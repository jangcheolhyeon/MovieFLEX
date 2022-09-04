<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <!-- 웹폰트 -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
    body{
      background-image: url("<c:url value="/imgs/theater image.jpg"/>");

      background-size:cover;
      color:white;
      display:flex;
      flex-direction:column;
      padding: 0px;
      margin: 0px;
    }

    .loginFrame input{
      margin-bottom:20px;
      height:45px;
      background:transparent;
      border:none;
      border-bottom:1px solid white;
      font-weight:bold;
      color:white;
    }

    .loginFrame input:focus{
      outline:none;
    }

    .loginFrame .password_container{
      border-bottom:1px solid white;
      height:47px;
    }

    /* eyes 아이콘 css */
    .loginFrame #password{
      width:320px;
    }

    .loginFrame .material-icons{
      margin-left: auto;
      position:absolute;
      top:280px;
      padding-bottom:15px;
      cursor:pointer;
      /* 아이콘 드래그 방지 */
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


    .hideIcon{
      display:none;
    }
    /*  */

    .loginFrame button{
      height:40px;
      background-color:#E50914;
      border:1px solid #E50914;
      color:white;
      margin-top:30px;
    }

    .loginFrame .helpLoginBox > a::after{
      content:"|";
      margin-left:15px;
    }

    .loginFrame .helpLoginBox > a:last-child::after{
      content:"";
    }

    .loginFrameFooter{
      margin-top:20px;
    }

    .loginFrameFooter input[type="checkbox"]{
      margin:3px;
      padding:0px;
      height:15px;
    }

    .loginForm{
      display:flex;
      flex-direction:column;
      margin-top:20px;
    }

    .loginFrame .helpLoginBox{
      margin-top:40px;
      display:flex;
      justify-content: space-around;
    }

    .loginFrame .helpLoginBox a{
      color:white;
    }

    .loginFrame .helpLoginBox a:visited{
      text-decoration:none;
    }

    .loginFrame .helpLoginBox a:link{
      text-decoration:none;
    }

    .loginFrame .kakaoLogin{
      margin-top: 50px;
      text-align:center;
    }

    #accountMsg{
      display:block;
      text-align:center;
      font-weight:bold;
      color:red;
    }

    .hide{
      visibility: hidden;
    }



  </style>
  <link rel="stylesheet" href="<c:url value="/css/HeaderOnlyLogo.css"/>"/>
</head>
<body>

<header class="headerTag">
  <div class="timer">
    <span id="timer"></span>
  </div>

  <div id="Logo" class="logo">
    <a href="<c:url value='/'/>">MOVIE FLEX</a>
  </div>

</header>


<div class="loginFrame">
  <div>
    <h3 id="title" class="title">Login</h3>
  </div>
  <span id="accountMsg" class="hide">계정이 일치하지 않습니다!</span>
  <form action="<c:url value='/login/login'/>" method="post" onsubmit="return formCheck(this);" class="loginForm">
    <input type="text" name="id" placeholder="이메일 입력">
    <div class="password_container">
      <input type="password" id="password" name="password" placeholder="비밀번호" />
      <span class="material-icons" id="openEyes">visibility</span>
      <span class="material-icons" id="closeEyes">visibility_off</span>
    </div>
    <input type="hidden" name="toURL" value="${param.toURL}">
    <button>로그인</button>

    <div class="loginFrameFooter">
      <label><input type="checkbox" name="rememberId"> 아이디 기억</label>
    </div>

    <div class="helpLoginBox">
      <a href="">아이디 찾기</a>
      <a href="">비밀번호 찾기</a>
      <a href="<c:url value="/register/add"/>">회원가입</a>
    </div>
  </form>

  <div class="kakaoLogin">
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=f599d21cddbe606e6236245fde6a8309&redirect_uri=http://localhost:8080/ex/kakao/oauth&response_type=code">
      <img src="<c:url value='/imgs/kakao_login_medium_wide.png'/>"/>
    </a>

  </div>
</div>



<script src="<c:url value="/js/timer.js"/>"></script>
  <script>
    // 비밀번호 focus했을때 눈icon나오게
    let openEyes = document.querySelector("#openEyes");
    let closeEyes = document.querySelector("#closeEyes");
    let password = document.querySelector("#password");

    // 처음에 아이콘 없애기
    closeEyes.classList.add("hideIcon");
    openEyes.classList.add("hideIcon");

    // 키를 눌렀을때(tab키를 통해 password로 갈때나 password input을 클릭했을때)
    document.addEventListener("keyup", function(e){
      if(password.value == ""){
        eyesAllHidden();
        password.setAttribute("type", "password");
      } else{
        if(closeEyes.classList.contains("hideIcon")){
          eyesAllHidden();
          openEyes.classList.remove("hideIcon");
        } else{
          eyesAllHidden();
          closeEyes.classList.remove("hideIcon");
        }

      }
    })

    // 눈 아이콘 모두(감은거 뜬거) 숨기는 함수
    let eyesAllHidden = () => {
      closeEyes.classList.add("hideIcon");
      openEyes.classList.add("hideIcon");
    }
    closeEyes.addEventListener("click", openEyesEvent);
    openEyes.addEventListener("click", closeEyesEvent);

    //감은눈 클릭했을때
    function openEyesEvent(){
      console.log("openEyesEvent");
      openEyes.classList.remove("hideIcon");
      closeEyes.classList.add("hideIcon");
      password.setAttribute("type", "password");
    }

    //뜬눈 클릭햇을때
    function closeEyesEvent(){
      console.log("closeEyesEvent");
      openEyes.classList.add("hideIcon");
      closeEyes.classList.remove("hideIcon");
      password.setAttribute("type", "text");
    }



    //  아이디가 db에 있는 정보와 일치하지 않을때
    let errorSpan = document.querySelector("#accountMsg");
    let msg  = "${param.msg}";
    if(msg != ""){
      console.log(msg);
      errorSpan.innerHTML = msg;
      errorSpan.classList.remove("hide");
    }

  </script>
</body>
</html>