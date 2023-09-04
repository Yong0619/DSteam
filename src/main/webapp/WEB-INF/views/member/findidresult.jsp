<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div id="l-div1">
			<h2 id="fr-h2">아이디 찾기</h2>
			<c:choose>
				<c:when test="${param.result eq 'null'}">
					<p class="fr-id">정보가 일치하는 회원이 없습니다.</p>
					<button type="button" onclick="location.href='/index'" class="fr-id">홈으로</button>
				</c:when>
				<c:otherwise>
					<p id="fr-p1">회원님의 아이디는 <b><c:out value="${param.result}" /></b> 입니다.
					<div id="fr-div1">
						<button type="button" onclick="location.href='/member/login'" class="j-Btn">로그인</button>
						<button type="button" onclick="location.href='/member/findpw'" class="j-Btn">비밀번호 찾기</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
<%@ include file="../includes/footer.jsp" %>