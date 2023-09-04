<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<style><%@include file="/resources/css/style.css"%></style>
<script>
          $(function(){
        	  $('.slider').slick({
        		  slide: 'div',
        		  arrows : true,
        		  autoplay : true,
        		  centerMode: true,
        		  centerPadding: '5px',
        		  slidesToShow: 5
        		});
          })  
</script>
</head>
<body>
	<header class="inner">
		<div>
			<h2><a href="../index"><img src="/resources/image/logo.png" ></a></h2>
			<ul>
			<sec:authorize access="isAnonymous()">
				<li><button type="button" onclick="location.href='/game/list'">게임목록</button></li>
				<li><button type="button" onclick="location.href='/member/login'">로그인</button></li>
				<li><button type="button" onclick="location.href='/member/register'">회원가입</button></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><sec:authentication property="principal.member.userName" />님 반갑습니다!</li>
			</sec:authorize>	
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><button type="button" onclick="location.href='/member/list'">회원관리</button></li>
			</sec:authorize>	
			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
				<li><button type="button" onclick="location.href='/gamestore/list'">내 판매목록</button></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><button type="button" onclick="location.href='/game/list'">게임목록</button></li>
				<li><button type="button" onclick="location.href='/like/list'">찜 목록</button></li>
				<li>
					<form action="/member/view" method="post">
						<input type="hidden" name="userid" value="<sec:authentication property='principal.username'/>" />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button>회원정보</button>
					</form>
				</li>
				<li>
					<form action="/member/logout" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button>로그아웃</button>
					</form>
				</li>
			</sec:authorize>
			</ul>
		</div>
	</header>
	<section class="inner">
		<div id="i-div1">
			<div id="indexbox3">
				<p><a href="/board/freeboardlist" class="fw-bold">자유게시판</a></p>
				<p><a href='/qna/list' class="fw-bold">질문과답변</a></p>
			</div>
		</div>