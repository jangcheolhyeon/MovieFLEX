<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login/login' : '/login/logout'}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            top:0;
            left:0;
            width:100%;
            height:100%;
        }

        body a{
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

        .searchForm{
            text-align:center;
            margin-top:150px;
            margin-bottom:200px;
        }

        .searchForm #keywordText{
            background:transparent;
            width:30%;
            height:30px;
            border:none;
            border-bottom:1px solid white;
            font-weight:bold;
            font-size:30px;
            text-align:center;
            padding-bottom:10px;


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

        .searchForm #keywordText:focus{
            outline:none;
        }

        .searchForm #keywordText::placeholder{
            color:white;
        }

        .searchForm .searchBtn{
            display:none;
        }

        /* 영화 데이터 끌고오는 코드 css */
        #loading {
            position:absolute;
            top:50%;
            left:50%;
            margin-left:-25px;
            margin-top:-25px;
            width: 50px;
            height: 50px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            -webkit-animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { -webkit-transform: rotate(360deg); }
        }
        @-webkit-keyframes spin {
            to { -webkit-transform: rotate(360deg); }
        }

        #textDiv{
            display:flex;
            flex-wrap: wrap;
            /* justify-content: center; */
        }

        .movieDiv{
            display:flex;
            flex:1 35%;
            margin:50px 100px;
            width:30%;
            padding:20px;
            background-color:rgba(0,0,0,0.85);
            border-radius:20px;
            color:white;
        }

        .movieDiv img{
            position: relative;
            top:-50px;
            left:-50px;
            height:345px;
        }

        .movieDiv .movie_data a{
            text-decoration:none;
        }

        .movieDiv h1{
            display:inline;
            color:white;
        }

        .movieDiv h1:hover{
            cursor:pointer;
            text-decoration:underline;
            text-underline-position:under;
            text-decoration-color:white;
            color:white;
        }

        .hide{
            display:none;
        }

        /*.modalContainer{*/
        /*    top:50%;*/
        /*    left:50%;*/
        /*    transform:translate(-50%, -50%);*/
        /*    position:fixed;*/
        /*    overflow:hidden;*/
        /*    height:300px;*/
        /*    width:300px;*/
        /*}*/

        .showDetail{
            position:fixed;
            display:flex;
            justify-content:center;
            align-items: center;
            top:0;
            left:0;
            height:100%;
            width:100%;
            background-color:rgba(0, 0, 0, 0.7);
            z-index:100;
        }

        .modalContainer .modal{
            height:700px;
            width:1200px;
            background-color:rgba(0,0,0);
            border-radius:10px;
            display:flex;
            flex-direction:column;
            overflow-y:auto;


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

        .modal .modal_off{
            position:fixed;
            margin-left:20px;
            margin-top:20px;
        }

        .modal .modal_title{
            text-align:center;
            font-size:50px;
            margin-bottom:100px;
        }

        .modal .modal_image{
            display:block;
            margin:0 auto;
        }

        .modal .modal_desc{
            padding-top:100px;
            padding-bottom:100px;
            margin:0 auto;
            width:85%;
            font-weight:bold;
            font-size:25px;
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
                <li><a href="<c:url value='/mypage'/>" class="menu">MY PAGE</a></li>
            </div>
        </ul>
    </div>
</header>
<!-- api 데이터를 완전히 import하지 않았을때 -->
<div class="mainBody">
    <div id="loading" class="loading">
    </div>

    <div id="notLoading">
        <form id="form" class="searchForm">
            <input type="text" id="keywordText" placeholder="보고싶은 영화를 검색하세요."/>
            <button type="button" class="searchBtn" id="searchBtn">검색</button>
        </form>

        <!-- 영화 api가 들어갈 div -->
        <div id="textDiv">

        </div>
    </div>

    <%--모달창--%>
    <div class="modalContainer hide">
        <div class="modal">
            <span>x</span>

        </div>
    </div>
</div>



<script src="<c:url value="/js/timer.js"/>"></script>
<script>
    // 영화 데이터 api를 끌고오는 코드
    let textDiv = document.querySelector("#textDiv");
    let keyword = document.querySelector("#keywordText");
    let bodyTag = document.querySelector("body");
    let loading = document.querySelector("#loading");
    let notLoading = document.querySelector("#notLoading");
    let moviesNameArray = [];
    let movieArray;

    notLoading.style.display = "none";

    // fetch로 api를 받아왔을대 수행해야할 것들
    fetch("https://yts.mx/api/v2/list_movies.json")
        .then((response) => {return response.json()})
        .then((result) => {
            console.log(result);
            //key : id, medium_cover_image, rating, runtime, summary, title
            // console.log(result.data.movies);
            movieArray = result.data.movies;
            textDiv.innerHTML = textFunc(result.data.movies);
            loading.style.display="none";
            notLoading.style.display="block";
            pushMovies();

        })
        .catch(() => console.log(new Error("error")));


    // api를 fetch를 통해서 받아온 리스트를 element로 만들어서 body에 넣어줌
    let textFunc = (data) => {
        let totalTag = "";

        data.forEach(e => {
            let summary = e.summary.length >= 250 ? e.summary.substr(0, 250) + "..." : e.summary;
            let movieId=e.id;
            console.log(movieId);
            // console.log(summary);
            let divTag = "<div class='movieDiv' id=" + "'" + e.id + "'" + ">";
            divTag += "<img src=" + e.medium_cover_image + " class='image'/>";
            divTag += "<div class='movie_data''>";
            <%--divTag += "<a href='${pageContext.request.contextPath}/movies/detail'>";--%>
            <%--divTag += "<a href='<c:url value="/movies/detail?id="/>'" + id + ">";--%>
            <%--divTag += "<a href='javascript:void(window.open(" + "`" + "<c:url value='/movies/detail?title='/>" + e.id + "`" + "," + "`popupMovieDetail`, `width=#`, `height=#`))' >";--%>
            <%--divTag += "<a href='${pageContext.request.contextPath}/movies/detail" + "?title=" + e.id + "'>";--%>
            divTag += "<a href='#' id='titleLink' class='titleLink'>";
            divTag += "<h1 class='title'>" + e.title_long + "</h1>";
            divTag += "</a>";
            divTag += "<p class='summary'>" + summary + "</p>";
            divTag += "<p class='genres'>Genres" + " : " + e.genres + "</p> ";
            divTag += "<p class='rating'>Rating" + " : " + e.rating + "</p> ";
            divTag += "<p class='runtime'>Runtime" + " : " + e.runtime + "min" + "</p>";
            divTag += "</div>";
            totalTag += divTag + "</div>";
        });

        return totalTag;

    }

    //영화 리스트를 moviesNameArray에 넣기
    function pushMovies(){
        let movies = Array.from(document.querySelectorAll(".title"));
        // for(let i=0;i<movies.length;i++){
        //     moviesNameArray.push(movies[i].innerHTML);
        // }
        movies.map((element) => {
            moviesNameArray.push(element.innerHTML);
        })

        console.log(moviesNameArray);

    }


    //검색파트

    keyword.addEventListener("keyup", searchMovie);



    //keyup했을대 이름이 맞는 영화리스트들이 나오게
    function searchMovie(){
        console.log(keyword.value.length);
        let moviesDiv = Array.from(document.querySelectorAll(".movieDiv"));

        if(!keyword.value.length == 0){
            let keywordValue = keyword.value;
            // console.log(keywordValue);
            //대소문자 제거(다 소문자로 치환)
            keywordValue = keyword.value.toLowerCase();


            //맵을 통해 movieDiv 배열을 하나하나 꺼내서 비교하여 keywordValue의 내용이 포함되어 있으면 그 요소를 hiddenMovie css를 없앤다.
            moviesDiv.map((element) => {
                element.classList.add("hiddenMovie");
                //title이름도 대소문자 제거(다 소문자로 치환)
                movieTitle = element.querySelector(".title").innerHTML.toLowerCase();

                if(movieTitle.includes(keywordValue)){
                    element.classList.remove("hiddenMovie");
                }

            })

        } else{
            moviesDiv.map((element) => {
                element.classList.remove("hiddenMovie");
            })
        }
    }


//    타이틀 누르면 모달창 뜨게 하기
    let titleLink = document.querySelector("#titleLink");
    textDiv.addEventListener("click", function(e){
        if(e.target.className == "title"){
            let clickId = e.target.parentElement.parentElement.parentElement.id;
            e.preventDefault();

            //클릭한 타켓의 id와 일치하는 정보들 뽑아내기(모달 창 만들기)
            movieArray.map((e) => {
                if(e.id == clickId){
                    console.log(e);

                    let modal = document.querySelector(".modal");
                    modal.innerHTML = modalBox(e);


                    // 모달박스 안에 들어갈 내용들을 동적으로 만들어서 넣어주기
                    function modalBox(e){
                        let modalTag = "";
                        // x표 만들기
                        modalTag += "<span class='modal_off'>" + "X" + "</span>";
                        modalTag += "<h1 class='modal_title'>" + e.title + "</h1>";
                        modalTag += "<div class='modal_content'>";
                        modalTag += "<img src=" + e.large_cover_image + " class='modal_image'/>";
                        modalTag += "<p class='modal_desc'>" + e.description_full + "</p>";
                        modalTag += "</div>";

                        return modalTag;
                    }

                }
            })


            //x표 누르면 모달창 꺼지게 하기
            let modalOff = document.querySelector(".modal_off");
            modalOff.addEventListener("click", () => {
                modalContainer.classList.add("hide");
                modalContainer.classList.remove("showDetail");
            })


            // 모달창 없는 상태에서 타이틀 눌럿을때 모달창 띄우기
            let modalContainer = document.querySelector(".modalContainer");
            modalContainer.classList.remove("hide");
            modalContainer.classList.add("showDetail");
        }
    })


</script>
</form>
</body>
</html>