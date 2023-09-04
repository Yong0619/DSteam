<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="form-width6 div-padding-top1 bv-div1 login">
		<form method="post" action="register" class="register">
			<sec:authentication property="principal" var="pinfo"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="writer" value="${ pinfo.username }" />
			<table>
				<tr>
					<td colspan="3"><input type="text" name="title"  required="required" placeholder="제목" class="form-control form-width6"/></td>
				</tr>
				<tr>
					<td><div class="form-control form-width6 disable-div">글쓴이 : <c:out value="${pinfo.username}" /></div></td>
				</tr>
				<tr>
					<td rowspan="5" >
					<textarea name="content" required="required" class="board-textarea" class="form-control"></textarea>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td class="b-btn1">
						<button type="submit" class="btn-height1 btn-width3">등록</button>
						<button type="button" onclick="history.back();" class="btn-height1 btn-width3">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
<%@ include file="../includes/footer.jsp" %>