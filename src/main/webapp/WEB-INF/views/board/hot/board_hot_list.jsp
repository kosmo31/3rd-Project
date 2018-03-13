<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<script>
	$(document).ready(function() {

		var serviceMainImgPath = "${pageContext.request.contextPath}/resources/upload/service/";

		var url = "${pageContext.request.contextPath}/board/json/hot_service_list.json";

		//내용 지우기
		$("#hot_engineer_div").empty();
		$("#hot_client_div").empty();
		var params = "board_type=E&pageSize=5&blockPage=1";

		$.ajax({
			cache : false, // 캐시 사용 없애기
			type : 'post',
			url : url,
			data : params,
			//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
			//contentType: 'application/json; charset=utf-8',
			dataType : 'json',
			//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
			success : function(data) {
				//alert(JSON.stringify(data));
				var items = [];
				var inHTML = "";
				$.each(data.list, function(index, hotEngineerBoardList) { // each로 모든 데이터 가져와서 items 배열에 넣고

					//if(index==5)
					//return false; //break; true=>continue

					//배열에 푸쉬후 뿌려줄 영역에 html메소드로 넣기
					//alert(hotEngineerBoardList.contents);
					if (index == 0) {
						inHTML += "<div class=\"item active\">";
					} else {
						inHTML += "<div class=\"item\">";
					}
					inHTML += "<div class=\"col-md-4\">";
					inHTML += "<div class=\"card card-blog\">";
					inHTML += "<div class=\"card-image\">";
					if(hotEngineerBoardList.main_image==null){
						inHTML += "<a href=\"#pablo\"> <img style=\"height:270px;\" class=\"img img-raised\" src=\"${pageContext.request.contextPath}/resources/images/op_main_img.png\">";
					}else{
						inHTML += "<a href=\"#pablo\"> <img style=\"height:270px;\" class=\"img img-raised\" src=\""+serviceMainImgPath+hotEngineerBoardList.main_image+"\">";
					}
					
					
					
					inHTML += "</a>";
					inHTML += "<div class=\"colored-shadow\" style=\"background-image: url('" + serviceMainImgPath + hotEngineerBoardList.board_srl + "/images/" + hotEngineerBoardList.main_image + "'); opacity: 1;\"></div>";
					inHTML += "<div class=\"ripple-container\"></div>";
					inHTML += "</div>";
					inHTML += "<div class=\"card-content\">";
					inHTML += "<h6 class=\"category text-info\">" + hotEngineerBoardList.subcategory_srl + "</h6>";
					inHTML += "<h4 class=\"card-title\">";
					inHTML += "<a href=\"./board/service/"+hotEngineerBoardList.board_srl+"\">" + hotEngineerBoardList.title + "</a>";
					inHTML += "</h4>";
					inHTML += "<p class=\"card-description text-left\">";
					
					inHTML +="서비스 지역 : " +hotEngineerBoardList.location+"<br/>";
					inHTML +="서비스 비용 : " +hotEngineerBoardList.service_cost+"<br/>";
					inHTML +="서비스 기간 : " +hotEngineerBoardList.service_time_start + " ~ " + hotEngineerBoardList.service_time_end+"<br/>";
					inHTML +="<a href=\"./board/service/"+hotEngineerBoardList.board_srl+"\"> 자세히 보기 </a>";
					
					//inHTML += replaceContents(hotEngineerBoardList.contents) + "<a href=\"./board/engineer/"+hotEngineerBoardList.board_srl+"\"> 자세히 보기 </a>";
					
					inHTML += "</p>";
					inHTML += "</div>";
					inHTML += "</div>";
					inHTML += "</div>";
					inHTML += "</div>";

					//inHTML+="<span><a href='./board/engineer/"+hotEngineerBoardList.board_srl+"?category="+hotKeyWord.category_srl+"&subcategory="+hotKeyWord.subcategory_srl+"'>"+hotKeyWord.searchword+"</a></span>");						

				});//each끝
				$('#hot_engineer_div').html(inHTML);

				//alert(inHTML);
				//$('#hot_engineer_div').html(items);

			},

			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}

		});

		params = "board_type=C&pageSize=5&blockPage=1";

		$.ajax({
			cache : false, // 캐시 사용 없애기
			type : 'post',
			url : url,
			data : params,
			//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
			//contentType: 'application/json; charset=utf-8',
			dataType : 'json',
			//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
			success : function(data) {
				//alert(JSON.stringify(data));
				var items = [];
				var inHTML = "";
				$.each(data.list, function(index, hotEngineerBoardList) { // each로 모든 데이터 가져와서 items 배열에 넣고

					//if(index==5)
					//return false; //break; true=>continue

					//배열에 푸쉬후 뿌려줄 영역에 html메소드로 넣기

					if (index == 0) {
						inHTML += "<div class=\"item active\">";
					} else {
						inHTML += "<div class=\"item\">";
					}
					inHTML += "<div class=\"col-md-4\">";
					inHTML += "<div class=\"card card-blog\">";
					inHTML += "<div class=\"card-image\">";
					inHTML += "<a href=\"#pablo\"> <img class=\"img img-raised\" src=\""+serviceMainImgPath+hotEngineerBoardList.main_image+"\">";
					inHTML += "</a>";
					inHTML += "<div class=\"colored-shadow\" style=\"background-image: url('" + serviceMainImgPath + hotEngineerBoardList.board_srl + "/images/" + hotEngineerBoardList.main_image + "'); opacity: 1;\"></div>";
					inHTML += "<div class=\"ripple-container\"></div>";
					inHTML += "</div>";
					inHTML += "<div class=\"card-content\">";
					inHTML += "<h6 class=\"category text-info\">" + hotEngineerBoardList.subcategory_srl + "</h6>";
					inHTML += "<h4 class=\"card-title\">";
					inHTML += "<a href=\"./board/service/"+hotEngineerBoardList.board_srl+"\">" + hotEngineerBoardList.title + "</a>";
					inHTML += "</h4>";
					inHTML += "<p class=\"card-description text-left\">";
					
					//inHTML += replaceContents(hotEngineerBoardList.contents) + "<a href=\"./board/client/"+hotEngineerBoardList.board_srl+"\"> 자세히 보기 </a>";
					
					inHTML +="서비스 지역 : " +hotEngineerBoardList.location+"<br/>";
					inHTML +="서비스 비용 : " +hotEngineerBoardList.service_cost+"<br/>";
					inHTML +="서비스 기간 : " +hotEngineerBoardList.service_time_start + " ~ " + hotEngineerBoardList.service_time_end+"<br/>";
					inHTML +="<a href=\"./board/service/"+hotEngineerBoardList.board_srl+"\"> 자세히 보기 </a>";
					
					
					inHTML += "</p>";
					inHTML += "</div>";
					inHTML += "</div>";
					inHTML += "</div>";
					inHTML += "</div>";

					//inHTML+="<span><a href='./board/engineer/"+hotEngineerBoardList.board_srl+"?category="+hotKeyWord.category_srl+"&subcategory="+hotKeyWord.subcategory_srl+"'>"+hotKeyWord.searchword+"</a></span>");						

				});//each끝
				$('#hot_client_div').html(inHTML);

				//alert(inHTML);
				//$('#hot_engineer_div').html(items);

			},

			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}

		});

	});

	function replaceContents(contents) {
		//이미지 제거
		var img_tag = /<IMG(.*?)>/gi;
		contents = contents.replace(img_tag, "");
		//html태그 제거 br,span 허용
		//contents= removeTags(contents, ["span", "br"]);
		//alert("제거내용 : "+contents);
		return contents;
	}

/* 
	var x = "<span><i>Hello</i> <b>world</b>!</span>";
	console.log(removeTags(x)); // Hello world!
	console.log(removeTags(x, ["span", "i"])); // <span><i>Hello</i> world!</span>
 */
 
	function removeTags(string, array){
		  return array ? string.split("<").filter(function(val){ return f(array, val); }).map(function(val){ return f(array, val); }).join("") : string.split("<").map(function(d){ return d.split(">").pop(); }).join("");
		  function f(array, value){
		    return array.map(function(d){ return value.includes(d + ">"); }).indexOf(true) != -1 ? "<" + value : value.split(">")[1];
		  }
		}


		
		
	$(window).load(function() {
		//slide(슬라이드부분)
		// Instantiate the Bootstrap carousel
		$('.multi-item-carousel').carousel({
			interval : false
		});
		// for every slide in carousel, copy the next slide's item in the slide.
		// Do the same for the next, next item.
		$('.multi-item-carousel .item').each(function() {
			var next = $(this).next();
			if (!next.length) {
				next = $(this).siblings(':first');
			}
			next.children(':first-child').clone().appendTo($(this));

			if (next.next().length > 0) {
				next.next().children(':first-child').clone().appendTo($(this));
			} else {
				$(this).siblings(':first').children(':first-child').clone().appendTo($(this));
			}
		});
	});
</script>


<!-- engineer section(기술자 게시글부분) -->
<section id="hot_engineer_board">
	<div class="container">
		<div class="hot-title1">
			<h3>
				<b>기술자 HOT 게시글</b>
			</h3>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="carousel slide multi-item-carousel" id="hot_engineer_board_list">
					<div class="carousel-inner" id="hot_engineer_div"></div>
					<a class="left carousel-control" href="#hot_engineer_board_list" data-slide="prev"><i class="glyphicon glyphicon-chevron-left"></i></a> <a class="right carousel-control" href="#hot_engineer_board_list" data-slide="next"><i class="glyphicon glyphicon-chevron-right"></i></a>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- engineer section(기술자 게시글부분) -->
<!-- buyer section(요청자 게시글부분) -->
<section id="hot_client_board">
	<div class="container">
		<div class="hot-title2">
			<h3>
				<b>요청자 HOT 게시글</b>
			</h3>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="carousel slide multi-item-carousel" id="hot_client_board_list">
					<div class="carousel-inner" id="hot_client_div"></div>
					<a class="left carousel-control" href="#hot_client_board_list" data-slide="prev"><i class="glyphicon glyphicon-chevron-left" style="margin-right: 200px;"></i></a> <a class="right carousel-control" href="#hot_client_board_list" data-slide="next"><i class="glyphicon glyphicon-chevron-right"></i></a>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- buyer section(요청자 게시글부분) -->