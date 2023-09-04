<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div>
		<div class="form-width10" id="gm-div2">
			<h2 class="fw-bold" id="gm-h2">게임 정보 수정</h2>
			<form class="game" method="post" action="/game/modify">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="gnum" value="${view.gnum}"/>
				<table id="gm-table1">
					<tr>
						<td class="form-control disable-div form-width2">제목</td>
						<td>
							<input type="text" name="title" id="title" required="required" value="${view.title}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">발매일</td>
						<td>
							<input type="date" name="releasedate" required="required" value="${view.releasedate}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">가격</td>
						<td>
							<input type="text" name="price" required="required" value="${view.price}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">메타스코어</td>
						<td>
							<input type="text" name="metascore" value="${view.metascore}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">트레일러</td>
						<td>
							<input type="text" name="youtube" value="${view.youtube}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">장르</td>
						<td>
							<input type="text" name="genre" required="required" value="${view.genre}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">개발사</td>
						<td>
							<input type="text" name="developer" required="required" value="${view.developer}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">발매플랫폼</td>
						<td>
							<input type="text" name="platform" value="${view.platform}" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">소개</td>
						<td>
							<textarea name="content" required="required" class="form-control">${view.content}</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div>파일 첨부</div>
							<div>
								<div class="uploadDiv">
									<input type="file" name="uploadFile" value="${view.fullname}"/>
								</div>
								<div class="uploadResult" id="gm-div1">
									<ul>
										<li><img src="/display?fileName=${view.fullname}"></li>
									</ul>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center" id="gm-btn">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button type="submit" class="btn-width2 btn-height4">등록</button>
							</sec:authorize>
							<button type="button" onclick="history.back();" class="btn-width2 btn-height4">취소</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
<script type="text/javascript">
	//ready : html 문서를 다 로드하면 이벤트 실행
	$(document).ready(function(){
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
				let fileFullpath = encodeURIComponent(obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-filename='"+obj.uuid+"_"+obj.fileName+"'"
				+"data-fullname='"+fileFullpath+"'>"
				+"<img src='/display?fileName="+fileCallpath+"'/>"
				+"<button data-file=\'"+fileCallpath+"\' data-type='image'>"
				+" 삭제</button>"
				+"</li>";
			})
			uploadul.html(str);
		}
		//전송 버튼 누를때 파일관련 데이터도 같이 전송
		//버튼태크 중 타입이 submit인 요소 선택
		$("button[type='submit']").on("click", function (e) {
			//연결된 이벤트 제거(submit 전송 제거)
			e.preventDefault();
			//폼선택 formObj할당
			let formObj = $("form.game");
			console.log("submit 클릭");
			let str = "";
			let li = $(".uploadResult ul li");
			str += "<input type='hidden' name='fileName' value='"+li.data("filename")+"'/>";
			str += "<input type='hidden' name='fullname' value='"+li.data("fullname")+"'/>";
			str += "<input type='hidden' name='uploadPath' value='"+li.data("path")+"'/>";
			
			//append()메소드: 폼에 데이터 추가  submit(): 전송하기
			formObj.append(str).submit();
		})
	});
</script>
<%@ include file="../includes/footer.jsp" %>