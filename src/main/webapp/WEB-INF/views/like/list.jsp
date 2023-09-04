<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login" id="f-list-div1">
		<!-- 검색 추가 하기 -->
		<div class="search-div1">
			<form id="l-form1">
				<select name="type" class="form-control form-width1">
					<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>선택
					</option>
					<option value="T" <c:out value="${ pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목
					</option>
					<option value="W" <c:out value="${ pageMaker.cri.type eq 'W'?'selected':'' }"/>>글쓴이
					</option>
					<option value="C" <c:out value="${ pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용
					</option>
				</select>
				<input type="text" name="keyword" value="${ pageMaker.cri.keyword }" class="form-control form-width2" />
				<button type="submit" class="btn-height1 btn-width1 btn-border1">검색</button>
				<select name="sort" class="sortbox form-control form-width3" onchange="this.form.submit()">
					<!-- value값은 테이블의 열이름과 동일하게  -->
					<option value="regdate desc"<c:if test="${ pageMaker.cri.sort eq 'regdate desc' }">selected</c:if>>찜 등록일(최근)</option>
					<option value="regdate"<c:if test="${ pageMaker.cri.sort eq 'regdate' }">selected</c:if>>찜 등록일(과거)</option>	
					<option value="title" <c:if test="${ pageMaker.cri.sort eq 'title' }">selected</c:if>>타이틀(오름차순)</option>
					<option value="title desc"<c:if test="${ pageMaker.cri.sort eq 'title desc' }">selected</c:if>>타이틀(내림차순)</option>
					<option value="releasedate desc"<c:if test="${ pageMaker.cri.sort eq 'releasedate desc' }">selected</c:if>>발매일(최신순)</option>
					<option value="releasedate"<c:if test="${ pageMaker.cri.sort eq 'releasedate' }">selected</c:if>>발매일(오래된순)</option>	
				</select>
			</form>
		</div>
		<!-- 검색 끝 -->
		<div class="board-list bg-light">
			<table>
				<tr>
					<td class="btd2">제목</td>
					<td class="btd3">가격</td>
					<td class="btd3">발매일</td>
					<td class="btd5">찜 등록일</td>
				</tr>
				<c:forEach items="${ list }" var="list">
				<tr>
					<td class="btd2"><a href="/game/view?gnum=${list.gnum}">${list.title}</a></td>
					<td class="btd3">${list.price}</td>
					<td class="btd3">
						<fmt:parseDate value="${ list.releasedate }" var="releasedate" pattern="yyyy-MM-dd" />
				 		<fmt:formatDate value="${ releasedate }" pattern="yyyy.MM.dd" />
					</td>
					<td class="btd5"><fmt:formatDate value="${ list.regdate }" pattern="yyyy.MM.dd" /> </td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 페이징 추가 -->
		<div>
			<ul class="paging-ul">
				<c:if test="${ pageMaker.prev }">
					<li class="paging-pn"><a href="/like/list?pageNum=${ pageMaker.startPage-1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }">이전</a></li>
				</c:if>
				<c:forEach var="num" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
					<li class="paging-nli ${pageMaker.cri.pageNum == num ? 'active':'' }">
						<a href="/like/list?pageNum=${ num }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }">${ num }</a>
					</li>
				</c:forEach>
				<c:if test="${ pageMaker.next }">
					<li class="paging-pn"><a
						href="/like/list?pageNum=${ pageMaker.endPage+1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }">다음</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 추가 끝 -->
	</div>
<%@ include file="../includes/footer.jsp" %>