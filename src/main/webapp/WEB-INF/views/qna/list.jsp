<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login" id="f-list-div1">
		<sec:authorize access="isAuthenticated()">
		<div id="f-list-btn1">
			<button type="button" onclick="location.href='/qna/register'" class="btn-height1 btn-width3 btn-border1">문의하기</button>
		</div>
		</sec:authorize>
		<div class="board-list bg-light">
			<table>
				<tr>
					<td class="btd1">번호</td>
					<td class="btd2">제목</td>
					<td class="btd3">글쓴이</td>
					<td class="btd4"></td>
					<td class="btd5">등록일</td>
				</tr>
				<c:forEach items="${ list }" var="list">
				<tr>
					<td class="btd1"> <a href="/qna/view?qnum=${ list.qnum }&pageNum=${ pageMaker.cri.pageNum }&amount
					${ pageMaker.cri.amount }&keyword=${pageMaker.cri.keyword}&type=${pageMaker.cri.type}" style="cursor: pointer;">${list.qnum}</a></td>
					<td class="btd2"><a href="/qna/view?qnum=${ list.qnum }&pageNum=${ pageMaker.cri.pageNum }&amount
					${ pageMaker.cri.amount }&keyword=${pageMaker.cri.keyword}&type=${pageMaker.cri.type}" style="cursor: pointer;">${list.title}</a></td>
					<td class="btd3"><a href="/qna/view?qnum=${ list.qnum }&pageNum=${ pageMaker.cri.pageNum }&amount
					${ pageMaker.cri.amount }&keyword=${pageMaker.cri.keyword}&type=${pageMaker.cri.type}" style="cursor: pointer;">${list.writer}</a></td>
					<td class="btd4"></td>
					<td class="btd5"><a href="/qna/view?qnum=${ list.qnum }&pageNum=${ pageMaker.cri.pageNum }&amount
					${ pageMaker.cri.amount }&keyword=${pageMaker.cri.keyword}&type=${pageMaker.cri.type}" style="cursor: pointer;">	
					 	<fmt:formatDate value="${ list.regdate }" pattern="yyyy.MM.dd" /> 
					 </a>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 검색 추가 하기 -->
		<form id="f-list-search-form">
			<select name="type" class="form-control form-width1">
				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>선택
				</option>
				<option value="T" <c:out value="${ pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목
				</option>
				<option value="C" <c:out value="${ pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용
				</option>
			</select>
			<input type="text" name="keyword" value="${ pageMaker.cri.keyword }" class="form-control form-width2"/>
			<button type="submit" class="btn-height1 btn-width1 btn-border1">검색</button>
		</form>
		<!-- 검색 끝 -->
		<!-- 페이징 추가 -->
		<div>
			<ul class="paging-ul">
				<c:if test="${ pageMaker.prev }">
					<li class="paging-pn"><a href="/qna/list?pageNum=${ pageMaker.startPage-1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }">이전</a></li>
				</c:if>
				<c:forEach var="num" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
					<li class="paging-nli ${pageMaker.cri.pageNum == num ? 'active':'' }">
						<a href="/qna/list?pageNum=${ num }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }">${ num }</a>
					</li>
				</c:forEach>
				<c:if test="${ pageMaker.next }">
					<li class="paging-pn"><a
						href="/qna/list?pageNum=${ pageMaker.endPage+1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }">다음</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 추가 끝 -->
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