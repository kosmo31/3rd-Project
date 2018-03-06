<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
<c:when test="${empty sessionScope.loginUserInfo }">
	<!-- 로그인 정보가 없다면 경고메시지를 띄우고 로그인 페이지로 이동한다. -->
	<script>
		alert("로그인 후 작성해주세요.");
		location.href="../member/login";
	</script>
</c:when>
<c:otherwise> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	var editor_object = [];
	var ctx = sessionStorage.getItem("contextpath");
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : editor_object,
		elPlaceHolder : "contents",
		sSkinURI : ctx + "/resources/smarteditor/SmartEditor2Skin.html",
		htParams : {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,
			fOnBeforeUnload : function() {

			}
		}
	});
	
	//목록으로
	$('#listGO').click(function(){
		location.href = "./engineer";
	});
			
	//글쓰기
	$('#writeActionBtn').click(function(){
		
		//폼값 검증
		if($("input[type='text'][name='title']").val()==""){
			alert("제목을 입력해주세요");
			$("input[type='text'][name='title']").focus();
			return;
		}
	
		//id가 smarteditor인 textarea에 에디터에서 대입
		editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 이부분에 에디터 validation 검증
		var el = document.createElement('html');
		el.innerHTML = editor_object.getById["contents"].elPlaceHolder.value;
		
        var ir1 = $("#contents").val();

        if( ir1 == ""  || ir1 == null || ir1 == '&nbsp;' || ir1 == '<p>&nbsp;</p>')  {
             alert("내용을 입력하세요.");
             editor_object.getById["contents"].exec("FOCUS"); //포커싱
             return;
        }
	/* 	if($("textarea[name='contents']").val()==""){
			alert("내용을 입력해주세요");
			$("textarea[name='contents']").focus();
			return;
		} */
		if($("input[type='text'][name='service_time_start']").val()==""){
			alert("서비스 시작 기간을 입력해주세요");
			$("input[type='text'][name='service_time_start']").focus();
			return;
		}
		if($("input[type='text'][name='service_time_end']").val()==""){
			alert("서비스 종료 기간을 입력해주세요");
			$("input[type='text'][name='service_time_end']").focus();
			return;
		}
		if($("input[type='text'][name='service_cost']").val()==""){
			alert("서비스 종료 기간을 입력해주세요");
			$("input[type='text'][name='service_cost']").focus();
			return;
		}
		if($("input[type='text'][name='contact_time']").val()==""){
			alert("연락 가능 시간을 입력해주세요");
			$("input[type='text'][name='contact_time']").focus();
			return;
		}
		
		//폼값 전송
		var params = $('#writeFrm').serialize();
		
		$.ajax({
			url : "./engineer/writeAciton",
			dataType : "json",
			type : "post",
			//contentType : "text/html; charset=utf-8",
			data : params,
			success : function(d) {
				if(d.code == "SUCCESS"){
					alert(d.message);
					location.href = "./engineer";
				}
				else if(d.code == "login"){
					alert(d.message);
					location.href = "../member/login";
				}
				else{
					alert(d.message);
				}
			},
			error : function(e){
				alert("요청실패:"+e.status+" "+e.statusText);
			}
		});
	});
});
</script>

<script type="text/javascript" charset="utf-8">
		sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>


	
		<!-- <form id="writeFrm"> -->
		<form id="writeFrm">
			
			<input type="hidden" name="user_id" value="${sessionScope.loginUserInfo.user_id }" />
			<input type="hidden" name="board_type" value="E" />
		 	<input type="hidden" name="category_srl" value="1" />
			<input type="hidden" name="subcategory_srl" value="1" />
			
			<div class="row" id="row-body-write">
			
				<div class="col-lg-3 col-md-3 col-sm-2 col-xs-1"></div>
				<div class="col-lg-6 col-md-6 col-sm-8 col-xs-10">
					<div class="write-body">
						<div class="title">
							<p class="p-title">제목</p>
							<input type="text" class="form-control" placeholder="제목을 입력하세요" name="title"/>
						</div>
						<div class="contents">
							<p class="p-title">서비스내용</p>
							
							
							<textarea class="form-control" name="contents" id="contents" 
								rows="10" cols="80" placeholder="서비스 내용을 입력하세요"></textarea>	
						</div>
						<div class="need-contents">
							<p class="p-title">필수사항</p>
							<div class="form-inline">
								<p>
									서비스지역 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;
									<input name="location"
										class="form-control" id="input-area" type="text"
										style="display: inline;" placeholder="지역을 입력하세요" />
								</p>
								<p>
									서비스기간 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;
									<input name="service_time_start"
										class="form-control" id="input-time-s" type="text"
										placeholder="이때부터" />&nbsp; ~ &nbsp;
									<input name="service_time_end"
										class="form-control" id="input-time-e" type="text" placeholder="여기까지" />
								</p>
								<p>
									서비스비용 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;
									<input name="service_cost"
										class="form-control" id="input-cost" type="text"
										placeholder="비용을 입력하세요" />
								</p>
								<p>
									연락가능시간 &nbsp;&nbsp;: &nbsp;&nbsp;
									<input name="contact_time_start"
										class="form-control" id="input-call" type="text" 
										placeholder="연락가능시간을 입력하세요" />
										
										~
										
									<input name="contact_time_end"
										class="form-control" id="input-call" type="text" 
										placeholder="연락가능시간을 입력하세요" />
								</p>
							</div>
						</div>
						<div class="images">
							<!-- <p class="p-title">
								<img src="" alt="메인 이미지" id="main_image"/>
							</p>
							
							<p class="p-title">
								<img src="" alt="컨텐츠 이미지" id="contents_image"/>
							</p> -->
						</div>
					</div>
					<div class="write-btn">
						<button type="button" class="btn btn-success" id="listGO">목록보기</button>
						<button type="button" class="btn btn-success" id="writeActionBtn">글쓰기</button>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-2 col-xs-1"></div>
			</div>
		</form>
 	</c:otherwise>
</c:choose>	 