<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div class="form-width6 div-padding-top1 bv-div1 login">
		<form method="post" action="modify" class="modify">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="bnum" value="${view.bnum}"  />
			<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
			<input type="hidden" name="amount" value="${cri.amount}"  />
			<input type="hidden" name="type" value="${cri.type}"  />
			<input type="hidden" name="keyword" value="${cri.keyword}"  />
			<input type="hidden" name="writer" value="${view.writer}" />
			<table>
				<tr>
					<td colspan="3"><input type="text" name="title"  value="${view.title}" required="required" placeholder="제목" class="form-control form-width6"/></td>
				</tr>
				<tr>
					<td><div class="form-control form-width7 disable-div">글쓴이 : <c:out value="${view.writer}" /></div></td>
					<td><div class="form-control form-width2 disable-div">조회수 <c:out value="${view.visitcount}" /></div></td>
					<td><div class="form-control form-width3 disable-div">등록일 <fmt:formatDate value="${ view.regdate }" pattern="yyyy.MM.dd" /></div></td>
				</tr>
				<tr>
					<td colspan="3" rowspan="5" >
					<textarea name="content" required="required" class="board-textarea">${view.content}</textarea>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan="3" class="b-btn1">
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
	<!-- 첨부파일 이미지 영역 끝 -->
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
					
					$(arr).each(function (i, attach) {
						let fileCallpath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'"
						str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str += "<div><img src='/display?fileName="+fileCallpath+"' />";
						str += "<button class='btn btn-primary btn-user' sata-type='image' data-file='"+fileCallpath+"'>삭제</button>"
						str += "</div></li>"	
					})
					$(".uploadResult ul").html(str);
				})	//end getJSON
			})();
			//삭제버튼 클릭시 화면상에서 사라지도록 처리
			$(".uploadResult").on("click", "button", function(){
				console.log("delete file");
				//버튼 근처의 li를 찾아서 버튼을 누르면 삭제
				if(confirm("파일을 삭제하시겠습니까?")) {
					let targetLi = $(this).closest("li");
					targetLi.remove();
				}
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
			//전송 버튼 누를때 파일관련 데이터도 같이 전송
			//버튼태크 중 타입이 submit인 요소 선택
			$("button[type='submit']").on("click", function (e) {
				//연결된 이벤트 제거(submit 전송 제거)
				e.preventDefault();
				//폼선택 formObj할당
				let formObj = $("form.modify");
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
		})
	</script>
<%@ include file="../includes/footer.jsp" %>