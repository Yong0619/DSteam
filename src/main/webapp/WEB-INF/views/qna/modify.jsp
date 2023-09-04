<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="form-width6 div-padding-top1 bv-div1 login">
		<form method="post" action="modify" class="modify">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="qnum" value="${view.qnum}"  />
			<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
			<input type="hidden" name="amount" value="${cri.amount}"  />
			<input type="hidden" name="type" value="${cri.type}"  />
			<input type="hidden" name="keyword" value="${cri.keyword}"  />
			<input type="hidden" name="writer" value="${view.writer}" />
			<table>
				<tr>
					<td colspan="2"><input type="text" name="title"  value="${view.title}" required="required" placeholder="제목" class="form-control form-width6"/></td>
				</tr>
				<tr>
					<td><div class="form-control form-width7 disable-div">글쓴이 : <c:out value="${view.writer}" /></div></td>
					<td><div class="form-control form-width8 disable-div">등록일 <fmt:formatDate value="${ view.regdate }" pattern="yyyy.MM.dd" /></div></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="5" >
					<textarea name="content" required="required" class="board-textarea form-control">${view.content}</textarea>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan="2" class="b-btn1">
						<button type="submit" class="btn-height1 btn-width3">등록</button>
						<button type="button" onclick="history.back();" class="btn-height1 btn-width3">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
<%@ include file="../includes/footer.jsp" %>