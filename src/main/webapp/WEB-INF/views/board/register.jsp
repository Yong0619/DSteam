<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="login">
		<div class="form-width6 div-padding-top1 bv-div1 login2">
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
						<textarea name="content" required="required" class="board-textarea1"></textarea>
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
		<!-- 첨부파일 이미지 영역 -->
		<div class="bv-div2">
			<div>
				<div>
					<div>
						첨부 파일
					</div>
					<div>
						<div class="uploadDiv">
							<input type="file" name="uploadFile" multiple />
						</div>
						<div class="uploadResult">
							<ul class="i-ul"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	//ready : html 문서를 다 로드하면 이벤트 실행
	$(document).ready(function(){
		//전송 버튼 누를때 파일관련 데이터도 같이 전송
		//버튼태크 중 타입이 submit인 요소 선택
		$("button[type='submit']").on("click", function (e) {
			//연결된 이벤트 제거(submit 전송 제거)
			e.preventDefault();
			//폼선택 formObj할당
			let formObj = $("form.register");
			console.log("submit 클릭");
			let str = "";
			$(".uploadResult ul li").each(function(i, obj){
				let jobj = $(obj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'/>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'/>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'/>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'/>";
			})
			//append()메소드: 폼에 데이터 추가  submit(): 전송하기
			formObj.append(str).submit();
		})
		//input 태그 중 타입이 file인 요소 선택
		//요소의 변경이 있으면 콜백함수 실행
		$("input[type='file']").change(function(){
			//가상의 폼 태그를 생성
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			let files = inputFile[0].files;
			for(let i=0; i<files.length; i++) {
				formData.append("uploadFile", files[i]);
			}
			let csrfHeaderName = "${_csrf.headerName}";
			let csrfTokenValue = "${_csrf.token}";
			$.ajax({
				beforeSend:function(xhr) {
			        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			    },
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result) {
					showUploadResult(result);
					console.log(result);
					
				}
			})
		})
		function showUploadResult(uploadResultArr) {
			//결과 배열이 null이거나 길이가 0이면 함수 종료
			if(!uploadResultArr || uploadResultArr.length==0) { return; }
			let uploadul = $(".uploadResult ul");
			let str = "";
			$(uploadResultArr).each(function(i, obj){
				let fileCallpath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"'"
				+"data-uuid='"+obj.uuid+"' data-type='"+obj.image+"'>"
				+"<img src='/display?fileName="+fileCallpath+"'/>"
				+"<button class='btn btn-primary btn-user' data-file=\'"+fileCallpath+"\' data-type='image'>"
				+"삭제</button>"
				+"</li>";
			})
			uploadul.append(str);
		}
		//삭제버튼 추가하기
		$(".uploadResult").on("click", "button", function(e){
			console.log("삭제 클릭");
			// 자바스크립트의 this는 기본적으로 윈도우를 대상으로 하나, 이벤트 발생시에는 이벤트를 발생시킨
			// 객체를 대상으로 함
			// 커스텀 속성 dataset > data("키이름");
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			//이벤트를 호출한 객체(버튼)에서 가장 가까운 li 선택
			let targetLi = $(this).closest("li");
			let csrfHeaderName = "${_csrf.headerName}";
			let csrfTokenValue = "${_csrf.token}";
			$.ajax({
				beforeSend:function(xhr) {
			        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			    },
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				type: 'POST',
				success: function(result){
					alert(result);
				}
			})
			targetLi.remove();
		})
	})
</script>
<%@ include file="../includes/footer.jsp" %>