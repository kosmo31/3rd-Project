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
<title>서비스 소개|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1_service.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script>
	$(document).ready(function() {

	});
</script>

</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

	<!-- header1(네비게이션 탑1) -->
		<%-- <%@ include file="../common/commonTop_1.jsp"%> --%>
	<!-- header1(네비게이션 탑1) -->
	<!-- header2(네비게이션 탑2) -->
		<%-- <%@ include file="../common/commonTop_2_mypage.jsp"%> --%>
	<!-- header2(네비게이션 탑2) -->
	
	<!-- 탑부분(기본적인 틀) -->
	<nav class="navber" id="navbar-fixed-top">
		<div class="container-fluid service-image">
			<div class="row">
				<div class="col-lg-2 col-sm-1 col-xs-0"></div>
				<div class="col-lg-8 col-sm-10 col-xs-12">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
							<span class="glyphicon glyphicon-align-justify"></span>
						</button>
						<a class="navbar-brand" id="navbar-brand"
							href="${pageContext.request.contextPath}"><b>♣</b>
							OurPlanners</a>
					</div>
					<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right" id="navbar-nav">
						<li><a href="${pageContext.request.contextPath}/board/service?board_type=E">기술자 게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/board/service?board_type=C">의뢰인 게시판</a></li>
						<c:choose>
						<c:when test="${empty loginUserInfo}">
							<li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
							<li><a href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<li class="dropdown size-up">
							<a class="dropdown-toggle margin-left-10" data-toggle="dropdown" href="javascript:void(0);">
							<c:choose>
								<c:when test="${loginUserInfo.profile_img_path==null}">
									<img class="id-image" src="${pageContext.request.contextPath}/resources/images/main_user_gray.png"  />
								</c:when>
								<c:otherwise>
									<img class="id-image" src="${pageContext.request.contextPath}/upload/displayFile?fileName=${loginUserInfo.profile_img_path}&directory=member/${loginUserInfo.member_srl}/profile"  />
								</c:otherwise>
							</c:choose>
							<span class="text-uppercase">${loginUserInfo.user_id}님</span> <span class="caret"></span></a>
								<ul class="dropdown-menu" id="dropdown-menu">
									<c:if test="${not empty loginUserInfo && loginUserInfo.is_admin=='Y'}">
										<li><a href="${pageContext.request.contextPath}/admin/">관리자페이지</a></li>
									</c:if>
									<li><a href="${pageContext.request.contextPath}/mypage/myplan">마이플랜</a></li>
									<li><a href="${pageContext.request.contextPath}/message">쪽지함</a></li>
									<li><a href="${pageContext.request.contextPath}/profile/${loginUserInfo.user_id}">프로필</a></li>
									<li><a href="${pageContext.request.contextPath}/member/myinfo">계정정보</a></li>
									<li><a href="${pageContext.request.contextPath}/member/change_password">비밀번호 변경</a></li>
									<li><a href="${pageContext.request.contextPath}/member/withdraw">회원탈퇴</a></li>
								</ul>
							</li>
							<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
						</c:otherwise>
						</c:choose>
					</ul>
					</div>
				</div>
				<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			</div>
		</div>
	</nav>
	<!-- 탑부분(기본적인 틀) -->
	
	<!-- 전문적인 서비스알림 -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<div class="service-title-div">
					<h1>전문적인 서비스</h1>
					<h2>각 분야의 전문가 <b>${engineerMember_TotalCount}명</b>의 <b>차별화된 서비스</b>를 이용해보세요.</h2>
					
					<div class="position-relative bg-color-f6 padding-all-20" style="width: 29%">
                        <img class="position-absolute bottom-0 right-0" src="${pageContext.request.contextPath}/resources/images/img_category_design.png">
                        <h4 class="margin-none font-color-lighter">디자인 전문가의 자료</h4>
                        <div class="margin-top-30" style="font-size: 28px !important;"><span class="count">${engineerCateGory1_TotalCount}</span>건</div>
                    </div>
                    
                    <div class="position-relative bg-color-f6 padding-all-20 margin-left-10" style="width: 24%">
                        <img class="position-absolute bottom-0 right-0" src="${pageContext.request.contextPath}/resources/images/img_category_marketing.png">
                        <h4 class="margin-none font-color-lighter">마케팅 전문가의 자료</h4>
                        <div class="margin-top-30" style="font-size: 28px !important;"><span class="count">${engineerCateGory2_TotalCount}</span>건</div>
                    </div>
                    
                    <div class="position-relative bg-color-f6 padding-all-20 margin-left-10" style="width: 17%">
                        <img class="position-absolute bottom-0 right-0" src="${pageContext.request.contextPath}/resources/images/img_category_it.png">
                        <h4 class="margin-none font-color-lighter">IT&amp;개발 전문가자료</h4>
                        <div class="margin-top-30" style="font-size: 28px !important;"><span class="count">${engineerCateGory3_TotalCount}</span>건</div>
                    </div>
                    
                    <div class="position-relative bg-color-f6 padding-all-20 margin-left-10" style="width: 11%">
                        <img class="position-absolute bottom-0 right-0" src="${pageContext.request.contextPath}/resources/images/img_category_content.png">
                        <h4 class="margin-none font-color-lighter line-height">컨텐츠제작<br>전문가<br>자료</h4>
                        <div class="margin-top-10" style="font-size: 20px !important;"><span class="count">${engineerCateGory4_TotalCount}</span>건</div>
                    </div>
                    
                    <div class="position-relative bg-color-f6 padding-all-20 margin-left-10" style="width: 10%">
                        <img class="position-absolute bottom-0 right-0" src="${pageContext.request.contextPath}/resources/images/img_category_translate.png">
                        <h4 class="margin-none font-color-lighter line-height">번역&amp;<br>통역전문<br>자료</h4>
                        <div class="margin-top-10" style="font-size: 20px !important;"><span class="count">${engineerCateGory5_TotalCount}</span>건</div>
                    </div>
				</div>
			</div>
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		</div>
	</div>
	<!-- 전문적인 서비스알림 -->
	
	
		<!-- HOME -->
		<section class="section page-services" style="margin-top: 120px; background-color: #F1F1F1;">
			<div class="container">
				<div class="service-text1">
					<h1>간편한 매칭과정</h1>
					<h2>나에게 맞는 서비스를 <b>손쉽게 찾고 간편하게 매칭</b>할 수 있습니다.</h2>
				</div>
				<div class="row service-size">
					<div class="col-sm-4 col-md-3 sm-box">
					
						<ul class="nav nav-tabs vertical text-whtie-bold">
							<li class="active"><a href="#tab1" data-toggle="tab">서비스 찾기</a></li>
							<li><a href="#tab2" data-toggle="tab">서비스 비교</a></li>
							<li><a href="#tab3" data-toggle="tab">매칭하기</a></li>
							<li><a href="#tab4" data-toggle="tab">평가하기</a></li>
						</ul>
					</div>
					<div class="col-sm-8 col-md-9">
						<div class="tab-content">
							<div class="tab-pane fade in active" id="tab1">
								<h3 class="box-title-bt2">서비스 찾기</h3>
								<p class="box-title-bt3">'검색'또는 '카테고리 선택'을 통해 원하는 서비스들을 확인합니다.</p>
								<div class="images-info">
									<img src="${pageContext.request.contextPath}/resources/images/service-image1.jpg">
								</div>
							</div>
							<div class="tab-pane fade" id="tab2">
								<h3 class="box-title-bt2">서비스 비교</h3>
								<p class="box-title-bt3">서비스의 설명, 예상가격, 평가, 포트폴리오 등을 꼼꼼히 살펴보고, 견적에 맞게 서비스를 선택합니다.</p>
								<div class="images-info-one">
									<img src="${pageContext.request.contextPath}/resources/images/service-image2.jpg">
								</div>
								<div class="images-info-two">
									<img src="${pageContext.request.contextPath}/resources/images/service-image3.jpg">
								</div>
							</div>
							<div class="tab-pane fade" id="tab3">
								<h3 class="box-title-bt2">매칭하기</h3>
								<p class="box-title-bt3">요청란에 요청을 하면 서비스제공자는 요청을 보고 작업이 가능하다면 채택후 연결정보를 주고받고 작업물을 주고 받습니다.</p>
								<div class="images-info-one">
									<img src="${pageContext.request.contextPath}/resources/images/service-image4.jpg">
								</div>
								<div class="images-info-two">
									<img src="${pageContext.request.contextPath}/resources/images/service-image4.jpg">
								</div>
							</div>
							<div class="tab-pane fade" id="tab4">
								<h3 class="box-title-bt2">평가하기</h3>
								<p class="box-title-bt3">작업물을 받은 후, 전문가에 대한 평가를 남깁니다.</p>
								<div class="images-info-one">
									<img src="${pageContext.request.contextPath}/resources/images/service-image6.jpg">
								</div>
								<div class="images-info-two">
									<img src="${pageContext.request.contextPath}/resources/images/service-image6.jpg">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- //HOME -->

		<!-- 모달창 -->
		<%@ include file="../common/modal_msg.jsp"%>
		<!-- //모달창 끝 -->


		<!-- Footer (하단부분) -->
		<%@ include file="../common/commonBottom.jsp"%>
		<!--// Footer (하단부분) -->

	</div>
</body>
</html>
