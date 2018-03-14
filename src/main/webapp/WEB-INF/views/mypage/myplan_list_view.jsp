<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view.css" />
<script type="text/javascript">

//수정폼 가져오기
function modify(board_srl) {
	
	var url = "./myplan/modify/"+board_srl;
	
	$.ajax({
		
		url : url,
		type : "get",
		dataType : "html",
		contentType : "text/html; charset=UTF-8",
		success : function(d){
			$("#mylist-area").html(d);
		},
		error : function(e){
			alert("요청 실패 : "+ e.status+":"+e.statusText);
		}
	});
}

//삭제하기
function deleteBoard(board_srl){
	if(confirm("삭제 하시겠습니까?")){
		var url = "./myplan/delete/"+board_srl;
		
		$.ajax({
			url : url,
			type : "post",
			dataType : "html",
			contentType : "text/html; charset=UTF-8",
			success : function(d){
				alert("삭제 되었습니다");
				location.href = "./myplan"
			},
			error : function(e){
				alert("요청 실패 : "+ e.status+":"+e.statusText);
			}
		});
	}
}
</script>

	<!-- Body영역 -->
	<div class="row" id="row-body-view" style="margin-top: 0px; padding-bottom: 0px; padding-left: 15px; padding-right: 15px; text-align: left;">
		<!-- 뷰 머리 -->
		<div class="view-head">
			<p class="p-title">제목</p>
			<!-- <img class="img-responsive" src="../images/tile4.jpg"
				style="height: 500px; width: 100%;" /> <br /> -->
			<div class="title">
				<h4>${view.title }</h4>
			</div>
		</div>
		<!-- 뷰 별평가 -->
		<!-- <div class="view-star">
			<img src="../images/star.png" /> <img src="../images/star.png" />
			<img src="../images/star.png" /> <img src="../images/star.png" />
			<img src="../images/star.png" />
			<p>15개의 평가</p>
		</div> -->
		<!-- 뷰 상세내용 -->
		<div class="view-body">
			<div class="contents">
				<p class="p-title">서비스내용</p>
				<div class="textarea">
					${view.contents }
				</div>
			</div>
			<div class="need-contents">
				<p class="p-title">필수사항</p>
				<div class="form-inline">
					<p>서비스지역 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp; ${view.location }
					</p>
					<p>서비스기간 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;
						${view.service_time_start } ~ ${view.service_time_end }</p>
					<p>서비스비용 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;
						<fmt:formatNumber value="${view.service_cost }"/>원</p>
					<p>연락가능시간 &nbsp;&nbsp;: &nbsp;&nbsp; ${view.contact_time_start } ~ ${view.contact_time_end }</p>
				</div>
			</div>
			<!-- <div class="images">
				<p class="p-title">시공사례 이미지</p>
				 <img class="img-responsive" src="../images/tile1.jpg" /><br /> <img
					class="img-responsive" src="../images/tile2.jpg" /><br /> <img
					class="img-responsive" src="../images/tile3.jpg" /><br />
			</div> -->
		</div>

		<!-- 뷰페이지 버튼부분 -->
		<div class="view-btn">
			<c:if test="${sessionScope.loginUserInfo.user_id eq view.user_id}">
				<button type="button" class="btn btn-success" id="btn-modify" 
					name="modifyBtn" onclick="javascript:modify(${view.board_srl});">수정하기</button>
				<button type="button" class="btn btn-success" id="btn-delete"
					onclick="javascript:deleteBoard(${view.board_srl});">삭제하기</button>
			</c:if>
		</div>


		<!-- 요청&댓글부분 -->
		
		<div class="view-comment-head">
			<div class="container">
				<ul class="nav nav-tabs" id="nav-tabs">
					<li class="active"><a data-toggle="tab" href="#home">채택요청</a></li>
					<li><a data-toggle="tab" href="#menu1">댓글후기</a></li>
				</ul>
				<div class="tab-content">
					<!-- 요청리스트부분 -->
					<div id="home" class="tab-pane fade in active">
						<div class="write-comment">
							
							<div id="replyList">
								<div class="table-responsive">
									<table class="table table-hover" id="table-hover">
										<thead>
											<tr class="success">
												<th>아이디</th>
												<th colspan="2">채택내용</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="reply" items="${reply }">	
											<tr>
												<td>${reply.user_id }</td>
												<td>${reply.contents }</td>
												<td>
													<button type="button" class="btn btn-default"
														id="btn-select">채택하기</button>
												</td>
											</tr>
										</c:forEach>	
										</tbody>
									</table>
								</div>
							</div>
							<div class="container-fluid" align="center">
								<div class="pagination">
									<ul class="pagination pagination" id="pagination-ul">
										<li><a href="#"><span
												class="glyphicon glyphicon-backward"></span></a></li>
										<li><a href="#"><span
												class="glyphicon glyphicon-triangle-left"></span></a></li>
										<li><a href="#">6</a></li>
										<li><a href="#">7</a></li>
										<li><a href="#">8</a></li>
										<li><a href="#">9</a></li>
										<li><a href="#">10</a></li>
										<li><a href="#"><span
												class="glyphicon glyphicon-triangle-right"></span></a></li>
										<li><a href="#"><span
												class="glyphicon glyphicon-forward"></span></a></li>
									</ul>
								</div>
							</div>
							<div class="view-comment-write">
								<div class="form-inline">
									<textarea class="form-control" placeholder="채택요청을 입력하세요"></textarea>
									<button type="button" class="btn">등록</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 댓글후기 리스트 -->
					<div id="menu1" class="tab-pane fade">
						<div class="write-comment">
							<div class="table-responsive">
								<table class="table table-hover" id="table-hover">
									<thead>
										<tr class="info">
											<th>아이디</th>
											<th colspan="2">댓글내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<!-- 아이디 메뉴작업 -->
											<td>
												<div class="popup" onclick="popUserMenu()">EL아이디
													<span class="popuptext" id="userPopup">
														<a href="${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}">회원정보보기</a><br/>
														<a href="${pageContext.request.contextPath}/message">쪽지보내기</a><br/>
														<c:if test="${not empty loginUserInfo && loginUserInfo.is_admin=='Y'}">
															<a href="${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}">작성글보기</a><br/>
												  			<a href="${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}">회원정보관리</a><br/>							
														</c:if>
													</span>
												</div>
											</td>
											<td>잘 공사해주셨서 감사해요!</td>
											<td>
												<button type="button" class="btn btn-default"
													id="btn-select">댓글삭제</button>
											</td>
										</tr>

									</tbody>
								</table>
							</div>
							<div class="container-fluid" align="center">
								<div class="pagination">
									<ul class="pagination pagination" id="pagination-ul">
										<li><a href="#"><span
												class="glyphicon glyphicon-backward"></span></a></li>
										<li><a href="#"><span
												class="glyphicon glyphicon-triangle-left"></span></a></li>
										<li><a href="#">6</a></li>
										<li><a href="#">7</a></li>
										<li><a href="#">8</a></li>
										<li><a href="#">9</a></li>
										<li><a href="#">10</a></li>
										<li><a href="#"><span
												class="glyphicon glyphicon-triangle-right"></span></a></li>
										<li><a href="#"><span
												class="glyphicon glyphicon-forward"></span></a></li>
									</ul>
								</div>
							</div>
							<div class="view-comment-write">
								<div class="form-inline">
									<textarea class="form-control" placeholder="채택요청을 입력하세요"></textarea>
									<button type="button" class="btn">등록</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>