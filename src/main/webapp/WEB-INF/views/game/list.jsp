<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div>
		<div class="pd-top1">
		<sec:authentication property="principal" var="pinfo"/>
			<h2 id="m-list-h2" class="fw-bold pd-bt1">게임 목록</h2>
			<!-- 검색 추가 하기 -->
			<div class="search-div2">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="button" onclick="location.href='/game/register'" class="btn-height1 btn-width3 btn-border1">등록</button>	
				</sec:authorize>
				<form>
					<select name="type" class="form-control form-width1">
						<option value=""
							<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>선택
						</option>
						<option value="T"
							<c:out value="${ pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목
						</option>
						<option value="G"
							<c:out value="${ pageMaker.cri.type eq 'G'?'selected':'' }"/>>장르
						</option>
						<option value="P"
							<c:out value="${ pageMaker.cri.type eq 'P'?'selected':'' }"/>>플랫폼
						</option>
					</select> 
					<input type="text" name="keyword" value="${ pageMaker.cri.keyword }" class="form-control form-width2"/>
					<button type="submit" class="btn-height1 btn-width1 btn-border1">검색</button>
					<select name="sort" class="sortbox form-control form-width3" onchange="this.form.submit()">
						<!-- value값은 테이블의 열이름과 동일하게  -->
						<option value="releasedate desc"<c:if test="${ pageMaker.cri.sort eq 'releasedate desc' }">selected</c:if>>발매일(최신순)</option>
						<option value="releasedate"<c:if test="${ pageMaker.cri.sort eq 'releasedate' }">selected</c:if>>발매일(오래된순)</option>
						<option value="title" <c:if test="${ pageMaker.cri.sort eq 'title' }">selected</c:if>>타이틀(오름차순)</option>
						<option value="title desc"<c:if test="${ pageMaker.cri.sort eq 'title desc' }">selected</c:if>>타이틀(내림차순)</option>
						<option value="metascore desc"<c:if test="${ pageMaker.cri.sort eq 'metascore desc' }">selected</c:if>>메타스코어(높은순)</option>
						<option value="metascore"<c:if test="${ pageMaker.cri.sort eq 'metascore' }">selected</c:if>>메타스코어(낮은순)</option>
						<option value="visitcount desc"<c:if test="${ pageMaker.cri.sort eq 'visitcount desc' }">selected</c:if>>인기순</option>		
					</select>
				</form>
			</div>
			<!-- 검색 끝 -->
			<div class="board-list1 bg-light mg-bt1 pd-top1">
				<table id="gl-table1">
					<c:forEach items="${ list }" var="list">
					<tr class="tr-bl1">
						<td class="btd4"><a href="/game/view?gnum=${ list.gnum}"><img src="/display?fileName=${list.fullname}" class="listImg" style="width: 100px; height: 100px; object-fit: cover;"/></a></td>
						<td class="btd6"><a href="/game/view?gnum=${ list.gnum}">${list.title}</a></td>
						<td class="btd3 text-center"><a href="/game/view?gnum=${ list.gnum}">${list.platform}</a></td>
						<td class="btd3 text-center"><a href="/game/view?gnum=${ list.gnum}">${list.genre}</a></td>
						<td class="btd1 text-center"><a href="/game/view?gnum=${ list.gnum}">${list.price}</a></td>
						<td class="btd4 text-center">
							<a href="/game/view?gnum=${ list.gnum}">
							<fmt:parseDate value="${ list.releasedate }" var="releasedate" pattern="yyyy-MM-dd" />
						 	<fmt:formatDate value="${ releasedate }" pattern="yyyy.MM.dd" />
						 	</a>
						</td>
						<td>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button type="button" onclick="location.href='/game/modify?gnum=${ list.gnum }'" class="btn-height2 btn-width4">수정</button>
								<form method="post" action="/game/remove">
									<input type="hidden" name="gnum" value="${list.gnum}" />
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<button type="submit" class="btn-height2 btn-width4">삭제</button>
								</form>
							</sec:authorize>
							
							<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
								<button type="button" onclick="location.href='/gamestore/register?gnum=${ list.gnum }'" class="btn-height2 btn-width4" id="sell">판매등록</button>
							</sec:authorize>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<!-- 페이징 추가 -->
			<div>
				<div>
					<ul class="paging-ul">
						<c:if test="${ pageMaker.prev }">
							<li class="paging-pn"><a
								href="/game/list?pageNum=${ pageMaker.startPage-1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">이전</a></li>
						</c:if>
						<c:forEach var="num" begin="${ pageMaker.startPage }"
							end="${ pageMaker.endPage }">
							<li class="paging-nli ${pageMaker.cri.pageNum == num ? 'active':'' }"><a href="/game/list?pageNum=${ num }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">${ num }</a>
							</li>
						</c:forEach>
						<c:if test="${ pageMaker.next }">
							<li class="paging-pn"><a
								href="/game/list?pageNum=${ pageMaker.endPage+1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">다음</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 페이징 추가 끝 -->
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