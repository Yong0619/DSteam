<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div id="gs-div1">
			<h2 class="fw-bold">판매 등록</h2>
			<form action="register" method="post" id="registerForm">
			<sec:authentication property="principal" var="pinfo"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" id="userid" name="userid" value="${pinfo.username}" />
			<input type="hidden" id="gnum" name="gnum" value="${register.gnum}" />
			<input type="hidden" name="title" value="${register.title}" />
				<table class="btd2">
					<tr>
						<td><input type="text" name="title" value="${register.title}" readonly="readonly" class="form-control form-width11" disabled="disabled"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *타이틀명은 수정할 수 없습니다.</p></td>
					</tr>
					<tr>
						<td>
							<span style="display:none;" id="idCheckStatus">중복체크결과</span>
						</td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *이미 판매중이면 판매등록이 불가능합니다.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="store" required="required" placeholder="스토어명" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *상호명을 입력해주세요.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="price" required="required" placeholder="가격" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *실제 판매가격을 입력해주세요.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="courierfee" required="required" placeholder="택배비" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *택배비를 입력해주세요. 무료면 무료라고 입력하시면 됩니다.</p></td>
					</tr>
					<tr>
						<td><input type="text" name="storeurl" required="required" placeholder="판매링크" class="form-control form-width11"/></td>
					</tr>
					<tr>
						<td><p class="f-size2 form-width11"> *실제 판매 url을 입력해주세요.</p></td>
					</tr>
					<tr>
						<td class="text-center" id="gs-td1">
							<button type="submit" id="target_btn" class="btn-width2 btn-height1" disabled="disabled">등록</button>
							<button type="button" onclick='histore.back();' class="btn-width2 btn-height1">취소</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
<script>
	$(document).ready(function(){
    	let registerForm = $("#registerForm");
        $.ajax({
            url: '/gamestore/storeCheck',
            type: 'get',
            dataType: 'text',
            data: {gnum : $("#gnum").val(), userid : $("#userid").val()},
            success:function(data) {
                if(data == "yes") {
                	$("#idCheckStatus").css({'display':'inline', 'color':'blue'})
                	$("#idCheckStatus").html("<b name='idCheck'>판매 등록 가능</b>")
                	$("#target_btn").attr('disabled', false);
                } else {
                	$("#idCheckStatus").css({'display':'inline', 'color':'red'})
                	$("#idCheckStatus").html("<b>이미 판매중 입니다.</b>")
                }
            }
		});
    });

</script>
<%@ include file="../includes/footer.jsp" %>