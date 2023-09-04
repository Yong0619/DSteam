<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login div-padding-top1">
		<div>
			<h2 id="m-list-h2" class="fw-bold">내 판매 목록</h2>
			<!-- 검색 추가 하기 -->
			<div class="search-div3">
				<form>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<select name="type" class="form-control form-width1">
						<option value="T"
							<c:out value="${ pageMaker.cri.type eq 'I'?'selected':'' }"/>>타이틀
						</option>
					</select> 
					<input type="text" name="keyword" value="${ pageMaker.cri.keyword }" class="form-control form-width2"/>
					<button type="submit" class="btn-height1 btn-width1 btn-border1">검색</button>
					<select name="sort" class="sortbox form-control form-width3" onchange="this.form.submit()">
						<!-- value값은 테이블의 열이름과 동일하게  -->
						<option value="title"<c:if test="${ pageMaker.cri.sort eq 'title' }">selected</c:if>>타이틀(오름차순)</option>
						<option value="title desc"<c:if test="${ pageMaker.cri.sort eq 'title desc' }">selected</c:if>>타이틀(내림차순)</option>		
					</select>
				</form>
			</div>
			<table id="ml-tb">
				<tr>
					<td class="form-control form-width14 disable-div">타이틀</td>
					<td class="form-control form-width13 disable-div">스토어명</td>					
					<td class="form-control form-width13 disable-div">판매가격</td>
					<td class="form-control form-width1 disable-div">택배비</td>
					<td class="form-control form-width14 disable-div">판매링크</td>
					<td class="form-control form-width13 disable-div">판매여부</td>
					<td class="form-control form-width3 disable-div" id="ml-td1">판매정보수정</td>
				</tr>
				<c:forEach items="${list}" var="list">
					<form action="storemodify" method="post">
					<sec:authentication property="principal" var="pinfo"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="userid" value="${pinfo.username}" />
						<input type="hidden" name="snum" value="${list.snum}" />
						<input type="hidden" name="gnum" value="${list.gnum}" />
						<input type="hidden" name="title" value="${list.title}" />
						<input type="hidden" name="title" value="${list.title}" />
						<tr>
							<td><input type="text" name="title" value="${list.title}" readonly disabled="disabled" class="form-control form-width14"></td>
							<td><input type="text" name="store" value="${list.store}" class="form-control form-width13"></td>
							<td><input type="text" name="price" value="${list.price}" class="form-control form-width13"></td>
							<td><input type="text" name="courierfee" value="${list.courierfee}" class="form-control form-width1"></td>
							<td><input type="text" name="storeurl" value="${list.storeurl}" class="form-control form-width14"></td>
							<td>
								<select name="soldout" class="form-control form-width13">
									<option value="0"
										<c:out value="${list.soldout == '0' ? 'selected':'' }"/>>판매중
									</option>
									<option value="1"
										<c:out value="${list.soldout == '1' ? 'selected':'' }"/>>판매중단
									</option>
								</select>
							</td>
							<td><button type="submit" class="btn-height1 btn-width2 btn-border1" id="ml-btn">판매정보수정</button></td>
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
								href="/gamestore/list?pageNum=${ pageMaker.startPage-1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">이전</a></li>
						</c:if>
						<c:forEach var="num" begin="${ pageMaker.startPage }"
							end="${ pageMaker.endPage }">
							<li class="paging-nli ${pageMaker.cri.pageNum == num ? 'active':'' }"><a href="/gamestore/list?pageNum=${ num }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">${ num }</a>
							</li>
						</c:forEach>
						<c:if test="${ pageMaker.next }">
							<li class="paging-pn"><a
								href="/gamestore/list?pageNum=${ pageMaker.endPage+1 }&amount=10&keyword=${ pageMaker.cri.keyword }&type=${ pageMaker.cri.type }&sort=${ pageMaker.cri.sort }">다음</a></li>
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