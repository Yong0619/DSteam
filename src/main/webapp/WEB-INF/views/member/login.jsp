<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div class="l-div1">
			<h2 class="fw-bold">로그인</h2>
			<p id="login-p1" class="fw-bold"><c:out value="${error}"></c:out></p>
			<form action="/login" method="post">
				<p><input type="text" name="username" placeholder="ID" class="input1 form-control"/></p>
				<p><input type="password" name="password" placeholder="Password" class="input1 form-control"/></p>
				<p id="a-login"><input type="checkbox" name="remember-me" />자동 로그인</p>
				<p><input type="submit" value="로그인" id="loginBtn" class="f-size1"/></p>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
			<div id="find-div1">
				<a href="/member/findid">아이디</a> / <a href="/member/findpw">비밀번호 찾기</a>
			</div>
		</div>
	</div>
	<!-- 모달 추가 -->
	<div id="modal">
		<div id="modalbox">
			<h3>페이지 안내</h3>
			<div id="infotext">
				<c:out value="${param.msg}"/>
			</div>
			<button id="modalclose">닫기</button>
		</div>
	</div>
	<script type="text/javascript">
		let result = '<c:out value="${param.msg}"/>';
		console.log(result);
		checkModal(result);
		function checkModal(result) {
			if(!result) return;
			document.querySelector("#modal").style.display = 'block';
		}
		//닫기 누르면 모달창 안보이게 하기
		document.querySelector("#modalclose").addEventListener("click", function () {
			document.querySelector("#modal").style.display = 'none';		
		})
	</script>
<%@ include file="../includes/footer.jsp" %>