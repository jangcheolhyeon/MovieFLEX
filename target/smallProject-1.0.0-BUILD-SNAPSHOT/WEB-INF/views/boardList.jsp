<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginout" value="${sessionScope.id == null || sessionScope.id == '' ? 'login' : 'logout'}"/>
<c:set var="loginoutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login/login' : '/login/logout'}"/>

<!DOCTYPE html>
<html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 웹폰트 -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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

        /* 테이블 */
        .board_container{
            width:80%;
            margin:0 auto;
        }

        .board_container .search_container{
            margin-bottom:20px;
            display:flex;
            justify-content: flex-end;
        }

        .board_container .search_container > input{
            border:none;
            color:white;
            border-bottom:1px solid white;
            font-weight:bold;
            background-color:transparent
        }

        .board_container .search_container > input:focus{
            outline:none;
        }
        .board_container .search_container > input::placeholder{
            color:white;
        }

        /* .board_container .search_container button{
            background-color:white;
            color:#E50914;
            font-weight:bold;
        } */

        .board_container #tableHtml td a{
            color:white;
        }

        #tableHtml{
            border-top:1px solid black;
            border-bottom:1px solid black;
            border-collapse: collapse;
            width:100%;
        }

        #tableHtml th{
            height:50px;
            border-bottom:1px solid black;
            padding:5px;
            font-weight:bold;
            font-size:20px;

        }

        #tableHtml td{
            height:50px;
            text-align:center;
            border-bottom:1px solid lightgray;
            padding:5px;
        }

        #tableHtml td a{
            text-decoration: none;
        }

        .bno{
            width:10%;
        }
        .title{
            width:50%;
        }
        .writer{
            width:20%;
        }
        .view_cnt{
            width:10%
        }
        .reg_date{
            width:10%;
        }

        .board_container{
            margin-bottom:100px;
        }

        .board_container h1{
            text-align:center;
        }

        .board_container .wrt_container{
            margin-top:10px;
            text-align:right;
            margin-bottom:10px;
        }

        .board_container .wrt_container button{
            background:transparent;
            color:white;
            border-radius: 5px;
            font-weight:bold;
            border:2px solid white;
            padding:5px 10px;
        }

        .board_container .wrt_container button:hover{
            cursor:pointer;
        }

        .board_container .nav_container{
            text-align:center;
            margin:30px 0 60px 0;
        }

        .board_container .nav_container a{
            text-decoration:none;
        }

        #tableHtml td:nth-child(2){
            text-align:left;
            padding-left: 30px;
        }

        .nav_container a{
            color:white;
            padding:5px;
            font-size:20px;
        }

        .nav_container a:hover{
            border-bottom: 1px solid white;
        }


    /*    selectBox 꾸미기*/
        .searchBox {
            display:flex;
            justify-content:center;
        }

        .searchBox .select{
            height:35px;
            border-radius: 4px;
            border: 2px solid white;
            background:transparent;
            color:white;
            font-weight:bold;
            text-align:center;
        }

        .searchBox .select option{
            background-color: black;
            color:white;
            font-weight:bold;
        }

        .searchBox .keyword{
            width:350px;
            height:30px;
            border:2px solid white;
            border-radius: 4px;
            background: transparent;
            color:white;
            font-weight:bold;
        }

        .searchBox .searchBtn{
            height:30px;
            background: transparent;
            color:white;
            border:none;
            position:relative;
        }

        .searchBox .searchBtn .material-icons{
            position:absolute;
            transform: scale(1.5);
            top:0;
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
                <li><a href="<c:url value='/mypage'/>" class="menu">MY PAGE</a></li>
            </div>
        </ul>
    </div>
</header>
<div class="board_container">
    <h1>This is BOARD List</h1>
        <div class="wrt_container">
            <button type="button" id="writeBtn">글쓰기</button>
        </div>
    <div class="table_container">
        <table id="tableHtml">
            <tr>
                <th class="bno">번호</th>
                <th class="title">제목</th>
                <th class="writer">작성자</th>
                <th class="view_cnt">조회수</th>
                <th class="reg_date">작성일</th>
            </tr>
            <c:forEach items="${list}" var="boardDto">
                <tr>
                    <td> ${boardDto.bno} </td>
                    <td><a href="<c:url value="/board/read"/>?bno=${boardDto.bno}&page=${ph.sc.page}&pageSize=${ph.sc.pageSize}"> <c:out value='${boardDto.title}'/> </a></td>
                    <td> ${boardDto.writer} </td>
                    <td> ${boardDto.view_cnt} </td>
                    <td> ${boardDto.reg_date} </td>
                </tr>
            </c:forEach>
        </table>
    </div>
        <br>
    <br>
    <div class="nav_container">
        <c:if test="${ph.showPrev}">
            <a href="<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&ltcc;</a>
        </c:if>

        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
<%--            <c:if test="${i == ph.sc.page}">--%>
<%--                <a href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>" style="color:red;">${i}</a>--%>
<%--            </c:if>--%>
<%--            <a href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>--%>
            <c:choose>
                <c:when test="${i == ph.sc.page}">
                    <a href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>" style="color:red;">${i}</a>
                </c:when>

                <c:otherwise>
                    <a href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>


        <c:if test="${ph.showNext}">
            <a href="<c:url value="/board/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gtcc;</a>
        </c:if>
    </div>

    <div class="searchBox">
        <form id="searchForm">
            <select name="option" class="select">
                <option value='T' ${ph.sc.option == "T" ? "selected" : ""}>제목</option>
                <option value='W' ${ph.sc.option == "W" ? "selected" : ""}>작성자</option>
                <option value='A' ${ph.sc.option == "A" ? "selected" : ""}>내용 & 제목</option>
            </select>
            <input type="text" name="keyword" id="keyword" class="keyword" value="${ph.sc.keyword}" />
            <button type="button" id="searchBtn" class="searchBtn">
                <span class="material-icons">search</span>
            </button>
        </form>
    </div>

</div>
</body>
<script src="<c:url value="/js/timer.js"/>"></script>
<script>
    let writeBtn = document.querySelector("#writeBtn");
    let searchBtn = document.querySelector("#searchBtn");

    writeBtn.addEventListener("click", (e) => {
        location.href = "<c:url value="/board/write"/>";
    })

    searchBtn.addEventListener("click", (e) => {
        let form = document.querySelector("#searchForm");

        form.setAttribute("method", "GET");
        form.setAttribute("action", "<c:url value="/board/list"/>");
        form.submit();
    })

</script>
</html>