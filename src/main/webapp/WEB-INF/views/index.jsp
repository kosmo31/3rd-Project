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
<meta name="description" content="메인">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메인|OUR PLANNERS</title>

<jsp:useBean id="today" class="java.util.Date" scope="page" />


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/video.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
<script src="${pageContext.request.contextPath}/resources/js/op.index.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
</head>

<body id="total-bg">
	<!-- PRELOADER -->

<div id="introLoader" class="introloader">
  <div class="spinner">
    <div class="spinner-inner"><img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" /></div>
  </div>
</div>
	
	<!-- //PRELOADER -->
	<div class="preloader_hide">

	<!-- header1(네비게이션 탑1) -->
		<%@ include file="./common/commonTop_1_index.jsp"%>
	<!-- header1(네비게이션 탑1) -->
	<!-- header2(네비게이션 탑2) -->
		<%@ include file="./common/commonTop_2_index.jsp"%>
	<!-- header2(네비게이션 탑2) -->
		
	<!-- 모달창 메시지 -->
		<%@ include file="common/modal_msg.jsp"%>
	<!--// 모달창 메시지 --> 

	
	<!-- 탑부분(기본적인 틀) -->
	<nav class="navber" id="navbar-fixed-top">
		<div class="container-fluid">
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
	
	<!-- 검색, 핫 키워드 -->
	<%@ include file="wordcloud/wordcloud.jsp"%>
	<!--// 검색, 핫 키워드 -->
			
	<!-- 카테고리(분야별 링크 부분) -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12">
				<div class="row">
					<!-- 건축분야 -->
					<div class="col-lg-2 col-sm-2 image-size-c">
						<figure class="snip1206">
							<img src="${pageContext.request.contextPath}/resources/images/categorie11.jpg" alt=""/>
							<figcaption>
								<h2><b>건축</b></h2>
								<p>기술자와 의뢰인의 만남에 공간입니다</p>
							</figcaption>
							<a href="${pageContext.request.contextPath}/board/service?category_srl=1"></a>
						</figure>
					</div>
					
					<!-- IT분야 -->
					<div class="col-lg-2 col-sm-2 image-size-c">
						<figure class="snip1206">
							<img src="${pageContext.request.contextPath}/resources/images/categorie88.jpg" alt=""/>
							<figcaption>
								<h2><b>디자인</b></h2>
								<p>기술자와 의뢰인의 만남에 공간입니다</p>
							</figcaption>
							<a href="${pageContext.request.contextPath}/board/service?category_srl=2"></a>
						</figure>
					</div>

					<!-- 자동차분야 -->
					<div class="col-lg-2 col-sm-2 image-size-c">
						<figure class="snip1206">
							<img src="${pageContext.request.contextPath}/resources/images/categorie22.jpg" alt=""/>
							<figcaption>
								<h2><b>IT프로그래밍</b></h2>
								<p>기술자와 의뢰인의 만남에 공간입니다</p>
							</figcaption>
							<a href="${pageContext.request.contextPath}/board/service?category_srl=3"></a>
						</figure>
					</div>

					<!-- 교육분야 -->
					<div class="col-lg-2 col-sm-2 image-size-c">
						<figure class="snip1206">
							<img src="${pageContext.request.contextPath}/resources/images/categorie55.jpg" alt=""/>
							<figcaption>
								<h2><b>번역&통역</b></h2>
								<p>기술자와 의뢰인의 만남에 공간입니다</p>
							</figcaption>
							<a href="${pageContext.request.contextPath}/board/service?category_srl=4"></a>
						</figure>
					</div>
					
					<!-- 번역%통역분야 -->
					<div class="col-lg-2 col-sm-2 image-size-c">
						<figure class="snip1206">
							<img src="${pageContext.request.contextPath}/resources/images/categorie77.jpg" alt=""/>
							<figcaption>
								<h2><b>컨텐츠제작</b></h2>
								<p>기술자와 의뢰인의 만남에 공간입니다</p>
							</figcaption>
							<a href="${pageContext.request.contextPath}/board/service?category_srl=5"></a>
						</figure>
					</div>
					
					<!-- 컨텐츠분야 -->
					<div class="col-lg-2 col-sm-2 image-size-c">
						<figure class="snip1206">
							<img src="${pageContext.request.contextPath}/resources/images/categorie44.jpg" alt=""/>
							<figcaption>
								<h2><b>핸드메이드</b></h2>
								<p>기술자와 의뢰인의 만남에 공간입니다</p>
							</figcaption>
							<a href="${pageContext.request.contextPath}/board/service?category_srl=6"></a>
						</figure>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 카테고리(분야별 링크 부분) -->
			
	<!-- 인기게시물(의뢰인 기술주 부분) -->
	<%@ include file="board/hot/board_hot_list.jsp"%>

	<!-- 플레너스 자랑하는부분 -->
	<div class="container-fluid">
		<div class="row gray-bg">
			<div class="col-sm-2 col-xs-1"></div>
			<div class="col-sm-8 col-xs-10">
				<div class="sub-ments">
					<h4>전문적인 서비스</h4>
					<p>각 분야 전문가 98,868명의 </p>
					<p>차별화된 서비스를 이용해보세요.</p>
				</div>
				<div class="sub-ments">
					<h4>만족도 높은 결과물</h4>
					<p>의뢰인 평점 98%에 달하는 </p>
					<p>정확하고 만족도 높은 서비스를 경험해보세요.</p>
				</div>
				<div class="sub-ments">
					<h4>안전한 거래 시스템</h4>
					<p>543,613건의 거래를 완료한 </p>
					<p>안전한 주문 시스템을 이용해보세요.</p>
				</div>
			</div>
			<div class="col-sm-2 col-xs-1"></div>
		</div>
	</div>
	<!-- 플레너스 자랑하는부분 -->
	
    <!-- Video Modal -->
    <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="index-seller-modal-dialog modal-dialog" role="document" style="width: 853px;">
            <div class="modal-content border-radius-none position-relative">
                <a class="index-seller-close plain position-absolute font-size-h1 color-white" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
                <div class="modal-body position-relative padding-all-0">
                    <video id="firstVideo" style="display: none;" class="video-js vjs-default-skin" width="853px" height="479px" controls preload="none" poster='https://d2v80xjmx68n4w.cloudfront.net/intro/FRNfMx5PJ7xCLBwMRkBP.png'>
                        <source src="https://d2v80xjmx68n4w.cloudfront.net/intro/FRNfMx5PJ7xCLBwMRkBP.mp4" type='video/mp4' />
                    </video>

                    <video id="secondVideo" style="display: none;" class="video-js vjs-default-skin" width="853px" height="479px" controls preload="none" poster='https://d2v80xjmx68n4w.cloudfront.net/intro/DA7y28XVQYYeDTFYOaru.png'>
                        <source src="https://d2v80xjmx68n4w.cloudfront.net/intro/DA7y28XVQYYeDTFYOaru.mp4" type='video/mp4' />
                    </video>

                    <video id="thirdVideo" style="display: none;" class="video-js vjs-default-skin" width="853px" height="479px" controls preload="none" poster='https://d2v80xjmx68n4w.cloudfront.net/intro/47D2uBC8XpuifXhWY8Pb.png'>
                        <source src="https://d2v80xjmx68n4w.cloudfront.net/intro/47D2uBC8XpuifXhWY8Pb.mp4" type='video/mp4' />
                    </video>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 
    팝업창 열기
    <a href="popup.html" onclick="window.open(this.href, 'popupName', 'width=300,height=200'); return false;">
	<img src="openWindow.gif">
</a>
     -->
	<script>
      var videos = {}
      var currentVideoTarget = ''
      var $videoModal = $('#videoModal')

      videos['firstPlayer'] = videojs('firstVideo', {}, function onPlayerReady () {})
      videos['secondPlayer'] = videojs('secondVideo', {}, function onPlayerReady () {})
      videos['thirdPlayer'] = videojs('thirdVideo', {}, function onPlayerReady () {})
      function openVideoModal (id) {
        currentVideoTarget = id
        $('#' + currentVideoTarget + 'Video').show()
        $('#' + currentVideoTarget + 'Video_html5_api').show()
        $videoModal.modal('show')
      }

      $videoModal.on('shown.bs.modal', function () {
        videos[currentVideoTarget + 'Player'].play()
      })

      $videoModal.on('hide.bs.modal', function () {
        $('#' + currentVideoTarget + 'Video').hide()
        videos[currentVideoTarget + 'Player'].pause()
      })

      var currentViewGigsSlider = null
      $(document).ready(function () {

        var mainHeaderGigsContainerHeight = $('#mainHeaderGigsContainer').height() + 40, // padding-botttom-40
          rootCategoryContainerScrollTop = $('#rootCategoryContainer').height() + 80 + mainHeaderGigsContainerHeight - 120, // margin-top-80 headerheight=60
          $window = $(window),
          $kmongNavBar = $('#mainKmongNavBar'),
          $categoryHeader = $('#indexCategoryHeader'),
          isAnimatingKmongHeader = false,
          isAnimatingCategoryHeader = false


        if ($window.scrollTop() > mainHeaderGigsContainerHeight) {
          if (!$kmongNavBar.is(':visible') && isAnimatingKmongHeader === false) {
            isAnimatingKmongHeader = true
            $kmongNavBar.fadeIn(300, function () {
              isAnimatingKmongHeader = false
            })
          }

          if ($(this).scrollTop() > rootCategoryContainerScrollTop) {
            if (!$categoryHeader.is(':visible') && isAnimatingCategoryHeader === false) {
              isAnimatingCategoryHeader = true
              $categoryHeader.fadeIn(300, function () {
                isAnimatingCategoryHeader = false
              })
            }
          } else {
            if ($categoryHeader.is(':visible') && isAnimatingCategoryHeader === false) {
              isAnimatingCategoryHeader = true
              $categoryHeader.fadeOut(300, function () {
                isAnimatingCategoryHeader = false
              })
            }
          }

        } else {
          if ($kmongNavBar.is(':visible') && isAnimatingKmongHeader === false) {
            isAnimatingKmongHeader = true
            if (isAnimatingKmongHeader)
              $kmongNavBar.fadeOut(300, function () {
                isAnimatingKmongHeader = false
              })
          }
        }
        $window.scroll(function () {
          var scrollTop = $(this).scrollTop()
          if (scrollTop > mainHeaderGigsContainerHeight) {
            if (!$kmongNavBar.is(':visible') && isAnimatingKmongHeader === false) {
              isAnimatingKmongHeader = true
              $kmongNavBar.fadeIn(300, function () {
                isAnimatingKmongHeader = false
              })
            }

            if (scrollTop > rootCategoryContainerScrollTop) {
              if (!$categoryHeader.is(':visible') && isAnimatingCategoryHeader === false) {
                isAnimatingCategoryHeader = true
                $categoryHeader.fadeIn(300, function () {
                  isAnimatingCategoryHeader = false
                })
              }
            } else {
              if ($categoryHeader.is(':visible') && isAnimatingCategoryHeader === false) {
                isAnimatingCategoryHeader = true
                $categoryHeader.fadeOut(300, function () {
                  isAnimatingCategoryHeader = false
                })
              }
            }

          } else {
            if ($kmongNavBar.is(':visible') && isAnimatingKmongHeader === false) {
              isAnimatingKmongHeader = true
              if (isAnimatingKmongHeader)
                $kmongNavBar.fadeOut(300, function () {
                  isAnimatingKmongHeader = false
                })
            }
          }
        })

        if (typeof master_vue !== 'undefined') {
          var currentViewedGigs = getCookie('CURRENT_VIEWED_GIGS')

          if (!(currentViewedGigs === '' || currentViewedGigs === '[]')) {
            $('#currentViewedGigsContainer').fadeIn(300)
            master_vue.getCurrentViewGigs()
          }
        }
      })
    </script>

	<!-- video section(홍보영상 분분) -->
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<div id="buyerVideoCarousel" class="carousel slide index-carousel"
				data-ride="carousel" data-interval="false">
				<div class="carousel-inner" role="listbox" style="padding-left: 15px; padding-right: 15px;">
					<div style="padding-bottom: 0px;"
						class="item panel panel-default border-radius-0 margin-none position-relative active">
						<div class="row">
							<div
								class="col-xs-5 padding-right-0 position-relative overflow-hidden">
								<a class="index-buyer-images" href="javascript:void(0);"
									onclick="openVideoModal('first')">
										<img class="width-100" style="width: 100%; height: 360px;"
											src="https://kmong.com/img/main/desktop/buyer_review_1.png"
											alt="전문가 동영상"> <img style="width: 50px; height: 50px;"
											class="width-50px index-seller-play-image"
											src="https://kmong.com/img/main/desktop/index_seller_play.png"
											alt="플레이 버튼">
								</a>
							</div>
							<div class="col-xs-7 padding-left-0">
								<div class="buyer-video-text">
									<h2
										class="padding-left-50 margin-bottom-0 margin-top-10 color-e6"
										style="font-size: 50px !important; text-align: left; ">“</h2>
									<h4
										class="text-center text-style margin-none padding-left-60 padding-right-60"
										style="height: 110px; font-size: 17px; font-weight:bold; color: #787878;">
										장사하기 바빠서 마케팅에 신경 쓸 여유가 많이 없는데,<br> 아워플레너스는 가격도 저렴하고 효과도 좋아서
										종종 이용하고 있습니다.<br> 다른 사람들한테 소개하기 좀 아까울 정도로 좋은 사이트예요!
									</h4>
									<h2 class="padding-right-50 margin-top-10 text-right color-e6"
										style="font-size: 50px !important;">”</h2>
									<h5 class="text-center margin-top-0 margin-bottom-5">
										<b>최상규님</b>
									</h5>
									<h6 class="header-margin-none text-center">와인바 부사장</h6>
								</div>
							</div>
						</div>
					</div>

					<div
						class="item panel panel-default border-radius-0 margin-none position-relative">
						<div class="row">
							<div
								class="col-xs-5 padding-right-0 position-relative overflow-hidden">
								<a class="index-buyer-images" href="javascript:void(0);"
									onclick="openVideoModal('second')">
										<img class="width-100" style="width: 100%; height: 360px;"
											src="https://kmong.com/img/main/desktop/buyer_review_2.png"
											alt="전문가 동영상"> <img style="width: 50px; height: 50px;"
											class="width-50px index-seller-play-image"
											src="https://kmong.com/img/main/desktop/index_seller_play.png"
											alt="플레이 버튼">
								</a>
							</div>
							<div class="col-xs-7 padding-left-0">
								<div class="buyer-video-text">
									<h2
										class="padding-left-50 margin-bottom-0 margin-top-10 color-e6"
										style="font-size: 50px !important; text-align: left;">“</h2>
									<h4
										class="text-center text-style margin-none padding-left-60 padding-right-60"
										style="height: 110px; font-size: 17px; font-weight:bold; color: #787878;">그냥 한 번 들어나보자 하는 마음으로 구매했던 건데, 생각보다
										많은 조언을 들을 수 있었습니다. 실시간으로 메시지가 바로바로 되니까 미팅 장소, 날짜 잡기도 수월했습니다.
										앞으로는 창업해서 멘티가 아닌 멘토로서 활동해보고 싶네요!</h4>
									<h2 class="padding-right-50 margin-top-10 text-right color-e6"
										style="font-size: 50px !important;">”</h2>
									<h5 class="text-center margin-top-0 margin-bottom-5">
										<b>김진우님</b>
									</h5>
									<h6 class="header-margin-none text-center">창업 준비생</h6>
								</div>
							</div>
						</div>
					</div>

					<div
						class="item panel panel-default border-radius-0 margin-none position-relative">
						<div class="row">
							<div
								class="col-xs-5 padding-right-0 position-relative overflow-hidden">
								<a class="index-buyer-images" href="javascript:void(0);"
									onclick="openVideoModal('third')">
										<img class="width-100" style="width: 100%; height: 360px;"
											src="https://kmong.com/img/main/desktop/buyer_review_3.png"
											alt="전문가 동영상"> <img style="width: 50px; height: 50px;"
											class="width-50px index-seller-play-image"
											src="https://kmong.com/img/main/desktop/index_seller_play.png"
											alt="플레이 버튼">
								</a>
							</div>
							<div class="col-xs-7 padding-left-0">
								<div class="buyer-video-text">
									<h2
										class="padding-left-50 margin-bottom-0 margin-top-10 color-e6"
										style="font-size: 50px !important; text-align: left;">“</h2>
									<h4
										class="text-center text-style margin-none padding-left-60 padding-right-60"
										style="height: 110px; font-size: 17px; font-weight:bold; color: #787878;">
										홈페이지 제작이 필요해서 아워플레너스를 처음 써봤어요.<br> 상세페이지에 경력이랑 포트폴리오가 잘 정리되어
										있어서 좋은 작업자분 만날 수 있었던 것 같아요~ 나름대로 큰 돈 쓴거라 걱정이 많았는데, 아워플레너스 덕분에 안전하게
										거래가 끝났어요!
									</h4>
									<h2 class="padding-right-50 margin-top-10 text-right color-e6"
										style="font-size: 50px !important;">”</h2>
									<h5 class="text-center margin-top-0 margin-bottom-5">
										<b>황영화님</b>
									</h5>
									<h6 class="header-margin-none text-center">쇼핑몰 대표</h6>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<a href="#myCarousel" class="left carousel-control" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="sr-only">Previous</span>
			</a> <a href="#myCarousel" class="right carousel-control"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>
	</div>
	<!-- video section(홍보영상 분분) -->

	<!-- Footer (하단부분) -->
	<%@ include file="./common/commonBottom.jsp"%>
	<!--// Footer (하단부분) -->
	</div>
</body>
</html>
