<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	</section>
	<footer class="inner">
		<div id="f-div1">
			<div id="f-logo">
				<a href="../index"><img src="/resources/image/logo.png" ></a>
			</div>
			<ul>
				<li><b>COMPANY INFO</b></li>
				<li>대표자 : 이철용</li>
				<li>상호명 : DSteam</li>
			</ul>
			<div> 
				<select onchange="if(this.value) location.href=(this.value)">
					<option>사이트맵</option>
					<option value="/game/list">게임목록</option>
					<option value="/board/freeboardlist">자유게시판</option>
					<option value="/qna/list">Q&A</option>
				</select>
			</div>
		</div>
	</footer>
</body>
</html>