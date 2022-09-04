<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="isLogin" value="${sessionScope.id == null || sessionScope.id == '' ? 'SIGN' : 'MY PAGE'}"/>
<c:set var="isLoginURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/register/show' : '/mypage'}"/>
<!DOCTYPE html>
<html>
    <title>MyPage</title>
    <style>
        body{
            background:linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url("<c:url value='imgs/mypage.jpg'/>");
            background-size:cover;
            color:white;
            padding:0;
            margin:0;
        }

        li{
            list-style:none;
        }

        .headerTag{
            display:flex;
            flex-direction:column;
        }

        .top_menu .menu_list{
            display:flex;
        }

        .top_menu .logo{
            font-weight:bold;
            font-size:40px;
            color:red;
            border:3px solid red;
            padding:5px 10px;
            flex-shrink:1;
        }

        .top_menu a:visited{
            text-decoration:none;
        }

        .top_menu a:link{
            text-decoration:none;
        }

        .headerTag .timer{
            font-weight:bold;
            margin: 0 auto;
        }

        .menu_list li{
            display:flex;
            align-items:center;
        }

        .menu_list .menu{
            color:#E50914;
            font-weight: bold;
            font-size:25px;
            margin-right:20px;
            padding:10px;
            flex-shrink: 1;
        }

        .menu_list .menus{
            display:flex;
            margin-left:auto;
        }

        .myInfo{
            margin-top:100px;
            text-align:center;
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

            <div class="menus">
                <li><a href="<c:url value="/movies/main"/>" class="menu_movies_list menu">MOVIES</a></li>
                <li><a href="<c:url value="/board/list"/>" class="menu_board menu">BOARD</a></li>
                <li><a href="<c:url value="${loginOutURL}"/>" class="menu_login menu">${loginOut}</a></li>
                <li><a href="<c:url value="${isLoginURL}"/>" class="menu_mypage menu">${isLogin}</a></li>
            </div>
        </ul>
    </div>
</header>
    <div class="myInfo">
        <h1>id=${user.id}</h1>
        <h1>password=${user.password}</h1>
        <h1>name=${user.name}</h1>
        <h1>email=${user.email}</h1>
        <h1>phone=${user.phone}</h1>
        <h1>birth=${user.birth}</h1>
    </div>



</body>

<script src="<c:url value="/js/timer.js"/>"></script>
<script>
</script>
</html>
