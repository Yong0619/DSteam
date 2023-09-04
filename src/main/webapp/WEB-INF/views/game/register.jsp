<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<div>
		<div class="form-width10" id="gm-div2">
			<h2 class="fw-bold" id="gm-h2">게임 등록</h2>
			<form class="game" method="post" action="/game/register">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<table id="gm-table1">
					<tr>
						<td class="form-control disable-div form-width2">제목</td>
						<td>
							<input type="text" name="title" id="title" required="required" placeholder="타이틀" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">발매일</td>
						<td>
							<input type="date" name="releasedate" required="required" placeholder="발매일" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">가격</td>
						<td>
							<input type="text" name="price" required="required" placeholder="가격" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">메타스코어</td>
						<td>
							<input type="text" name="metascore" placeholder="메타스코어" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">트레일러</td>
						<td>
							<input type="text" name="youtube" placeholder="트레일러" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">장르</td>
						<td>
							<input type="text" name="genre" required="required" placeholder="장르" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">개발사</td>
						<td>
							<input type="text" name="developer" required="required" placeholder="개발사" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">발매플랫폼</td>
						<td class="f-size1">
							<div id="gm-div3">
							<input type="checkbox" name="platform" value="PC" class="checkbox1 mg-left1 mg-right1">PC
							<input type="checkbox" name="platform" value="SWITCH" class="checkbox1 mg-left1 mg-right1">SWITCH
							<input type="checkbox" name="platform" value="PS5" class="checkbox1 mg-left1 mg-right1">PS5
							<input type="checkbox" name="platform" value="PS4" class="checkbox1 mg-left1 mg-right1">PS4
							<input type="checkbox" name="platform" value="XSX" class="checkbox1 mg-left1 mg-right1">XSX/S
							<input type="checkbox" name="platform" value="XO" class="checkbox1 mg-left1 mg-right1">XO
							<input type="checkbox" name="platform" value="모바일" class="checkbox1 mg-left1 mg-right1">모바일
							</div>
						</td>
					</tr>
					<tr>
						<td class="form-control disable-div form-width2">소개</td>
						<td>
							<textarea name="content" required="required" class="form-control"></textarea>
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
									<ul></ul>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center" id="gm-btn">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button type="submit" class="btn-width2 btn-height4">등록</button>
							</sec:authorize>
							<button type="button" onclick="location.href='/game/list'" class="btn-width2 btn-height4">취소</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 모달 추가 -->
	<div id="modal">
		<div id="modalbox">
			<h3>페이지 안내</h3>
			<div id="infotext">
				<c:out value="${result}"/>
			</div>
			<button id="modalclose">닫기</button>
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
	
	let result = '<c:out value="${result}" />';
	console.log(result);
	checkModal(result);
	function checkModal(result) {
		if(!result) return;
		document.querySelector("#modal").style.display = 'block';
	}
	//닫기 누르면 모달창 안보이게 하기
	document.querySelector("#modalclose").addEventListener("click", function () {
		document.querySelector("#modal").style.display = 'none';		
	})
</script>
<%@ include file="../includes/footer.jsp" %>