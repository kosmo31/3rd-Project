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
<!-- CSS작업부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile_others.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

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
	getProfile("${profile_user_id}",1);
});

function getProfile(user_id,nowPage){
	nowPage = typeof nowPage !== 'undefined' ? nowPage : 1;

	user_id = typeof user_id !== 'undefined' ? user_id : "kosmo";
	
	var url = "${pageContext.request.contextPath}/member/json/member_list.json";
	var inHTML = "";

	var inHTMLPaging = "";

	$("#faqBody").empty();
	
	var params = "user_id=" + user_id + "&nowPage=" + nowPage;
	
	$.ajax({
		url : url,
		dataType : "json",
		type : "get",
		data : params,
		contentType : "text/html; charset=utf-8",
		success : function(data) {
			$.each(data.faqLists, function(index, faqList) { // each로 모든 데이터 가져와서 items 배열에 넣고

				inHTML += "<div id=\"faqDiv_" + faqList.faq_srl + "\" class=\"mix category-1 col-lg-12 panel panel-default\" data-value=\"" + (index + 1) + "\" style=\"display: inline-block;\">";
				inHTML += "	<div class=\"panel-heading\">";
				inHTML += "		<h4 class=\"panel-title\">";
				inHTML += "			<a class=\"collapsed\" data-toggle=\"collapse\" data-parent=\"#faqBody\" href=\"#question" + (index + 1) + "\"> <strong class=\"c-gray-light\">" + (index + 1) + "</strong> " + faqList.title;
				inHTML += "			</a>";
				inHTML += "		</h4>";

				inHTML += "	</div>";
				inHTML += "	<div id=\"question" + (index + 1) + "\" class=\"panel-collapse collapse\" style=\"height: 0px;\">";
				inHTML += "		<div class=\"panel-body\">";
				inHTML += "			<p>" + faqList.contents + "</p>";
				inHTML += "		</div>";
				inHTML += "	</div>";

				<c:choose>
				<c:when	test="${not empty loginUserInfo && loginUserInfo.is_admin=='Y'}">
				inHTML += "<div>";
				inHTML += "<button type=\"button\" class=\"btn btn-warning\" onclick=\"javascript:modifyFAQ('" + faqList.faq_srl + "');\" >수정</button>";
				inHTML += "<button type=\"button\" class=\"btn btn-danger\" onclick=\"javascript:deleteFAQ('" + faqList.faq_srl + "');\" >삭제</button>";
				inHTML += "</div>";
				</c:when>
				</c:choose>

				inHTML += "</div>";

			});//each끝
			inHTML += "<div class=\"row text-center\">";
			inHTML += "<ul class=\"pagination\" id=\"faqPagingDiv\">";
			inHTML += "</ul> </div>";
			inHTML += "		</div>";
			inHTML += "		</div>";
			$("#faqBody").html(inHTML);
			$("#faqPagingDiv").html(data.pagingDiv);
		},
		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}
	});
}
</script>
</head>
<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

	<!-- Top영역 1첫번째 -->
	<div class="row">
		<%@ include file="../common/commonTop_1.jsp"%>
	</div>
	
	<!-- 프로필 바디부분 -->
	<div class="container-fluid header-top">
		<div class="image-title">
			<img src="${pageContext.request.contextPath}/resources/images/main_user_gray.png">
		</div>
		<div class="text-title">
			<h4>${profileInfo.user_id}</h4>
			<p>한줄소개를 작성하여 자신의 프로필을 더욱 어필해보세요!</p>
		</div>
		<div class="nav-title">
			<div class="nav-sotitle">
				<p>만족도:78%</p>
			</div>
			<div class="nav-sotitle">
				<p>총 작업수:10 개</p>
			</div>
			<div class="nav-btn">
				<div class="btn-red"></div>
				<button type="button"><i class="fa fa-envelope"></i>&nbsp;문의하기</button>
			</div>
			<div class="nav-sotitle">
				<p>평균 응답시간:1시간이내</p>
			</div>
			<div class="nav-sotitle">
				<p>최종 작업물 발송:3 주일 전</p>
			</div>
		</div>
	</div>
	<div class="container-fluid body-center">
		<div class="row">
			<div class="col-xs-3"></div>
			<div class="col-xs-6 work-board">
				<div class="row">
					<div class="col-xs-9 board-view">
						<h3>${profileInfo.user_id}님의 서비스</h3>
						<c:choose>
							<c:when test="">
							<div class="service-regist">
								<div class="service-image">
									<img src="${pageContext.request.contextPath}/resources/images/user_gig.png">
								</div>
								<div class="service-text">
									<p>서비스를 등록하여</p>
									<p>수익을 얻어보세요!</p>
								</div>
								<button type="button" class="btn btn-danger service-btn">서비스 등록하기</button>
							</div>
							</c:when>
							<c:otherwise>
							<div class="service-regist">
								<div class="service-image">
									<img src="${pageContext.request.contextPath}/resources/images/user_gig.png">
								</div>
								<div class="service-text">
									<p>서비스를 등록하여</p>
									<p>수익을 얻어보세요!</p>
								</div>
								<button type="button" onclick="" class="btn btn-danger service-btn">서비스 등록하기</button>
							</div>
							</c:otherwise>
						</c:choose>
						
						<span class="margin-span"><span id="spanUserId">${profileInfo.user_id}</span>님의 받은 평가
						<img src="${pageContext.request.contextPath}/resources/images/star.png">
						<img src="${pageContext.request.contextPath}/resources/images/star.png">
						<img src="${pageContext.request.contextPath}/resources/images/star.png">
						<img src="${pageContext.request.contextPath}/resources/images/star.png">
						<img src="${pageContext.request.contextPath}/resources/images/star.png">
						</span>
						<br/>
						<br/>
						<!-- 댓글로 -->
						<c:choose>
							<c:when test="">
								<div class="service-response">
									<img src="${pageContext.request.contextPath}/resources/images/nothing.png">
									<p>받은 평가가 없습니다.</p>
								</div>
							</c:when>
							<c:otherwise>
								<%-- <c:forEach var="" items=""> --%>
								<div class="service-response-white row">
									<div class="col-xs-2 comment-image">
										<img src="${pageContext.request.contextPath}/resources/images/main_user_gray.png">
									</div>
									<div class="col-xs-10 comment-text ">
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									<br/>		
									kosmo1234 ㅣ 18.03.18
									</div>
								</div>
								<%-- </c:forEach> --%>
								<div class="service-response-white row">
									<div class="col-xs-2 comment-image">
										<img src="${pageContext.request.contextPath}/resources/images/main_user_gray.png">
									</div>
									<div class="col-xs-10 comment-text ">
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									<br/>		
									kosmo1234 ㅣ 18.03.18
									</div>
								</div>
								<div class="service-response-white row">
									<div class="col-xs-2 comment-image">
										<img src="${pageContext.request.contextPath}/resources/images/main_user_gray.png">
									</div>
									<div class="col-xs-10 comment-text ">
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									정말 마음에 듭니다. 다음에 영상제작할때 여기서 하겠습니다. 감사합니다.!!
									<br/>		
									kosmo1234 ㅣ 18.03.18
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						<button type="button" class="btn btn-default page-ten">10개 더보기</button>
					</div>
					<div class="col-xs-3">
						<!-- 자기소개, 자격증 추가하는 부분 -->
						<div class="border-left padding-left-10 padding-bottom-30 position-relative">
							<div class="inline-block side-info-circle">
								<div class="user-side-circle"></div>
							</div>
							<h5 class="margin-top-0 margin-bottom-5">
								<span class="NGB"> 기술 / 자격 <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="right" title="선택된 태그는 서비스 상세페이지에 노출됩니다."></i>
								</span>
							</h5>
							<div id="userMetadataWrapper" class="panel panel-default margin-top-5 margin-bottom-10">
								<div class="panel-body padding-all-10" v-show="isEditUserMetadata == false">
									<div class="row">
										<div class="col-xs-12" v-show="selected_metadata.length > 0" style="display: none;">
											<span v-for="selected_metadata in selected_metadata" class="position-relative">
												<button v-if="!(selected_metadata.user_metadata.need_certification == 1 && selected_metadata.status == 'APPROVED')" type="button" class="btn btn-gray-reverse font-color-light btn-xs btn-tag position-relative" data-toggle="tooltip" data-placement="top" title="{{tag.description.seller}}">{{ selected_metadata.user_metadata.title }}</button>
												<button v-if="selected_metadata.user_metadata.need_certification == 1 && selected_metadata.status == 'APPROVED'" type="button" class="btn btn-certification-reverse btn-xs btn-tag position-relative" data-toggle="tooltip" data-placement="top" title="전문가가 관련 서류를 제출하였습니다.">
													<img class="width-10px" src="/img/user/desktop/tag_on.png" /> {{ selected_metadata.user_metadata.title }}
												</button>
											</span>
										</div>
										<div id="selectedUserMetadataNone" class="col-xs-12" style="display: none;">등록된 태그가 없습니다.</div>
										<div id="selectedUserMetadataLoading" class="col-xs-12 text-center">
											<div class="la-ball-fall color-black">
												<div></div>
												<div></div>
												<div></div>
											</div>
										</div>
									</div>
								</div>

								<div class="panel-body padding-all-10" v-show="isEditUserMetadata == true" style="display: none">
									<div id="userMetadataCategorySelectWrapper" class="row">
										<div class="col-xs-12">
											<select class="form-control input-xs" v-model="selected_category_for_user_metadata">
												<option v-for="metadata in user_metadata" value="{{ metadata.category_id }}" v-html="metadata.name"></option>
											</select>
										</div>
									</div>

									<div id="userMetadataSelectWrapper" class="row margin-top-10">
										<div class="col-xs-12">
											<div class="border-radius bg-color-fa padding-all-10">
												<span v-for="tag in user_metadata_tag_list">
													<button v-if="tag.selected_user_metadata == null" type="button" class="btn btn-gray-reverse font-color-light btn-xs btn-tag" data-toggle="tooltip" data-placement="top" title="{{tag.description.seller}}" v-on:click="selectUserMetadata($event, tag.id, 'enable')">
														<img v-if="tag.need_certification == 1" class="width-10px" src="/img/user/desktop/tag.png" /> {{ tag.title }}
													</button>
													<button v-if="tag.selected_user_metadata != null" type="button" class="btn btn-gray-reverse font-color-light btn-xs btn-tag btn-tag-select" data-toggle="tooltip" data-placement="top" title="{{tag.description.seller}}" v-on:click="selectUserMetadata($event, tag.id, 'disable')">
														<img v-if="tag.selected_user_metadata.user_metadata.need_certification == 1 && tag.selected_user_metadata.status == 'WAITING'" class="width-10px" src="/img/user/desktop/tag.png" /> <img v-if="tag.selected_user_metadata.user_metadata.need_certification == 1 && tag.selected_user_metadata.status == 'APPROVED'" class="width-10px" src="/img/user/desktop/tag_on.png" /> {{ tag.selected_user_metadata.user_metadata.title }}
													</button>
												</span>
											</div>
										</div>
									</div>

									<div id="selectedUserMetadataListWrapper" class="row margin-top-10">
										<div class="col-xs-12">
											<span v-for="selected_metadata in selected_metadata" class="position-relative">
												<button type="button" class="btn btn-gray-reverse font-color-light btn-xs btn-tag btn-tag-select  position-relative" data-toggle="tooltip" data-placement="top" title="{{tag.description.seller}}">
													<img v-if="selected_metadata.user_metadata.need_certification == 1 && selected_metadata.status == 'WAITING'" class="width-10px" src="/img/user/desktop/tag.png" /> <img v-if="selected_metadata.user_metadata.need_certification == 1 && selected_metadata.status == 'APPROVED'" class="width-10px" src="/img/user/desktop/tag_on.png" /> {{ selected_metadata.user_metadata.title }} <i class="fa fa-times-circle tag-close cursor" aria-hidden="true" v-on:click="selectUserMetadata($event, selected_metadata.user_metadata.id, 'disable')"></i>
												</button>
											</span>
										</div>
									</div>

									<div id="userMetadataCertificationBtn" class="row margin-top-10" v-show="need_certification_selected_metadata.length > 0">
										<div class="col-xs-12">
											<button type="button" class="btn btn-gray-reverse font-color-light btn-sm btn-block" data-toggle="modal" data-target="#tagCertificationModal">
												<img class="user-metadata-certification-btn-img" src="/img/user/desktop/tag.png" /> 태그 인증받기
											</button>
										</div>
									</div>
								</div>
							</div>

							<div>
								<div id="certificatedReady" style="display: none" class="font-size-h6 color-red margin-left-5">
									<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> &nbsp; 인증 심사중입니다.
								</div>
								<div id="limitUserMetadataCntError" class="font-size-h6 color-red margin-left-5" style="display: none">
									<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> &nbsp; 기술 / 자격은 {{ limitUserMetadataCnt }}개이상 등록 할 수 없습니다.
								</div>
							</div>



							<div v-show="isEditUserMetadata == true" style="display: none;">
								<h5 class="margin-top-20">
									<span class="NGB">기술 / 자격 추천</span> <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="right" title="이 외 기술 / 자격을 추천해주세요."></i>
								</h5>
								<div class="form-group margin-bottom-0 position-relative">
									<input type="text" class="form-control input-xs" v-model="user_metadata_etc" /> <a class="btn btn-primary font-size-h6 tag-btn" :disabled="user_metadata_etc.length == 0" v-on:click="submitUserMetadataEtcToOp">보내기</a>
								</div>
							</div>
						</div>



						<div class="border-left padding-left-10 padding-bottom-30 position-relative">
							<div class="inline-block side-info-circle">
								<div class="user-side-circle"></div>
							</div>

							<h5 class="margin-top-0 margin-bottom-10">
								<span class="NGB">소개</span> <span id="descriptionEditBtnGroup"> <span class="pull-right font-size-h6" v-show="description == null"><a class="user-edit-text" href="javascript:void(0);" v-on:click="openCreateInput('description')"></a></span> <span class="pull-right font-size-h6" v-show="description != null"><a class="user-edit-text" href="javascript:void(0);" v-on:click="openUpdateInput('description')">편집</a></span>
								</span>
							</h5>


							<div id="descriptionView" class="panel panel-default margin-top-5 margin-bottom-10">
								<div class="panel-body padding-top-10 padding-bottom-10 padding-left-10 padding-right-10 word-break">
									<span v-if="description == null || description.data.description == ''">소개가 없습니다.</span> <span class="word-break" v-if="description != null && description.data.description != ''" v-html="description.data.description | nl2br"></span>
								</div>
							</div>

							<div id="descriptionInput" class="panel panel-default margin-top-5 margin-bottom-10" style="display: none;">
								<div class="panel-body padding-top-10 padding-bottom-10 padding-left-10 padding-right-10">
									<textarea class="form-control padding-all-5 introduce-text" rows="5" placeholder="자기소개를 입력하세요." v-model="descriptionInformation" maxlength="255"></textarea>
									<div class="text-right margin-top-10">
										<a class="btn btn-default btn-xs" href="javascript:void(0);" v-on:click="hideCreateInput('description')">취소</a> <a class="btn btn-primary btn-xs margin-left-5" href="javascript:void(0);" v-on:click="createUserInformation('description')" :disabled="descriptionInformation.length == 0">저장</a>
									</div>
								</div>
							</div>
						</div>


						
						
						</div>
						
						<!-- 자기소개, 자격증 추가하는 부분 -->
					</div>
				</div>
			</div>
			<div class="col-xs-3"></div>
		</div>		

	
	
	
	
<script>
    function hideFileUpload(id){
        for(var i in user_vue.need_certification_selected_metadata) {
            if(typeof user_vue.need_certification_selected_metadata[i] == 'object') {
                if(user_vue.need_certification_selected_metadata[i].id == id) {
                    user_vue.needToRemoveCertificationFiles.push({
                        id : id,
                        file_id : {
                            FID : user_vue.need_certification_selected_metadata[i].file_id.FID,
                            ori_fname : user_vue.need_certification_selected_metadata[i].file_id.ori_fname
                        }
                    });
                    user_vue.need_certification_selected_metadata[i].file_id = null;
                    break;
                }
            }
            if( i == (user_vue.need_certification_selected_metadata.length)-1) break;
        }
    }
</script>
				
<link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.18/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/op.certification_metadata.file.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-datepicker3.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap-datepicker.js"></script>
<script>
    $('.date-input').datepicker({
        format: 'yyyy.mm',
        maxViewMode: 2,
        minViewMode: 'months',
        orientation: "bottom auto",
        endDate: '0m',
        language: "kr",
        autoclose: true,
        todayHighlight: true
    });
</script>
<script src="${pageContext.request.contextPath}/resources/js/op.common.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/op.user_profile.js"></script>

<script>
    $(document).ready(function(){

                    var $scrollFix = $("#userScrollFix"),
                $navigationFixed = $('.user-nav-fixed')
                ;
            const defaultHeight = 285 - 30;

            $(window).on('scroll',function(){
                var userScrollTop = $(this).scrollTop();
                if( userScrollTop > defaultHeight ){
                    $scrollFix.removeClass('user-info-nave').addClass('user-nav-fixed').css('top', sassVariables.globalMarginTopOnlyYellowHeader+'px');
                } else {
                    $scrollFix.removeClass('user-nav-fixed').addClass('user-info-nave').css('top',0);
                }
            });

        
        user_vue.profileUSERID = '346478';

  


                user_vue.default_date = '2017.03';
        user_vue.licensed_at = user_vue.default_date;
        user_vue.period_start = user_vue.default_date;
        user_vue.type = 'seller';

            });

    function getViewport() {

        var viewPortWidth;
        var viewPortHeight;

        // the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
        if (typeof window.innerWidth != 'undefined') {
            viewPortWidth = window.innerWidth,
            viewPortHeight = window.innerHeight
        }

        // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
        else if (typeof document.documentElement != 'undefined'
            && typeof document.documentElement.clientWidth !=
            'undefined' && document.documentElement.clientWidth != 0) {
            viewPortWidth = document.documentElement.clientWidth,
                viewPortHeight = document.documentElement.clientHeight
        }

        // older versions of IE
        else {
            viewPortWidth = document.getElementsByTagName('body')[0].clientWidth,
                viewPortHeight = document.getElementsByTagName('body')[0].clientHeight
        }
        return [viewPortWidth, viewPortHeight];
    }
	</script>
	
	<!-- 모달창 -->
	<%@ include file="../common/modal_msg.jsp"%>
	<!-- //모달창 끝 -->

	<!-- Footer section(하단부분) -->
	<%@ include file="../common/commonBottom.jsp"%>
	<!-- Footer section(하단부분) -->
	</div>
</body>
</html>

