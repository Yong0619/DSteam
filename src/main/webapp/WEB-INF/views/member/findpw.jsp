<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div class="l-div1">
			<h2 class="fw-bold" id="fp-h2">비밀번호 찾기</h2>
			<form action="/member/findpw" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div>
					<input type="text" name="userid" placeholder="아이디" required="required" class="input1 form-control"/> 
				</div>
				<div>
					<input type="text" name="email" required="required" placeholder="이메일" class="input1 form-control"/>
				</div>
				<input type="submit" value="비밀번호 찾기" class="j-Btn"/>
			</form>
		</div>
	</div>
	<!-- 모달 추가 -->
	<div id="modal">
		<div id="modalbox">
			<h3>페이지 안내</h3>
			<div id="infotext">
				<c:out value="${msg}" />
			</div>
			<button id="modalclose">닫기</button>
		</div>
	</div>
	<script type="text/javascript">
		let result = '<c:out value="${msg}" />';
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