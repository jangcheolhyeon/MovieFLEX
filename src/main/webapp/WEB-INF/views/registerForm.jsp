<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
  <style>
    body{
      background-image: url("<c:url value='/imgs/theater image2.jpg'/>");

      background-size:cover;
      color:white;
      display:flex;
      flex-direction:column;
      padding: 0;
      margin: 0;
    }

    .id_container{
      display:flex;
      flex-direction:column;
      /*margin-bottom:5px;*/
    }

    .id_container:not(:first-of-type){
        margin-bottom:15px;
    }

    .id_container span{
      font-size:13px;
      color:red;
    }

    .loginFrame .registerError{
      text-align:center;
      margin-bottom:10px;
      color:red;
      font-size:16px;
    }

    .loginFrame .registerError #registerError{
      text-align: center;
      color:red;
      font-weight: bold;
      margin-bottom:10px;
    }


    .loginFrame input{
      /*margin-bottom:20px;*/
      height:45px;
      background:transparent;
      border:none;
      border-bottom:1px solid white;
      font-weight:bold;
      color:white;
    }

    .loginFrame button{
      margin-top:50px;
      height:40px;
      background-color:#E50914;
      border:1px solid #E50914;
      color:white;
      font-size:15px;
      font-weight:bold;
    }

    .loginForm{
      display:flex;
      flex-direction:column;
    }

    .hide{
      visibility: hidden;
    }
  </style>
    <link rel="stylesheet" href="<c:url value="/css/HeaderOnlyLogo.css"/>"/>
  <title>Register</title>
</head>
<body>
<header class="headerTag">
  <div class="timer">
    <span id="timer"></span>
  </div>

  <div id="Logo" class="logo">
    <a href="<c:url value="/"/>">MOVIE FLEX</a>
  </div>

</header>

<div class="loginFrame">
  <div>
    <h3 id="title" class="title">REGISTER</h3>
  </div>
  <div class="registerError">
    <span id="registerError">
        <c:if test="${msg != ''}">
            <span>${msg}</span>
        </c:if>
    </span>
  </div>
    <form:form action="${pageContext.request.contextPath}/register/show" method="POST" modelAttribute="user" class="loginForm" id="form" autocomplete="off">
        <div class="id_container ">
            <form:input path="id" id="id" name="id" placeholder="아이디" />
            <span class="idCheck hide">사용가능합니다.</span>
            <span><form:errors path="id" /></span>
        </div>
        <div class="id_container">
            <form:password path="password" id="password" name="password"  placeholder="비밀번호"/>
            <span><form:errors path="password" /></span>
        </div>
        <div class="id_container">
            <form:input path="name" id="name" name="name" placeholder="홍길동" />
            <span><form:errors path="name" /></span>
        </div>
        <div class="id_container">
            <form:input path="email" id="email" name="email" placeholder="example@naver.com" />
            <span><form:errors path="email" /></span>
        </div>
        <div class="id_container">
            <form:input path="phone" id="phone" name="phone" placeholder="010-1234-5678" />
            <span><form:errors path="phone" /></span>
        </div>
        <div class="id_container">
            <form:input path="birth" id="birth" name="birth" placeholder="2022-08-12" />
            <span><form:errors path="birth" /></span>
        </div>

        <input type="hidden" name="toURL" value="${param.toURL}">
        <button id="registerBtn">회원 가입</button>

    </form:form>
</div>





<script src="<c:url value="/js/timer.js"/>"></script>
<script>
  //form을 onsubmit했을때 js에서 검사하는 로직
  function formCheck(){
    let errorTag = document.querySelector("#registerError");

    let id = document.querySelector("#id");
    let password = document.querySelector("#password");
    let name = document.querySelector("#name");
    let email = document.querySelector("#email");
    let phone = document.querySelector("#phone");
    let birth = document.querySelector("#birth");

    if(id.value == ""){
      alert("id를 입력하세요");
      errorTag.innerHTML = "아이디는 영문 대소문자와 숫자 4~12자리로 입력해야 합니다.";
      id.focus();
      return false;
    }

    //아이디가 중복일때
    if(receiveCnt >= 1){
      alert("아이디가 중복입니다!");
      errorTag.innerHTML = "다른 아이디를 사용해주세요";
      id.focus();
      return false;
    }


    let idRegExp= /^[a-zA-z0-9]{4,12}$/; //아이디 유효성 검사
    if(!idRegExp.test(id.value)){
      alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해야 합니다.");
      errorTag.innerHTML = "아이디는 영문 대소문자와 숫자 4~12자리로 입력해야 합니다.";
      id.focus();
      return false;
    }

    //비밀번호 체크
    let pwdRegExp = /^[a-zA-z0-9]{4,12}$/; //비밀번호 유효성 검사
    if(!pwdRegExp.test(password.value)){
      alert("패스워드는 영문 대소문자와 숫자 4~12자리로 입력해야 합니다.");
      errorTag.innerHTML = "패스워드는 영문 대소문자와 숫자 4~12자리로 입력해야 합니다.";
      password.value = "";
      password.focus();
      return false;
    }



    //이름 체크
    let nameRegExp = /^[가-힣]{2,4}$/; // 이름 유효성 검사(한글)
    // let reg = /^[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; // (영문)
    // let reg = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$ // (한글+영문)
    if(!nameRegExp.test(name.value)){
      alert("이름을 확인해주세요");
      errorTag.innerHTML = "이름을 확인해주세요.";
      name.focus();
      return false;
    }


    //이메일체크
    let emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/; // 이메일 유효성 검사
    if(!emailRegExp.test(email.value)){
      alert("이메일을 확인해주세요");
      errorTag.innerHTML = "이메일을 확인해주세요.";
      email.focus();
      return false;
    }


    //휴대폰번호 체크
    let phoneRegExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/; // 휴대폰번호 유효성 검사
    if(!phoneRegExp.test(phone.value)){
      alert("휴대폰 번호를 확인해주세요");
      errorTag.innerHTML = "휴대폰 번호를 확인해주세요.";
      phone.focus();
      return false;
    }

    //생년월일 체크
    let birthRegExp = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/; // 1997-11-19 생년월일 유효성 검사
    if(!birthRegExp.test(birth.value)){
      alert("생년월일을 확인해주세요");
      errorTag.innerHTML = "생년월일을 확인해주세요.";
      birth.focus();
      return false;
    }

    alert("btn");
  }



// Ajax를 통한 id 중복검사
  const id = document.querySelector("#id");
  document.addEventListener("keyup", overLapId);
  let idReceiveCnt = 0;

  function overLapId(){
    let idCheck = document.querySelector(".idCheck");

    if(id.value.length != 0){
      // console.log(id.value);
      idCheck.classList.remove("hide");

      let xhr = new XMLHttpRequest();
      xhr.open("get", "<c:url value="/register/overlapCheck"/>?id=" + id.value);
      xhr.send();

      xhr.onload = () => {
        if(xhr.status == 200){
          // console.log(JSON.parse(xhr.response));
          idReceiveCnt = JSON.parse(xhr.response);

          //중복일때 로직
          if(idReceiveCnt >= 1){
            idCheck.innerHTML = "중복입니다.";
            idCheck.style.color = "red";
          } else{
            idCheck.innerHTML = "사용가능합니다.";
            idCheck.style.color = "aqua";
          }

        } else{
          console.log("fail");
        }
      }

    } else{
      idCheck.classList.add("hide");
    }
  }



</script>
</body>
</html>