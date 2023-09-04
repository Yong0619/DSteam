<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div class="l-div2">
			<h2 class="fw-bold">회원정보</h2>
			<form action="modify" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="auth" value="${view.auth}" />
			<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
			<input type="hidden" name="amount" value="${cri.amount}"  />
			<input type="hidden" name="type" value="${cri.type}"  />
			<input type="hidden" name="keyword" value="${cri.keyword}"  />
			<input type="hidden" name="userid" value="${view.userid}"  />
				<table class="l-tbl1">
					<tr>
						<td>아이디</td>
						<td><input type="text" name="userid" value="${view.userid}" readonly="readonly" class="input1 form-control" disabled="disabled"/></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="userpw" required="required" class="input1 form-control"/></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="userpwConfirm" required="required" class="input1 form-control"/></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="userName" value="${view.userName}" readonly="readonly" class="input1 form-control"/></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input type="text" name="email" id="mail" value="${view.email}" required="required" class="input1 form-control"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="button" onclick="location.href='../index'" class="j-Btn2">홈으로</button>
							<button type="submit" class="j-Btn2">회원정보수정</button>
							<button type="button" onclick="location.href='/member/remove'" class="j-Btn2">회원탈퇴</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 모달 추가 -->
	<div id="modal">
		<div id="modalbox">
			<h3>페이지 안내</h3>
			<div id="infotext">
				<c:out value="${param.result}" />
			</div>
			<button id="modalclose">닫기</button>
		</div>
	</div>
	<script type="text/javascript">
		let result = '<c:out value="${param.result}" />';
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