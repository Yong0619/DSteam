<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login div-padding-top1">
		<div>
			<h2 id="m-list-h2" class="fw-bold">회원 목록</h2>
			<!-- 검색 추가 하기 -->
			<div class="search-div1">
				<form>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<select name="type" class="form-control form-width1">
						<option value=""
							<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>선택
						</option>
						<option value="I"
							<c:out value="${ pageMaker.cri.type eq 'I'?'selected':'' }"/>>아이디
						</option>
						<option value="N"
							<c:out value="${ pageMaker.cri.type eq 'N'?'selected':'' }"/>>이름
						</option>
						<option value="E"
							<c:out value="${ pageMaker.cri.type eq 'E'?'selected':'' }"/>>이메일
						</option>
					</select> 
					<input type="text" name="keyword" value="${ pageMaker.cri.keyword }" class="form-control form-width2"/>
					<button type="submit" class="btn-height1 btn-width1 btn-border1">검색</button>
					<select name="sort" class="sortbox form-control form-width3" onchange="this.form.submit()">
						<!-- value값은 테이블의 열이름과 동일하게  -->
						<option value="userid"<c:if test="${ pageMaker.cri.sort eq 'userid' }">selected</c:if>>아이디(오름차순)</option>
						<option value="userid desc"<c:if test="${ pageMaker.cri.sort eq 'userid desc' }">selected</c:if>>아이디(내림차순)</option>
						<option value="regdate desc" <c:if test="${ pageMaker.cri.sort eq 'regdate desc' }">selected</c:if>>등록일(최근순)</option>
						<option value="regdate"<c:if test="${ pageMaker.cri.sort eq 'regdate' }">selected</c:if>>등록일(오래된순)</option>
						<option value="username"<c:if test="${ pageMaker.cri.sort eq 'username' }">selected</c:if>>이름(오름차순)</option>
						<option value="username desc"<c:if test="${ pageMaker.cri.sort eq 'username desc' }">selected</c:if>>이름(내림차순)</option>
						<option value="email"<c:if test="${ pageMaker.cri.sort eq 'email' }">selected</c:if>>이메일(오름차순)</option>
						<option value="email desc"<c:if test="${ pageMaker.cri.sort eq 'email desc' }">selected</c:if>>이메일(내림차순)</option>		
					</select>
				</form>
			</div>
			<table id="ml-tb">
				<tr>
					<td class="form-control form-width3 disable-div">아이디</td>
					<td class="form-control form-width3 disable-div">이름</td>
					<td class="form-control form-width4 disable-div">이메일</td>
					<td class="form-control form-width3 disable-div">등록일</td>
					<td class="form-control form-width5 disable-div">회원등급</td>
					<td class="form-control form-width3 disable-div" id="ml-td1">회원정보수정</td>
				</tr>
				<c:forEach items="${list}" var="list">
					<form action="adminModify" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="userid" value="${list.userid}" />
						<tr>
							<td><input type="text" name="userid" value="${list.userid}" readonly disabled="disabled" class="form-control form-width3"></td>
							<td><input type="text" name="userName" value="${list.userName}" class="form-control form-width3"></td>
							<td><input type="text" name="email" value="${list.email}" class="form-control form-width4"></td>
							<td><div class="form-control form-width3 disable-div"><fmt:formatDate pattern='yyyy.MM.dd' value='${list.regDate}'/></div></td>
							<td>
								<select name="auth" class="form-control form-width5">
									<option value="ROLE_MEMBER"
										<c:out value="${list.auth == 'ROLE_MEMBER' ? 'selected':'' }"/>>일반회원
									</option>
									<option value="ROLE_MANAGER"
										<c:out value="${list.auth == 'ROLE_MANAGER' ? 'selected':'' }"/>>판매자회원
									</option>
									<option value="ROLE_ADMIN"
										<c:out value="${list.auth == 'ROLE_ADMIN' ? 'selected':'' }"/>>운영자회원
									</option>
								</select>
							</td>
							<td><button type="submit" class="btn-height1 btn-width2 btn-border1" id="ml-btn">회원정보수정</button></td>
						</tr>
					</form>
				</c:forEach>
			</table>
			<!-- 페이징 추가 -->
			<div>
				<div>
					<ul class="paging-ul">
						<c:if test="${ pageMaker.prev }">
							<li class="paging-pn"><a
								href="/member/list?pageNum=${ pageMaker.startPage-1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">이전</a></li>
						</c:if>
						<c:forEach var="num" begin="${ pageMaker.startPage }"
							end="${ pageMaker.endPage }">
							<li class="paging-nli ${pageMaker.cri.pageNum == num ? 'active':'' }"><a href="/member/list?pageNum=${ num }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">${ num }</a>
							</li>
						</c:forEach>
						<c:if test="${ pageMaker.next }">
							<li class="paging-pn"><a
								href="/member/list?pageNum=${ pageMaker.endPage+1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">다음</a></li>
						</c:if>
					</ul>
				</div>
			</div>
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