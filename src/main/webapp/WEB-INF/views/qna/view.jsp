<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="form-width6 div-padding-top1 bv-div1">
		<table>
			<tr>
				<td colspan="2"><div class="form-control form-width6 disable-div">제목 : <c:out value="${view.title}" /></div></td>
			</tr>
			<tr>
				<td><div class="form-control form-width7 disable-div">글쓴이 : <c:out value="${view.writer}" /></div></td>
				<td><div class="form-control form-width8 disable-div">등록일 <fmt:formatDate value="${ view.regdate }" pattern="yyyy.MM.dd" /></div></td>
			</tr>
			<tr>
				<td colspan="2" rowspan="5" >
					<div id="b-td1">
						<div class="uploadResult">
							<ul class="container-fluid"></ul>
						</div>
						<pre><c:out value="${view.content}" /></pre>
					</div>
				<td>
			</tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr>
				<td colspan="2" class="b-btn1">
					<button onclick="location.href='/qna/list?pageNum=${cri.pageNum}&amount=${cri.amount}&keyword=${cri.keyword}&type=${cri.type}'" class="btn-height1 btn-width3">목록</button>
					<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo"/>
					<c:if test="${pinfo.username eq view.writer || pinfo.username eq 'admin'}">
					<button onclick="location.href='/qna/modify?qnum=${view.qnum}&pageNum=${cri.pageNum}&amount=${cri.amount}&keyword=${cri.keyword}&type=${cri.type}'" class="btn-height1 btn-width3">수정</button>
					<form method="post" action="/qna/remove">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="qnum" value="${view.qnum}"/>
						<button type="submit" class="btn-height1 btn-width3">삭제</button>
					</form>
					</c:if>
					</sec:authorize>
				</td>
			</tr>
		</table>
	</div>
	<!-- 답변영역 -->
	<div class="mb-5 form-width6 bv-div2">
		<div class="card bg-light">
			<div class="card-body">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<sec:authentication property="principal" var="pinfo"/>
					<form action="/comment/qnaregister" method="post" class="mb-4">	
						<input type="hidden" name="gnum" value="${ view.qnum }" />
						<input type="hidden" name="userid" value="${ pinfo.username }" />
						<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
						<input type="hidden" name="amount" value="${cri.amount}"  />
						<input type="hidden" name="type" value="${cri.type}"  />
						<input type="hidden" name="keyword" value="${cri.keyword}"  />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<div class="text-flex">
							<textarea class="form-control" rows="3" name="content"></textarea>
							<input type="submit" value="등록">
						</div>
					</form>
					</sec:authorize>	
					<div>
						<div>
							<c:if test="${ empty commentlist }">
								<div class="ms-3">
									등록된 답변이 없습니다.
								</div>
							</c:if>
							<c:forEach items="${ commentlist }" var="commentlist" varStatus="loop">
								<div class="ms-3">
									<div class="fw-bold f-size4">${ commentlist.userid }<span class="f-size3 mg-left2"><fmt:formatDate value="${ commentlist.regdate }" pattern="yyyy.MM.dd" /></span></div>
									<div class="commentflex">
										${ commentlist.content }
										<c:if test="${pinfo.username eq 'admin'}">
										<form action="/comment/qnaremove" method="post">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<input type="hidden" name="cnum" value="${ commentlist.cnum }"/>
											<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
											<input type="hidden" name="amount" value="${cri.amount}"  />
											<input type="hidden" name="type" value="${cri.type}"  />
											<input type="hidden" name="keyword" value="${cri.keyword}"  />
											<input type="hidden" name="gnum" value="${ view.qnum}" />
											<button type="submit">X</button>
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
	<!-- 댓글영역 끝 -->
<%@ include file="../includes/footer.jsp" %>