<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="form-width6 div-padding-top1 bv-div1">
		<table>
			<tr>
				<td colspan="3"><div class="form-control form-width6 disable-div">제목 : <c:out value="${view.title}" /></div></td>
			</tr>
			<tr>
				<td><div class="form-control form-width7 disable-div">글쓴이 : <c:out value="${view.writer}" /></div></td>
				<td><div class="form-control form-width2 disable-div">조회수 <c:out value="${view.visitcount}" /></div></td>
				<td><div class="form-control form-width3 disable-div">등록일 <fmt:formatDate value="${ view.regdate }" pattern="yyyy.MM.dd" /></div></td>
			</tr>
			<tr>
				<td colspan="3" rowspan="5" >
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
				<td colspan="3" class="b-btn1">
					<button onclick="location.href='/board/freeboardlist?pageNum=${cri.pageNum}&amount=${cri.amount}&keyword=${cri.keyword}&type=${cri.type}'" class="btn-height1 btn-width3">목록</button>
					<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo"/>
					<c:if test="${pinfo.username eq view.writer || pinfo.username eq 'admin'}">
					<button onclick="location.href='/board/modify?bnum=${view.bnum}&pageNum=${cri.pageNum}&amount=${cri.amount}&keyword=${cri.keyword}&type=${cri.type}'" class="btn-height1 btn-width3">수정</button>
					<form method="post" action="/board/remove">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="bnum" value="${view.bnum}"/>
						<button type="submit" class="btn-height1 btn-width3">삭제</button>
					</form>
					</c:if>
					</sec:authorize>
					
				</td>
			</tr>
		</table>
	</div>
	<!-- 댓글영역 -->
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="pinfo"/>
	<div class="mb-5 form-width6 bv-div2">
		<div class="card bg-light">
			<div class="card-body">
				<form action="/comment/boardregister" method="post" class="mb-4">	
					<input type="hidden" name="gnum" value="${ view.bnum }" />
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
				<div>
					<div>
						<c:if test="${ empty commentlist }">
							<div class="ms-3">
								등록된 댓글이 없습니다.
							</div>
						</c:if>
						<c:forEach items="${ commentlist }" var="commentlist" varStatus="loop">
							<div class="ms-3">
								<div class="fw-bold f-size4">${ commentlist.userid }<span class="f-size3 mg-left2"><fmt:formatDate value="${ commentlist.regdate }" pattern="yyyy.MM.dd" /></span></div>
								<div class="commentflex">
									${ commentlist.content }
									<c:if test="${pinfo.username eq commentlist.userid || pinfo.username eq 'admin'}">
									<form action="/comment/boardremove" method="post">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="cnum" value="${ commentlist.cnum }"/>
										<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
										<input type="hidden" name="amount" value="${cri.amount}"  />
										<input type="hidden" name="type" value="${cri.type}"  />
										<input type="hidden" name="keyword" value="${cri.keyword}"  />
										<input type="hidden" name="gnum" value="${ view.bnum}" />
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
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
	<div class="mb-5 form-width6 bv-div2">
		<div class="card bg-light">
			<div class="card-body">
				<div class="text-flex mb-4">
					<textarea class="form-control" rows="3" name="content" placeholder="댓글을 남기시려면 로그인을 해주세요!"></textarea>
					<input type="submit" value="등록" disabled="disabled">
				</div>
				<div>
					<div>
						<c:if test="${ empty commentlist }">
							<div class="ms-3">
								등록된 댓글이 없습니다.
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
	<!-- 리뷰영역 끝 -->
<script type="text/javascript">
	$(document).ready(function(){
		//스스로 실행되는 함수
		(function name() {
			let bnum = '<c:out value="${view.bnum}"/>';
			$.getJSON("/board/getAttachList", {bnum:bnum}, 
				function(arr) {
				console.log(arr)
				//이미지 나타내기
				let str = "";
				let str1 = "";
				
				$(arr).each(function (i, attach) {
					let fileCallpath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'"
					str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
					str += "<div id='b-img'><img src='/display?fileName="+fileCallpath+"' />";
					str += "</div></li>"		
				})
				$(".uploadResult ul").html(str);
			})	//end getJSON
		})();
	})
</script>
<%@ include file="../includes/footer.jsp" %>