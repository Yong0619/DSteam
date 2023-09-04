<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div id="gs-div1">
			<h2 class="fw-bold">판매 등록</h2>
			<form action="modify" method="post">
			<sec:authentication property="principal" var="pinfo"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="userid" value="${pinfo.username}" />
			<input type="hidden" name="snum" value="${modify.snum}" />
			<input type="hidden" name="gnum" value="${modify.gnum}" />
			<input type="hidden" name="title" value="${modify.title}" />
				<table class="btd2">
					<tr>
						<td><input type="text" name="title" value="${modify.title}" readonly="readonly" class="form-control form-width11" disabled="disabled"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *타이틀명은 수정할 수 없습니다.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="store" value="${modify.store}" required="required" placeholder="스토어명" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *상호명을 입력해주세요.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="price" value="${modify.price}" required="required" placeholder="가격" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *실제 판매가격을 입력해주세요.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="courierfee" value="${modify.courierfee}" required="required" placeholder="택배비" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *택배비를 입력해주세요. 무료면 무료라고 입력하시면 됩니다.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="storeurl" value="${modify.storeurl}" required="required" placeholder="판매링크" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *실제 판매 url을 입력해주세요.</p></td>
					</tr>
					<tr>
						<td>
							<select name="soldout" class="form-control form-width11">
								<option value="0" <c:out value="${modify.soldout == '0' ? 'selected' : '' }"/>>판매중</option>
								<option value="1" <c:out value="${modify.soldout == '1' ? 'selected' : '' }"/>>판매중지</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *판매여부를 선택해주세요.</p></td>
					</tr>
					<tr>
						<td class="text-center" id="gs-td1">
							<button type="submit" class="btn-width2 btn-height1">등록</button>
							<button type="button" onclick='histore.back();' class="btn-width2 btn-height1">취소</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
<%@ include file="../includes/footer.jsp" %>