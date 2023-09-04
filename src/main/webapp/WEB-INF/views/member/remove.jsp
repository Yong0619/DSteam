<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div class="l-div1">
			<h2 class="fw-bold">회원 탈퇴</h2>
			<form action="remove" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<p><input type="text" name="userid" id="userid" placeholder="아이디" required="required" class="input1 form-control"/></p>
				<p><input type="text" name="userName" id="userName" placeholder="이름" required="required" class="input1 form-control"/></p>
				<p><input type="text" name="email" id="email" placeholder="이메일" required="required" class="input1 form-control"/></p>	
				<p><button type="submit" class="j-Btn">회원탈퇴</button></p>
				<p><button type="button" class="j-Btn"onclick="location.href='/index'">취소</button></p>
			</form>
		</div>
	</div>
<%@ include file="../includes/footer.jsp" %>