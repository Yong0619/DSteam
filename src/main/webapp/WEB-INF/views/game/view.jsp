<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div id="gameinfo" class="mb-3">
		<img src="/display?fileName=${view.fullname}" class="listImg3"/>
		<div>
			<div id="gi-title">
				<h1 class="form-control form-width9 disable-div fw-bold mg-bt3 mg-left1"><c:out value="${view.title}" /></h1>
				<div id="like">
					<sec:authorize access="isAuthenticated()">
					<div>
					<c:choose>
						<c:when test="${ empty like }">
							<form method="post" action="/like/register">
							<sec:authentication property="principal" var="pinfo"/>
							<input type="hidden" name="gnum" value="${ view.gnum }" />
							<input type="hidden" name="title" value="${ view.title }" />
							<input type="hidden" name="price" value="${ view.price }" />
							<input type="hidden" name="releasedate" value="${ view.releasedate }" />
							<input type="hidden" name="userid" value="${ pinfo.username }" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn-reset">
								<img src="/resources/image/pngegg.png" alt="" class="btn-width1"/>
							</button>
							</form>
						</c:when>
						<c:otherwise>
							<form method="post" action="/like/remove">
							<input type="hidden" name="lnum" value="${ likeinfo.lnum }" />
							<input type="hidden" name="gnum" value="${ view.gnum }" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn-reset">
								<img src="/resources/image/pngegg_red.png" alt="" class="btn-width1"/>
							</button>
							</form>
						</c:otherwise>
					</c:choose>	
					</div>
					</sec:authorize>
				</div>
			</div>
			<div id="gameinfo-div1">
				<div id="gameinfo-div2">
					<p class="form-width7 f-size1">개발사 : <c:out value="${view.developer}" /></p>
					<p class="form-width7 f-size1">플랫폼 : <c:out value="${view.platform}" /> / 장르 : <c:out value="${view.genre}" /></p>
					<p class="form-width7 f-size1">공식 가격 : <c:out value="${view.price}" /> / 발매일 :
						<fmt:parseDate value="${ view.releasedate }" var="releasedate" pattern="yyyy-MM-dd" />
					 	<fmt:formatDate value="${ releasedate }" pattern="yyyy.MM.dd" />
					</p>
				</div>
				<div id="meta"><c:out value="${view.metascore}" /></div>
			</div>
		</div>
	</div>
	<div><iframe width='1200' height='675' src='${view.youtube}?
		&autoplay=1&mute=1&cc_lang_pref=kr&cc_load_policy=1' frameborder='0' allowfullscreen>
	</iframe></div>
	<div class="mb-4 mg-top1">
		<pre><c:out value="${view.content}" /></pre>
	</div>
	<!-- 소감 영역 -->
	<sec:authentication property="principal" var="pinfo"/>
	<sec:authorize access="isAuthenticated()">
	<div class="mb-3">
		<div class="card bg-light">
			<div class="card-body">
				<form action="/comment/register" method="post" class="mb-4">	
					<input type="hidden" name="gnum" value="${ view.gnum }" />
					<input type="hidden" name="userid" value="${ pinfo.username }" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="text-flex">
						<textarea class="form-control" rows="3" name="content"></textarea>
						<input type="submit" value="등록">
					</div>
				</form>
				<div>
					<div>
						<c:if test="${ empty commentlist }">
							<div class="ms-3">
								등록된 소감이 없습니다.
							</div>
						</c:if>
						<c:forEach items="${ commentlist }" var="commentlist" varStatus="loop">
							<div class="ms-3">
								<div class="fw-bold f-size4">${ commentlist.userid }<span class="f-size3 mg-left2"><fmt:formatDate value="${ commentlist.regdate }" pattern="yyyy.MM.dd" /></span></div>
								<div class="commentflex">
									${ commentlist.content }
									<c:if test="${pinfo.username eq commentlist.userid || pinfo.username eq 'admin'}">
									<form action="/comment/remove" method="post">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="cnum" value="${ commentlist.cnum }"/>
										<input type="hidden" name="gnum" value="${ view.gnum}" />
										<button type="submit" onclick="delete()" class="commentflexBtn">X</button>
									</form>
									</c:if>
							</div>
						</div>	
					</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
	<div class="mb-5">
		<div class="card bg-light">
			<div class="card-body">
				<div class="text-flex mb-4">
					<textarea class="form-control" rows="3" name="content" placeholder="소감을 남기시려면 로그인을 해주세요!"></textarea>
					<input type="submit" value="등록" disabled="disabled">
				</div>
				<div>
					<div>
						<c:if test="${ empty commentlist }">
							<div class="ms-3">
								등록된 소감이 없습니다.
							</div>
						</c:if>
						<c:forEach items="${ commentlist }" var="commentlist" varStatus="loop">
							<div class="ms-3">
								<div class="fw-bold f-size4">${ commentlist.userid }<span class="f-size3 mg-left2"><fmt:formatDate value="${ commentlist.regdate }" pattern="yyyy.MM.dd" /></span></div>
								<div class="commentflex">
									${ commentlist.content }
								</div>
							</div>
						</c:forEach>	
					</div>
				</div>
			</div>
		</div>
	</div>
	</sec:authorize>
	<!-- 소감 영역 끝 -->
	<!-- 스토어 영역 시작-->
	<div>
		<div class="board-list2 bg-light">
			<table class="mg-bt3" id="gv-table1">
				<tr>
					<td class="btd7 fw-bold">스토어</td>
					<td class="btd3 fw-bold text-center">판매가격</td>
					<td class="btd3 fw-bold text-center">택배비</td>
				</tr>
				<c:if test="${ empty list }">
					<tr>
						<td colspan="4">등록된 스토어가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${ list }" var="list">
				<tr>
					<td onclick="window.open('${list.storeurl}')" style="cursor: pointer;" class="btd7">${list.store}</td>
					<td onclick="window.open('${list.storeurl}')" style="cursor: pointer;" class="btd3 text-center">${list.price}</td>
					<td onclick="window.open('${list.storeurl}')" style="cursor: pointer;" class="btd3 text-center">${list.courierfee}</td>	
					<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq list.userid || pinfo.username eq 'admin'}">
					<td>
						<form action='/gamestore/modify?snum=${list.snum}'>
						<input type="hidden" name="snum" value="${list.snum}">
						<input type="hidden" name="gnum" value="${view.gnum}">
							<button class="btn-width3 btn-height2">수정</button>
						</form>
						<form method="post" action="/gamestore/remove">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="snum" value="${list.snum}">
						<input type="hidden" name="gnum" value="${view.gnum}">
							<button class="btn-width3 btn-height2">삭제</button>
						</form>
					</td>
					</c:if>
					</sec:authorize>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<!-- 스토어 영역 끝 -->
	<div class="mg-top1 text-center">
		<button onclick="location.href='/game/list'" class="btn-width5 btn-height4">게임 목록으로 돌아가기</button>
	</div>
	<!-- 모달 추가 -->
	<div id="modal">
		<div id="modalbox">
			<h3>페이지 안내</h3>
			<div id="infotext">
				<c:out value="${param.result}"/>
			</div>
			<button id="modalclose">닫기</button>
		</div>
	</div>
<script>
	let result = '<c:out value="${param.result}"/>';
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
<script>
	function refresh() {
		$('#storelist').load(location.href + '#storelist');		
	}
</script>
<%@ include file="../includes/footer.jsp" %>