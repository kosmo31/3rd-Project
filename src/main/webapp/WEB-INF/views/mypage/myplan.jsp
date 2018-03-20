<%@page import="com.cafe24.ourplanners.member.dto.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<!-- CSS작업부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myplan.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<!-- 에이젝스로 나의 리스트 뿌려주기 -->
<script type="text/javascript">

$(document).ready(function(){

	var value = getMyStarScore("${loginUserInfo.user_id}");
	
	setMyStarScore(value);
	
	//요청자 진행건 버튼 클릭시발동
	$('#btn_client_ing').click(function(){
		getMyPlanList("1", "C","${loginUserInfo.user_id}", "N", "danger");
		$("#service_expired").val("N");
	});
	
	//요청자 완료건 버튼 클릭시발동
	$('#btn_client_check').click(function(){	
		getMyPlanList("1", "C","${loginUserInfo.user_id}", "Y", "warning");
		$("#service_expired").val("Y");
	});
	
	//기술자 진행건 버튼 클릭시발동
	$('#btn_engineer_ing').click(function(){	
		getMyPlanList("1", "E","${loginUserInfo.user_id}", "N", "success");
		$("#service_expired").val("N");
	});
	
	//기술자 완료건 버튼 클릭시발동
	$('#btn_engineer_check').click(function(){	
		getMyPlanList("1", "E","${loginUserInfo.user_id}", "Y", "info");
		$("#service_expired").val("Y");
	});
	
});


function getLabelName(category_srl, subcategory_srl) {

	var url = "${pageContext.request.contextPath}/board/json/subcategory_list.json";

	var returnLabel = "";
	var params = "category_srl=" + category_srl + "&subcategory_srl=" + subcategory_srl;

	$.ajax({
		async : false,
		cache : false, // 캐시 사용 없애기
		type : 'get',
		url : url,
		data : params,
		//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
		//contentType: 'application/json; charset=utf-8',
		dataType : 'json',
		//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
		//dataType: "text",	
		success : function(data) {
			//alert(JSON.stringify(data));
			$.each(data.subCategoryList, function(index, categoryVO) { // each로 모든 데이터 가져와서 items 배열에 넣고

				if (categoryVO.category_srl == 1)
					returnLabel += "<span class=\"category label label-default text-danger\">" + categoryVO.category_name + "-" + categoryVO.subcategory_name + "</span>";
				else if (categoryVO.category_srl == 2)
					returnLabel += "<span class=\"category label label-primary text-danger\">" + categoryVO.category_name + "-" + categoryVO.subcategory_name + "</span>";
				else if (categoryVO.category_srl == 3)
					returnLabel += "<span class=\"category label label-success text-danger\">" + categoryVO.category_name + "-" + categoryVO.subcategory_name + "</span>";
				else if (categoryVO.category_srl == 4)
					returnLabel += "<span class=\"category label label-info text-danger\">" + categoryVO.category_name + "-" + categoryVO.subcategory_name + "</span>";
				else if (categoryVO.category_srl == 5)
					returnLabel += "<span class=\"category label label-warning text-danger\">" + categoryVO.category_name + "-" + categoryVO.subcategory_name + "</span>";
				else
					returnLabel += "<span class=\"category label label-danger text-danger\">" + categoryVO.category_name + "-" + categoryVO.subcategory_name + "</span>";

				return false;

			});//each끝

			//alert(inHTML);
			//$('#hot_engineer_div').html(items);

		},

		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}

	});

	return returnLabel;
}

function getMyStarScore(user_id){
	var params = "nowPage=1&board_type=&user_id="+user_id+"&service_expired=Y";
	//alert(url); 디버깅용
	//alert(params); 디버깅용
	var url = "${pageContext.request.contextPath}/board/json/service_list.json";
	var totalScore = 0;
	var avgScore = 0;
	$.ajax({
		async : false,
		url : url,
		dataType : "json",
		type : "get",
		data : params,
		contentType : "text/html; charset=utf-8",
		success : function(data) {
			
			//성공자료 갯수파악
			//alert("sucess : " + data);
			$.each(data.searchList, function(index, lists) {
				totalScore += lists.service_score;	
			});//each끝
			
			//alert("해당 자료는 총 "+Count.searchList.length+"개 입니다.");
		    
			if(data.searchList.length>0)
			avgScore = totalScore / data.searchList.length;
			//alert(Count);
			for(var i=1;i<=avgScore ;i++){
				
				$("#starScoreImg").append("<img src=\"${pageContext.request.contextPath}/resources/images/star.png\">");
				
			}
			
		},
		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}
	});
	return avgScore;
	
}
function setMyStarScore(value){
	$("#starScore").html(value);
	
}

function setMyPlanCount(selectorName,value){
	
	
	//alert(selectorName+value);
	$(selectorName).html(value);
}

function getMyPlanCount(nowPage, board_type,user_id, service_expired){
	
	var params = "nowPage="+nowPage+"&board_type="+board_type+"&user_id="+user_id+"&service_expired="+service_expired;
	//alert(url); 디버깅용
	//alert(params); 디버깅용
	var url = "${pageContext.request.contextPath}/board/json/service_list.json";
	var returnVal = 0;
	$.ajax({
		async : false,
		url : url,
		dataType : "json",
		type : "get",
		data : params,
		contentType : "text/html; charset=utf-8",
		success : function(data) {
			
			//성공자료 갯수파악
			//alert("sucess : " + data);
			var Count = data;
			//alert("해당 자료는 총 "+Count.searchList.length+"개 입니다.");
		    returnVal = Count.searchList.length;
			
			//alert(Count);
			
			
		},
		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}
	});
	return returnVal;
}


function servicePaging(nowPage, category_srl, subcategory_srl, board_type, searchType, keyword) {
	//var params = "nowPage=" + nowPage + "&board_type=" + board_type + "&pageSize=6&blockPage=5&keyword=" + keyword + "&searchType=" + searchType;
	//alert(params);
	var service_expired = $("#service_expired").val();
	getMyPlanList(nowPage, board_type,"${loginUserInfo.user_id}", service_expired);

}


function getMyPlanList(nowPage, board_type,user_id, service_expired, color) {
	nowPage = typeof nowPage !== 'undefined' ? nowPage : 1;

	service_srl = typeof service_srl !== 'undefined' ? service_srl : 1;

	var url = "${pageContext.request.contextPath}/board/json/service_list.json";
	
	var inHTML = "";

	//inHTML += "<div class=\"table-responsive\">";
		inHTML += "<table class=\"table table-hover\">";
			inHTML += "<colgroup>";
				inHTML += "<col width=\"14%\">";
				inHTML += "<col width=\"12%\">";
				inHTML += "<col width=\"*%\">";
				inHTML += "<col width=\"12%\">";
				inHTML += "<col width=\"14%\">";
				inHTML += "<col width=\"10%\">";
				inHTML += "<col width=\"10%\">";
			inHTML += "</colgroup>"
			inHTML += "<thead>";
			if(typeof service_srl !== 'undefined') 
			inHTML += "<tr class=\""+color+"\">";
				inHTML += "<th>서비스 구분</th>";
				inHTML += "<th>아이디</th>";
				inHTML += "<th>제목</th>";
				inHTML += "<th>예상비용</th>";
				inHTML += "<th>서비스기간</th>";
				inHTML += "<th>지역</th>";
				inHTML += "<th>조회수</th>";
			inHTML += "</tr>";
			inHTML += "</thead>";
			inHTML += "<tbody>";
		
	var inHTMLPaging = "";
	$("#mylist-area").empty();
	var params = "nowPage="+nowPage+"&board_type="+board_type+"&user_id="+user_id+"&service_expired="+service_expired;
	//alert(url); 디버깅용
	//alert(params); 디버깅용
	$.ajax({
		url : url,
		dataType : "json",
		type : "get",
		data : params,
		contentType : "text/html; charset=utf-8",
		success : function(data) {
			
			//성공자료 갯수파악
			//alert("sucess : " + data);
			var Count = data;
			//alert(Count);
			//alert("해당 자료는 총 "+Count.searchList.length+"개 입니다.");
			
			$.each(data.searchList, function(index, lists) { // each로 모든 데이터 가져와서 items 배열에 넣고
				
				
				
				inHTML += "<tr>";
					inHTML += "<td>"+getLabelName(lists.category_srl, lists.subcategory_srl)+"</td>";
					/* inHTML += "<td>"+lists.user_id+"</td>"; */
					inHTML += "<td><div class=\"popup\" onclick=\"popUserMenu()\">"+lists.user_id;
					inHTML += "<span class=\"popuptext\" id=\"userPopup\">";
					inHTML += "<a href=\"${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}\">회원정보보기</a><br/>";
					inHTML += "<a href=\"${pageContext.request.contextPath}/message\">쪽지보내기</a><br/>";
					<c:if test="${not empty loginUserInfo && loginUserInfo.is_admin=='Y'}">
					inHTML += "<a href=\"${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}\">작성글보기</a><br/>";
					inHTML += "<a href=\"${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}\">회원정보관리</a><br/>";							
					</c:if>
					inHTML += "</span>";
					inHTML += "</div></td>";
					inHTML += "<td><a href=\"javascript:viewPage("+lists.board_srl+")\">"+lists.title+"</a></td>";
					inHTML += "<td>"+lists.service_cost+"</td>";
					inHTML += "<td>"+lists.service_time_start+"<br/> ~ "+lists.service_time_end+"</td>";
					inHTML += "<td>"+lists.location+"</td>";
					inHTML += "<td>"+lists.visitcount+"</td>";
				inHTML += "</tr>";

			});//each끝
			inHTML += "</tbody>";
		inHTML += "</table>";
		
		inHTML += "<div class=\"row text-center\">";
		inHTML += "<ul class=\"pagination\" id=\"myPlanPagingDiv\">";
		inHTML += "</ul></div>";
	//inHTML += "</div>";
		
		if (jQuery.isEmptyObject(data.searchList)) {
			$('#mylist-area').html("<div class=\"row\"><br/><br/><br/><br/><br/><br/><br/><b>해당 하는 검색 결과가 없습니다.</b><br/><br/><br/><br/><br/><br/><br/><br/></div>");
		} else {
			$('#mylist-area').html(inHTML);
		}
			$("#myPlanPagingDiv").html(data.pagingDiv);
		},
		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}
	});
}


//상세보기 폼으로 이동하기
function viewPage(board_srl){
	
	$.ajax({
		url : "./myplan/view",
		dataType : "html",
		type : "get",
		contentType : "text/html; charset:utf-8",
		data : {board_srl : board_srl},
		success : function(d){
			$("#mylist-area").empty();
			$('#mylist-area').html(d);
			
		},
		error : function(e){
			alert("요청실패:"+e.status+"  "+e.statusText);
		}
	});
}



</script>

</head>

<body id="body-bg">
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

	<!-- Top영역 1첫번째 -->
	<div class="row">
		<%@ include file="../common/commonTop_1.jsp"%>
	</div>
	<!-- Top영역 2첫번째  (마이페이지부분의 탑2 적용)-->
	<div class="row">
		<%@ include file="../common/commonTop_2_mypage.jsp"%>
	</div>
	
	<!-- 몸체부분 -->
	<div class="container container-body">
		<div class="row myplan-title">
			<div class="col-xs-12 height-good">
				<h2>
					<b>나의 플래너스</b>
				</h2>
			</div>
		</div>
		<div class="row myplan-body">
			<div class="col-xs-3">
				<div class="row">
					<div class="col-xs-12 margin-top-10">
						<div class="panel panel-default border-radius-none margin-none " >
							<div class="panel-body position-relative padding-bottom-0" id="panel-body">
								<div class="row">
									<div class="col-xs-12 dashboard-profile text-center">
										<div class="dashboard-profile-body">
											<c:choose>
											<c:when test="${not empty loginUserInfo.profile_img_path}">
			<%-- 									<c:when test="${(not empty loginUserInfo) && loginUserInfo.profile_img_path!='' && not empty loginUserInfo.profile_img_path}"> --%>
													<img src="${pageContext.request.contextPath}/resources/upload/member/${loginUserInfo.member_srl}/profile/${loginUserInfo.profile_img_path}" class="border-round" />
												</c:when>
												<c:otherwise>
													<img class="border-round profile-image" src="${pageContext.request.contextPath}/resources/images/main_user_gray.png" id="profile_Img" >
												</c:otherwise>
											</c:choose>
											<div class="user_id">
												${loginUserInfo.user_id }
											</div>
											<div class="dashboard-profile-grade userProfileRanking NEW">
												<a href="${pageContext.request.contextPath}/grade"> <img src="/img/tools/grade/kmong_grade_NEW.png" data-toggle="tooltip" data-placement="right" title="" data-original-title=NEW>
												</a>
											</div>
										</div>
									</div>
									<div class="col-xs-12">
										<div class="row" style="margin-bottom: 10px;">
											<div id="satisfaction" class="col-xs-12 cursor">
												<h5 class="header-margin-none font-color-lighter menu-sotitle">
												만족도(<span id="starScore"></span>)
												</h5>
												<br/>
												<span class="pull-left" style="margin-top: -30px;" id="starScoreImg">
													
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="row margin-top-20 dashboard-user-information">
									<div class="col-xs-12">
										<div data-toggle="tooltip" data-placement="right">
											<h5 class="header-margin-none menu-sotitle">
												의뢰한 건 매칭성공률 <span class="pull-right"><b>${clientMatchingPrecent}%</b></span>
											</h5>
										</div>
									</div>
								</div>
								<div class="row dashboard-user-information-progress margin-top-5 border-bottom-solid">
									<div class="padding-myplan">
										<div class="progress">
										    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuemin="0" aria-valuemax="100" 
										    style="width:${clientMatchingPrecent}%; text-align: center;">
										      	${clientMatchingPrecent}%
										    </div>
									  	</div>
									</div>
								</div>

								<div class="row margin-top-20 dashboard-user-information">
									<div class="col-xs-12">
										<div data-toggle="tooltip" data-placement="right">
											<h5 class="header-margin-none menu-sotitle">
												기술나눔 매칭성공률 <span class="pull-right"><b>${engineerMatchingPrecent}%</b></span>
											</h5>
										</div>
									</div>
								</div>
								<div class="row dashboard-user-information-progress margin-top-5 border-bottom-solid">
									<div class="padding-myplan">
										<div class="progress">
										    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuemin="0" aria-valuemax="100" 
										    style="width:${engineerMatchingPrecent}%; text-align: center;">
										      	${engineerMatchingPrecent}%
										    </div>
									  	</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<input type="hidden" name="service_expired" id="service_expired">
			
			<div class="col-xs-9">
				<div class="row margin-top-10">
					<div class="col-xs-12">
						<div class="panel panel-default margin-top-0 border-radius-0">
							<div class="panel-body">
								<div class="row">
									<div class="col-xs-3 text-center border-right">
										<button type="button" class="btn btn-default btn-sotitle" id="btn_client_ing">요청자 진행 건</button>
											<h4 class="header-margin-none margin-top-5">
												<b>(<span>${clientListUnCheck_TotalRecordCount}</span>) </b>
											</h4>
									</div>
									<div class="col-xs-3 text-center border-right">
										<button type="button" class="btn btn-default btn-sotitle" id="btn_client_check">요청자 완료 건</button>
											<h4 class="header-margin-none margin-top-5">
												<b>(<span>${clientListCheck_TotalRecordCount}</span>) </b>
											</h4>
									</div>
									<div class="col-xs-3 text-center border-right">
										<button type="button" class="btn btn-default btn-sotitle" id="btn_engineer_ing">기술자 진행 건</button>
											<h4 class="header-margin-none margin-top-5">
												<b>(<span>${engineerListUnCheck_TotalRecordCount}</span>) </b>
											</h4>
									</div>
									<div class="col-xs-3 text-center">
										<button type="button" class="btn btn-default btn-sotitle" id="btn_engineer_check">기술자 완료 건</button>
											<h4 class="header-margin-none margin-top-5">
												<b>(<span>${engineerListCheck_TotalRecordCount}</span>) </b>
											</h4>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 리스트 뿌려주는 부분 -->
				<div class="row">
					<div class="col-xs-12">
						<div class="mylist-area panel panel-default border-radius-none" id="mylist-area">
							<br/><br/><br/><br/><br/><br/><br/>
							<b>각 부분의 버튼을 클릭시 나의 목록정보가 나옵니다.</b>
							<br/><br/><br/><br/><br/><br/><br/><br/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 몸체부분 -->
		

	<!-- 모달창 -->
	<%@ include file="../common/modal_msg.jsp"%>
	<!-- //모달창 끝 -->

	<!-- Footer section(하단부분) -->
	<%@ include file="../common/commonBottom.jsp"%>
	<!-- Footer section(하단부분) -->
	</div>
</body>
</html>


