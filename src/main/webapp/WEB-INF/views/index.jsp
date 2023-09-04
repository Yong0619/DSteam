<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./includes/header.jsp" %>
		<div id="i-div2">
			<h2>TOP 5</h2>
			<ul class="indexbox" id="indexbox1">
				<c:forEach items="${ top }" var="top">
					<li onclick="location.href='/game/view?gnum=${top.gnum}'" style="cursor: pointer;">
						<img src="/display?fileName=${top.fullname}" class="listImg1"/>
						<p>${top.title}</p>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div id="indexbox2">
			<h2>최근 등록된 게임</h2>
			<div class="slider indexbox">
				<c:forEach items="${ last }" var="last" varStatus="loop">
				<div id="s-div1">
					<a href="/game/view?gnum=${last.gnum}">
						<img src="/display?fileName=${last.fullname}" class="listImg2"/>
						<p>${last.title}</p>
					</a>
				</div>
				</c:forEach>
			</div>
		</div>
		<!-- 모달 추가 -->
		<div id="modal">
			<div id="modalbox">
				<h3 class="fw-bold">페이지 안내</h3>
				<div id="infotext">
					<c:out value="${param.result}"/>
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
<%@ include file="./includes/footer.jsp" %>