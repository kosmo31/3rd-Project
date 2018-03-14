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
<title>개인정보취급방침|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
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
		<%@ include file="../common/commonTop_1.jsp"%>
	<!-- header1(네비게이션 탑1) -->
	<!-- header2(네비게이션 탑2) -->
		<%@ include file="../common/commonTop_2_mypage.jsp"%>
	<!-- header2(네비게이션 탑2) -->
	

		<!-- HOME -->
		<section id="main" class="section" style="margin-top: 120px;">

			<!-- CONTAINER -->
			<section class="section team-section">
				<div class="container">
					<div class="row">
						<div class="col-sm-12">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab-team1" data-toggle="tab">프로젝트관리자</a></li>
								<li><a href="#tab-team2" data-toggle="tab">웹 디자이너</a></li>
								<li><a href="#tab-team3" data-toggle="tab">개발자</a></li>
								<li><a href="#tab-team4" data-toggle="tab">마케팅</a></li>
							</ul>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="tab-content">
								<div class="tab-pane fade in active" id="tab-team1">
									<div class="row">
										<div class="col-sm-6 xs-box2">
											<div class="box-team">
												<div class="team-image">
													<img src="${pageContext.request.contextPath}/resources/images/team/ourplanners1.jpg" alt="team">
													<div class="team-links">
														<ul class="social-icon circle">
															<li><a href="#"><i class="fa fa-facebook"></i></a></li>
															<li><a href="#"><i class="fa fa-twitter"></i></a></li>
															<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
															<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
														</ul>
													</div>
												</div>
												<div class="team-info">
													<h3>
														박세창
													</h3>
													<h5>PM, Back End</h5>
													<p>프로젝트의 전반적인 부분을 관리하고 기획, DB설계, 개발, 등을 총괄하고 있다.</p>
												</div>
											</div>
										</div>
										<div class="col-sm-6">
											<div class="box-team">
												<div class="team-image">
													<img src="${pageContext.request.contextPath}/resources/images/team/ourplanners2.jpg" alt="team">
													<div class="team-links">
														<ul class="social-icon circle">
															<li><a href="#"><i class="fa fa-facebook"></i></a></li>
															<li><a href="#"><i class="fa fa-twitter"></i></a></li>
															<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
															<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
														</ul>
													</div>
												</div>
												<div class="team-info">
													<h3>
														이용현
													</h3>
													<h5>Developer, Back End</h5>
													<p>프로젝트의 핵심적인 부분인 게시판과 매칭부분을 개발하고 있다. 또한 DB기획 및 설계 구현을 담당하고 있다.</p>
												</div>
											</div>
										</div>
									</div>
									<div class="row" style="margin-top: 40px;">
										<div class="col-sm-6 xs-box2">
											<div class="box-team">
												<div class="team-image">
													<img src="${pageContext.request.contextPath}/resources/images/team/ourplanners3.png" alt="team">
													<div class="team-links">
														<ul class="social-icon circle">
															<li><a href="#"><i class="fa fa-facebook"></i></a></li>
															<li><a href="#"><i class="fa fa-twitter"></i></a></li>
															<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
															<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
														</ul>
													</div>
												</div>
												<div class="team-info">
													<h3>
														이주찬
													</h3>
													<h5>Developer, Front End</h5>
													<p>서비스의 웹 UI/UX 디자인 및 Front 단 업무를 맡고 있다.</p>
												</div>
											</div>
										</div>
										<div class="col-sm-6">
											<div class="box-team">
												<div class="team-image">
													<img src="${pageContext.request.contextPath}/resources/images/team/ourplanners4.png" alt="team">
													<div class="team-links">
														<ul class="social-icon circle">
															<li><a href="#"><i class="fa fa-facebook"></i></a></li>
															<li><a href="#"><i class="fa fa-twitter"></i></a></li>
															<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
															<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
														</ul>
													</div>
												</div>
												<div class="team-info">
													<h3>
														김남호
													</h3>
													<h5>Developer, Front End</h5>
													<p>서비스의 메세지(쪽지) 관련 기능을 담당하고 있다.</p>
												</div>
											</div>
										</div>
									</div>
									<div class="row" style="margin-top: 40px;">
										<div class="col-sm-6 xs-box2">
											<div class="box-team">
												<div class="team-image">
													<img src="${pageContext.request.contextPath}/resources/images/team/ourplanners5.jpg" alt="team">
													<div class="team-links">
														<ul class="social-icon circle">
															<li><a href="#"><i class="fa fa-facebook"></i></a></li>
															<li><a href="#"><i class="fa fa-twitter"></i></a></li>
															<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
															<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
														</ul>
													</div>
												</div>
												<div class="team-info">
													<h3>
														서정훈
													</h3>
													<h5>Designer</h5>
													<p>서비스의 Front단 포토샵 작업과 디자인을 담당하고있다. 또한 테스트작업을 담당하고 있다. </p>
												</div>
											</div>
										</div>
										<div class="col-sm-6">
											<div class="box-team">
												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- //CONTAINER -->


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
