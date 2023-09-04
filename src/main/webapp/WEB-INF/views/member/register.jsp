<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<script type="text/javascript">
	function validateForm(form) {
		if(!form.userid1.value || !form.userid1){
			alert("아이디 중복검사를 확인 해주세요.");
			form.userid.focus();
			return false;
		}
		if(form.userid1.value.length < 5 || form.userid.value.length > 12){
			alert("아이디는 5자 이상 12자 이하로 작성해주세요.");
			form.userid.focus();
			return false;
		}
		if(form.userpw.value == "") {
			alert("비밀번호를 입력하세요");
			form.userpw.focus();
			return false;
		} 
		if(form.userpw.value.length < 8) {
			alert("비밀번호는 8자 이상 입력해주세요");
			form.userpw.focus();
			return false;
		}
		let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,}$/
		if(!reg.test(form.userpw.value)) {
			alert("비밀번호는 8자 이상, 숫자 및 대,소문자 그리고 특수문자를 모두 포함해야 합니다.");
			form.userpw.focus();
			return false;
		}
		if(/(\w)\1\1\1/.test(form.userpw.value)) {
			alert("비밀번호는 같은 문자를 4번 연속 사용할 수 없습니다.");
			form.userpw.focus();
			return false;
		}
		if(form.userpw.value.search(" ") != -1) {
			alert("비밀번호는 공백을 포함할 수 없습니다.");
			form.userpw.focus();
			return false;
		}
		if(form.userpwConfirm.value == "") {
			alert("비밀번호가 일치하는지 확인 해주세요");
			form.userpwConfirm.focus();
			return false;
		} 
		if(form.userpw.value != form.userpwConfirm.value) {
			alert("비밀번호가 일치하지 않습니다");
			form.userpw.focus();
			return false;
		} 
		let valid_txt = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; 
		//(알파벳,숫자)@(알파벳,숫자).(알파벳,숫자)
		if(valid_txt.test(form.email.value)==false){ 
			alert("이메일 주소가 올바르지 않습니다."); 
			email.focus();
			return false;
		}
	}
</script>
	<div class="login">
		<div id="r-div1">
			<h2 class="fw-bold" id="mr-h2">회원 가입</h2>
			<form id="joinForm" class="user" name="user" method="post" action="/member/register" onsubmit="return validateForm(this)">
				<input type="hidden" name="auth" value="ROLE_MEMBER" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div>
						<div id="j-id">
							<input type="text" name="userid1" id="userid1" required="required" placeholder="아이디" class="input1 form-control">
							<button type="button" id="btnIdCheck">중복 확인</button><span style="display:none;" id="idCheckStatus">중복체크결과</span>
						</div>
						<div>
							<input type="password" name="userpw" required="required" placeholder="비밀번호" class="input1 form-control">
						</div>
						<div>
							<input type="password" name="userpwConfirm" required="required" placeholder="비밀번호 확인" class="input1 form-control">
						</div>
						<div>
							<input type="text" name="userName" required="required" placeholder="이름" class="input1 form-control">
						</div>
						<div id="j-id">
							<input type="text" name="email1" id="email1" required="required" placeholder="이메일" class="input1 form-control"/>
							<button type="button" id="btnEmailCheck">중복 확인</button><span style="display:none;" id="emailCheckStatus">중복체크결과</span>
						</div>
						<div>
							<button type="submit" id="target_btn" disabled="disabled" class="j-Btn">등록</button>
							<button type="button" onclick="location.href='../index'" class="j-Btn">취소</button>
						</div>
					</div>
			</form>
		</div>
	</div>
<script>
$(document).ready(function(){
    let joinForm = $("#joinForm");
    let btn_able1 = false;
    let btn_able2 = false;
    // ID 중복 체크
    $("#btnIdCheck").on("click", function(){
        if($("#userid1").val() == "") {
          alert("아이디를 입력하세요");
          $("#userid1").focus();
          return;
        }
        $.ajax({
            url: '/member/idCheck',
            type: 'get',
            dataType: 'text',
            data: {userid : $("#userid1").val()},
            success:function(data) {
                if(data == "yes") {
                	$("#idCheckStatus").css({'display':'inline', 'color':'blue'})
                	$("#idCheckStatus").html("<b name='idCheck'>사용 가능</b><input type='hidden' name='userid' value='"+$("#userid1").val()+"'/>")
                	btn_able1 = true;
                	if(btn_able1 && btn_able2) {
                		$("#target_btn").attr('disabled', false);
                	}
                	$("#userid1").attr('disabled', true);
                } else {
                	$("#idCheckStatus").css({'display':'inline', 'color':'red'})
                	$("#idCheckStatus").html("<b>사용중</b>")
                }
            }
		});
    });
 	// 이메일 중복 체크
    $("#btnEmailCheck").on("click", function(){
        if($("#email1").val() == "") {
          alert("이메일을 입력하세요");
          $("#email1").focus();
          return;
        }
        $.ajax({
            url: '/member/emailCheck',
            type: 'get',
            dataType: 'text',
            data: {email : $("#email1").val()},
            success:function(data) {
                if(data == "yes") {
                	$("#emailCheckStatus").css({'display':'inline', 'color':'blue'})
                	$("#emailCheckStatus").html("<b name='emailCheck'>사용 가능</b><input type='hidden' name='email' value='"+$("#email1").val()+"'/>")
                	btn_able2 = true;
                	if(btn_able1 && btn_able2) {
                		$("#target_btn").attr('disabled', false);
                	}
                	$("#email1").attr('disabled', true);
                } else {
                	$("#emailCheckStatus").css({'display':'inline', 'color':'red'})
                	$("#emailCheckStatus").html("<b>사용중</b>")
                }
            }
		});
    });
});
</script>
<%@ include file="../includes/footer.jsp" %>