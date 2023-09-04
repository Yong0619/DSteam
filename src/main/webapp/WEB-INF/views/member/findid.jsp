<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div class="l-div1">
			<h2 class="fw-bold">아이디 찾기</h2>
			<form action="/member/findid" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div>
					<input type="text" name="userName" placeholder="이름" required="required" class="input1 form-control"/> 
				</div>
				<div>
					<input type="text" name="email" required="required" placeholder="이메일" class="input1 form-control"/>
				</div>
				<div>
					<input type="submit" value="아이디 찾기" class="j-Btn"/>
				</div>
			</form>
		</div>
	</div>
<%@ include file="../includes/footer.jsp" %>