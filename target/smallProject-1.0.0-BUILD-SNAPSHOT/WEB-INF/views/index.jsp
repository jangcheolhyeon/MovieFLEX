<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="isLogin" value="${sessionScope.id == null || sessionScope.id == '' ? 'SIGN' : 'MY PAGE'}"/>
<c:set var="isLoginURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/register/add' : '/mypage'}"/>
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

        .slide_container{
            margin-top:100px;
        }

        .slide_container > h3{
            font-size:30px;
            text-align:center;
        }

        .slide_container #slideShow > ul{
            padding:0px;
            margin: 0 auto;
            text-align: center;
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
                    <li><a href="<c:url value="${loginOutURL}"/>" class="menu_login menu">${loginOut}</a></li>
                    <li><a href="<c:url value="${isLoginURL}"/>" class="menu_mypage menu">${isLogin}</a></li>
                </div>
            </ul>
        </div>
    </header>

    <div class="slide_container">
        <h3>NEW Movies</h3>

        <!-- 포스터 슬라이드를 구현할 div -->
        <div id="slideShow">

        </div>

    </div>
</body>
    <script src="<c:url value="/js/timer.js"/>"></script>
    <script>
        //영화 포스터 array
        let photoArr = [];
        let slideShow = document.querySelector("#slideShow");

        //영화 포스터 fetch로 뽑아내기
        fetch("https://yts.mx/api/v2/list_movies.json")
            .then((response) => {return response.json()})
            .then((result) => {
                //promise라서 동기적으로 실행된다. 슬라이드 로직도 여기에 넣어줘야됨(영화가 fetch를 통해 받아오기 때문에)
                makeMoviesArray(result.data.movies);
                slideShow.innerHTML = makeHTML();
                carousel();
            });


        //포스터 이미지를 photoArr에 넣기
        function makeMoviesArray(movies){
            movies.map((element) => {
                photoArr.push(element.medium_cover_image);
            })
        }


        function makeHTML(){
            let HTMLTag = "<ul class='slider'>";
            photoArr.forEach((element) => {
                HTMLTag += "<li class='slides_Img'>";
                HTMLTag += "<img src=" + element + " alt='poster'/>";
                HTMLTag += "</li>"
            });

            return HTMLTag + "</ul>";
        }




        //230 * 345

        let slideIndex = 0;
        function carousel() {
            let i;
            let x = document.getElementsByClassName("slides_Img");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > x.length) {slideIndex = 1}
            x[slideIndex-1].style.display = "block";
            setTimeout(carousel, 2000); // Change image every 2 seconds
        }
    </script>
</html>