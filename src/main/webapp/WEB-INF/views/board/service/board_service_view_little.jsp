<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view.css" />
<script type="text/javascript">
$(document).ready(function(){
	$("#boardListBtn").on("click",function(){
		var searchType = $('#select-form-control option:selected').val();

		var nowPage = $('#nowPage').val();
		
		var keyword = $('#keyword').val();
		
		var category_srl = $('#category_srl').val();
		
		var subcategory_srl = $('#subcategory_srl').val();
		
		var board_type = $('#board_type').val();
		
		//if (keyword == null || keyword.length() == 0) 
		getServiceSearchList(nowPage, category_srl, subcategory_srl, board_type, searchType, keyword);
	});
	
	var srl = ${view.board_srl};
	
	getListComment(1, srl);
	
	/* var url = "./reply/list/"+${view.board_srl};
	
	$.ajax({
		url : url,
		dataType : "html",
		type : "get",
		contentType : "text/html; charset:UTF-8",
		data : {param1:"값1"},
		success : function(d){
			$('#listReply').html(d); 
		},
		error : function(d){
			alert("실패 : "+d.status+":"+d.statusText);
		}
	});
	 */
	 
	 
	//채택요청 등록하기
	$('#requestSubmit').click(function(){
		
		//alert('요청등록');
		
		if($("textarea[name='requestComments']").val()==""){
			alert("등록할 요청내용을 입력하세요");
			return false;
		}
		
		//$.ajax메소드 사용
		var params = $('#requestCommentsForm').serialize();
		var submit_url = "${pageContext.request.contextPath}/comment";

		$.ajax({
			url : submit_url,
			dataType : "json",
			type : "post",
			contentType : "text/html; charset:UTF-8",
			data : params,
			success : function(d){
				if (d.result == "fail") {
					if (d.errorMsg == "isNotLogin") {
						popLayerMsg("댓글을 작성하시려면 로그인 해주세요.");
						location.href = "${pageContext.request.contextPath}/member/login";
					} 

				} else if (d.result == "success") {

					/* console.log("result: " + d.result); */
					popLayerMsg("글수정을 성공하였습니다.");
					$('#boardListBtn').trigger('click');
					//location.href = "${pageContext.request.contextPath}/customercenter/board";
				}

			},
			error : function(e) {
				popLayerMsg("요청실패:" + e.status + " " + e.statusText);
			}
		});
	});
	 
	 
	$('#replySubmit').click(function(){
			alert('댓글등록');	
	});
	 
	 
	 
});


function deleteBoard(board_srl) {
	
	if(confirm("정말로 삭제 하시겠습니까?")){
	var url = "${pageContext.request.contextPath}/board/service/"+board_srl;
	//alert(url);
	$.ajax({
		url:url,
		type : 'delete',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		/* data : JSON.stringify({
			replytext : replytext
		}), */
		dataType:"json",
		contentType:"text/html; charset:utf-8",
		success:function(d){
			if(d.result == "fail"){
				popLayerMsg("게시물 삭제에 실패하였습니다.");
			}
			else if(d.result == "success"){
				popLayerMsg("게시물 삭제에 성공하였습니다.");
				$('#boardListBtn').trigger('click');
				//$("#noticeDiv_"+board_srl).hide(1000);
				//$(this).parent().hide();
			}						
		},
		error:function(e){
			popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);
		}
	});
	}
}

//수정폼 가져오기
function modifyBoard(board_srl) {
//$("#noticeHead").text("Notice 글수정");
var url = "${pageContext.request.contextPath}/board/service/"+board_srl+"/edit";

	$.ajax({
		
		url:url,
		type : "get",
		dataType : "html",
		contentType : "text/html; charset=UTF-8",
		success : function(d){
			//alert(d);
			$("#boardBody").empty();
			$("#boardBody").html(d);
				
		},
		error : function(e){
			popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);
		}
	});
}

//리스트 가져오기
function getListComment(nowPage, parent_board_srl) {
	nowPage = typeof nowPage !== 'undefined' ? nowPage : 1;

	//service_srl = typeof service_srl !== 'undefined' ? service_srl : 1;

	var url = "${pageContext.request.contextPath}/comment/json/comment_list.json";
	var inHTML = "";

	var inHTMLPaging = "";
	$("#commentList").empty();
	var params = "parent_board_srl=" + parent_board_srl + "&nowPage=" + nowPage;
	$.ajax({
		url : url,
		dataType : "json",
		type : "get",
		data : params,
		contentType : "text/html; charset=utf-8",
		success : function(data) {
			$.each(data.commentLists, function(index, commentList) { // each로 모든 데이터 가져와서 items 배열에 넣고

				inHTML += "<div class=\"table-responsive\">";
				inHTML += "		<table class=\"table table-hover\" id=\"table-hover\">";
				inHTML += "			<thead>";
				inHTML += "			<tr class=\"success\">";
				inHTML += "				<th>아이디</th>";
				inHTML += "				<th colspan=\"2\">채택내용</th>";
				inHTML += "			</tr>";
				inHTML += "			</thead>";
				
				inHTML += "			<tbody>";
				inHTML += "			<tr>";
				inHTML += "				<td>"+ commentList.user_id +"</td>";
				inHTML += "				<td>"+ commentList.comments +"</td>";
				inHTML += "				<td>";
				inHTML += "					<button type=\"button\" class=\"btn btn-default\" id=\"btn-select\">채택하기</button>";
				inHTML += "				</td>";
				inHTML += "			</tr>";
				inHTML += "			</tbody>";
				inHTML += "		</table>";
				inHTML += "</div>";

			});//each끝
			inHTML += "<div class=\"row text-center\">";
			inHTML += "<ul class=\"pagination\" id=\"commentPagingDiv\">";
			inHTML += "</ul> </div>";
			inHTML += "		</div>";
			inHTML += "		</div>";
			$("#commentList").html(inHTML);
			$("#commentPagingDiv").html(data.pagingDiv);
		},
		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}
	});
}


</script>
	<!-- Body영역 -->
	<div class="row" id="row-body-view">
	
			<!-- 뷰 머리 -->
			<div class="view-head">
				<p class="p-title">시공사례 대표이미지</p>
				<!-- <img class="img-responsive" src="../images/tile4.jpg"
					style="height: 500px; width: 100%;" /> <br /> -->
				<div class="title">
					<p class="p-title">제목</p>
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
				<div class="images">
					<p class="p-title">시공사례 이미지</p>
					<!-- <img class="img-responsive" src="../images/tile1.jpg" /><br /> <img
						class="img-responsive" src="../images/tile2.jpg" /><br /> <img
						class="img-responsive" src="../images/tile3.jpg" /><br /> -->
				</div>
			</div>

			<!-- 뷰페이지 버튼부분 -->
			<div class="view-btn">
			
			<c:if test="${sessionScope.loginUserInfo.user_id eq view.user_id}">
				
				<button type="button" class="btn btn-success" id="btn-modify" 
					name="modifyBtn" onclick="javascript:modifyBoard(${view.board_srl});">수정하기</button>
				
				<button type="button" class="btn btn-success" id="btn-delete"
					
					onclick="javascript:deleteBoard(${view.board_srl});">삭제하기</button>
			</c:if>
				
				<button type="button" class="btn btn-success" id="boardListBtn">목록보기</button>
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
								
								<div id="commentList">
									<%-- <div class="table-responsive">
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
									</div> --%>
								</div>
								<!-- <div class="container-fluid" align="center">
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
								</div> -->
								<div class="view-comment-write">
									<form id="requestCommentsForm">
									<input type="hid den" name="parent_board_srl" value="${view.board_srl}" />
									<input type="hid den" name="user_id" value="${loginUserInfo.user_id}" />
									<div class="form-inline">
										<textarea class="form-control" placeholder="채택요청을 입력하세요" name="requestComments"></textarea>
										<button type="button" class="btn" id="requestSubmit">요청등록</button>
									</div>
									</form>
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
												<td>choose432</td>
												<td>잘 공사해주셨서 감사해요!</td>
												<td>
													<button type="button" class="btn btn-default"
														id="btn-select">댓글삭제</button>
												</td>
											</tr>

										</tbody>
									</table>
								</div>
								<!-- <div class="container-fluid" align="center">
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
								</div> -->
								<div class="view-comment-write">
									<div class="form-inline">
										<textarea class="form-control" placeholder="채택요청을 입력하세요"></textarea>
										<button type="button" class="btn" id="replySubmit">후기등록</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
	</div>