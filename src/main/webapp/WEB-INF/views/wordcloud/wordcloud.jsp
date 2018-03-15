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
<script type="text/javascript">
window.jQuery = window.$ = jQuery;

$(document).ready(function() {

	$('#mainKeyword').keyup(function(){
        limitCharacters('mainKeyword', 20, 'searchLimit');
	})
	
	var url="${pageContext.request.contextPath}/board/json/top_search_list.json";
		
		//내용 지우기
		$("#tagsList").empty();
		
		//var params="";
		//alert(url);
		
		$.ajax({
			cache : false, // 캐시 사용 없애기
			type: 'post',
			url: url,
			//param : params,
			//contentType: 'application/json; charset=utf-8',
		    dataType:'json',      
		    //contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
		    success:function(resdata){     //success에 성공했을 때 동작 넣기.
		    	
				//data= JSON.parse(resdata)
				
				var data;
				
		    	
				try	{
					data=JSON.parse(JSON.stringify(resdata));
					//var data = JSON.parse( jsonData );								/* JSON 형식의 text 를 객체로 컨버팅 */
				}
				catch (e){
					
					popLayerMsg(resdata+" : JSON 객체 파서 에러");
					popLayerMsg(" 페이지 JSON 객체 파서 에러 errURL : " + document.location + " , sendURL : " + url);
					
					return;
				}
				 
				
		      //alert(responseData.bbsList[0]);
		    	 //var data = JSON.parse(responseData);
		    	
		    	  //$("#bbs_content1").html("");


					//var key = Object.keys(data["bbsList"][0]); // 키 값 가져오기 num, title, content, id, postdate,visitcount, name, commentCnt
					
					var items = [];
					
					$.each(resdata.list, function(index, hotKeyWord) { // each로 모든 데이터 가져와서 items 배열에 넣고
						
						if(index==20)
						return false; //break; true=>continue
						
						//배열에 푸쉬후 뿌려줄 영역에 html메소드로 넣기
						//items.push("<a class='title' href='bbs/bbs_detail.jsp?num=" + hotKeyWord.num + "&nowPage=1'>"+hotKeyWord.title+"</a>");
						items.push("<span><a href='./board/service?category_srl="+hotKeyWord.category_srl+"&subcategory_srl="+hotKeyWord.subcategory_srl+"'>"+hotKeyWord.searchword+"</a></span>");						
					});//each끝
					
					$('#tagsList').html(items.join(''));
		      },
		      error: function (e) {
		    	  popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);

		      }
		     });
		/* 	
	 	var inHTML = "<span><a href='./board/service?category=2&subcategory=3'>운전연습</a></span>";
		inHTML += "<span><a href='./board/service?category=4&subcategory=1'>중국어</a></span>";
		inHTML += "<span><a href='./board/service?category=4&subcategory=1'>영어</a></span>";
	 */
		//$('#tagsList').html(inHTML);
		
	 
	//$(window).load(function(){
		var radius = 120;
		var dtr = Math.PI/180;
		var d=300;
		var mcList = [];
		var active = true;
		var lasta = 1;
		var lastb = 1;
		var distr = true;
		var tspeed=2.5;
		var size=250;

		var mouseX=0;
		var mouseY=0;

		var howElliptical=1;

		var aA=null;
		var oDiv=null;

		window.onload=function ()
		{
			var i=0;
			var oTag=null;
			
			oDiv=document.getElementById('tagsList');
			
			aA=oDiv.getElementsByTagName('a');
			
			for(i=0;i<aA.length;i++)
			{
				oTag={};
				
				oTag.offsetWidth=aA[i].offsetWidth;
				oTag.offsetHeight=aA[i].offsetHeight;
				
				mcList.push(oTag);
			}
			
			sineCosine( 0,0,0 );
			
			positionAll();
			
			oDiv.onmouseover=function ()
			{
				active=false;
			};
			
			oDiv.onmouseout=function ()
			{
				active=true;
			};
			
			oDiv.onmousemove=function (ev)
			{
				var oEvent=window.event || ev;
				
				mouseX=oEvent.clientX-(oDiv.offsetLeft+oDiv.offsetWidth/2);
				mouseY=oEvent.clientY-(oDiv.offsetTop+oDiv.offsetHeight/2);
				
				mouseX/=5;
				mouseY/=5;
			};
			
			setInterval(update, 30);
		};

		function update()
		{
			var a;
			var b;
			
			if(active)
			{
				a = (-Math.min( Math.max( -mouseY, -size ), size ) / radius ) * tspeed;
				b = (Math.min( Math.max( -mouseX, -size ), size ) / radius ) * tspeed;
			}
			else
			{
				a = lasta * 0.98;
				b = lastb * 0.98;
			}
			
			lasta=a;
			lastb=b;
			
			if(Math.abs(a)<=0.01 && Math.abs(b)<=0.01)
			{
				return;
			}
			
			var c=0;
			sineCosine(a,b,c);
			for(var j=0;j<mcList.length;j++)
			{
				var rx1=mcList[j].cx;
				var ry1=mcList[j].cy*ca+mcList[j].cz*(-sa);
				var rz1=mcList[j].cy*sa+mcList[j].cz*ca;
				
				var rx2=rx1*cb+rz1*sb;
				var ry2=ry1;
				var rz2=rx1*(-sb)+rz1*cb;
				
				var rx3=rx2*cc+ry2*(-sc);
				var ry3=rx2*sc+ry2*cc;
				var rz3=rz2;
				
				mcList[j].cx=rx3;
				mcList[j].cy=ry3;
				mcList[j].cz=rz3;
				
				per=d/(d+rz3);
				
				mcList[j].x=(howElliptical*rx3*per)-(howElliptical*2);
				mcList[j].y=ry3*per;
				mcList[j].scale=per;
				mcList[j].alpha=per;
				
				mcList[j].alpha=(mcList[j].alpha-0.6)*(10/6);
			}
			
			doPosition();
			depthSort();
		}

		function depthSort()
		{
			var i=0;
			var aTmp=[];
			
			for(i=0;i<aA.length;i++)
			{
				aTmp.push(aA[i]);
			}
			
			aTmp.sort
			(
				function (vItem1, vItem2)
				{
					if(vItem1.cz>vItem2.cz)
					{
						return -1;
					}
					else if(vItem1.cz<vItem2.cz)
					{
						return 1;
					}
					else
					{
						return 0;
					}
				}
			);
			
			for(i=0;i<aTmp.length;i++)
			{
				aTmp[i].style.zIndex=i;
			}
		}

		function positionAll()
		{
			var phi=0;
			var theta=0;
			var max=mcList.length;
			var i=0;
			
			var aTmp=[];
			var oFragment=document.createDocumentFragment();
			
			//랜덤 정렬
			for(i=0;i<aA.length;i++)
			{
				aTmp.push(aA[i]);
			}
			
			aTmp.sort
			(
				function ()
				{
					return Math.random()<0.5?1:-1;
				}
			);
			
			for(i=0;i<aTmp.length;i++)
			{
				oFragment.appendChild(aTmp[i]);
			}
			
			oDiv.appendChild(oFragment);
			
			for( var i=1; i<max+1; i++){
				if( distr )
				{
					phi = Math.acos(-1+(2*i-1)/max);
					theta = Math.sqrt(max*Math.PI)*phi;
				}
				else
				{
					phi = Math.random()*(Math.PI);
					theta = Math.random()*(2*Math.PI);
				}
				//좌표 변환
				mcList[i-1].cx = radius * Math.cos(theta)*Math.sin(phi);
				mcList[i-1].cy = radius * Math.sin(theta)*Math.sin(phi);
				mcList[i-1].cz = radius * Math.cos(phi);
				
				aA[i-1].style.left=mcList[i-1].cx+(oDiv.offsetWidth)/2-(mcList[i-1].offsetWidth)/2+'px';
				aA[i-1].style.top=mcList[i-1].cy+(oDiv.offsetHeight)/2-(mcList[i-1].offsetHeight)/2+'px';
			}
		}

		function doPosition()
		{
			var l=oDiv.offsetWidth/2;
			var t=oDiv.offsetHeight/2;
			for(var i=0;i<mcList.length;i++)
			{
				aA[i].style.left=mcList[i].cx+l-mcList[i].offsetWidth/2+'px';
				aA[i].style.top=mcList[i].cy+t-mcList[i].offsetHeight/2+'px';
				
				aA[i].style.fontSize=Math.ceil(12*mcList[i].scale/2)+8+'px';
				
				aA[i].style.filter="alpha(opacity="+100*mcList[i].alpha+")";
				aA[i].style.opacity=mcList[i].alpha;
			}
		}

		function sineCosine( a, b, c)
		{
			sa = Math.sin(a * dtr);
			ca = Math.cos(a * dtr);
			sb = Math.sin(b * dtr);
			cb = Math.cos(b * dtr);
			sc = Math.sin(c * dtr);
			cc = Math.cos(c * dtr);
		}
	 
	 
	 
	});		
		
$(document).ready(function(){
	$('.mainSearchBtn').on('click', function() {
		
		if (checkValidKeyword(this.form)) {
			
			this.form.submit();
		}		
	});
});

	
function checkInvalidKeyword(f)
{
	if (!f.mainKeyword.value) {
		popLayerMsg("검색어를 입력하세요.");
		return false;
	}
	return true;
	//todo 19금, 경쟁사 상호명 등 검색 단어제외 체크 기능 추가..
}
	
	
	
		
		
		
 


function limitCharacters(textid, limit, spanid)
{
        // 잆력 값 저장
        var text = $('#'+textid).val();
        // 입력값 길이 저장
        var textlength = text.length;
        if(textlength > limit)
        {
                $('#' + spanid).html(limit+'자 이상 검색할 수 없습니다!');
                // 제한 글자 길이만큼 값 재 저장
                $('#'+textid).val(text.substr(0,limit));
                return false;
        }
        else
        {
        	$('#' + spanid).empty();
                //$('#' + spanid).html('검색어로 쓸 수 있는 글자가 '+ (limit - textlength) + ' 자 남음');
                return true;
        }
}

</script>
<style>
.title-ment>h3{
	font-size: 30px;
	margin-bottom: 15px;
	color: #4D4D4D;
}
.title-ment>h4{
	font-size: 17px;
	color: #4F4E4C;
}

#board_type{
	height: 40px;
	width: 90px;
}

#mainKeyword{
	height: 40px;
	width: 220px;
	margin-right: 0px;
}

#mainSearchBtn{
	height: 42px;
	width: 80px;
	background-color: #333333;
	margin-top: 4px;
	margin-left: -10px;
	border-radius: 5px;
}




</style>
<%-- <section class="section-full-height large-padding custom-bg parallax" data-bg="${pageContext.request.contextPath}/resources/images/main/s-203.jpg"> --%>
<section class="section-full-height large-padding custom-bg parallax" style="background-color: #27CEA7; height: 440px;">
	<div class="bg-layer op6" style="padding-left: 900px;">
		<img src="${pageContext.request.contextPath}/resources/images/main/main-top-image.png" alt="" />
	</div>
	<div class="container align-middle">
		<div class="row">
			<div class="col-xs-6 padding-left-45" style="z-index: 30;">
				<div class="row ">
					<div class="col-xs-12 banner-text">
						<div class="col-xs-12 title-ment">
							<h3>모든 일에는</h3>
							<h3>전문가가 필요합니다.</h3>
							<h4>각 분야 전문가들의 실력을 빌려보세요.</h4>
						</div>
					</div>
				</div>
				<div class="row">
					<form method="GET" action="${pageContext.request.contextPath}/board/search" accept-charset="UTF-8" id="searchKeyword" class="margin-bottom-0" data-name="메인 상단" data-type="기본">
						<div class="col-xs-12">
							<div class="col-xs-12 search-group form-inline">
								<select class="form-control" id="board_type" name="board_type">
									<option value="E">기술자</option>
									<option value="C">요청자</option>
								</select>
								<input class="form-control " placeholder="어떤 서비스가 필요하세요?" id="mainKeyword" name="keyword" type="text">
								<input class="form-control " placeholder="검색 필터(t,c,tc:title contents,i:id)" id="searchType" name="searchType" type="hidden" value="tc">
								<button id="mainSearchBtn" type="submit" class="btn btn-success">검색</button>
							</div>
						</div>
					</form>
				</div>
			</div>

			<div class="col-xs-6 padding-right-45">
				<div id="tagsList">
					<span><a href="http://www.daum.net">다음</a></span> <span><a href="http://www.google.com">구글</a></span>
				</div>
			</div>
		</div>
	</div>
</section>

<div class="modal fade " id="service-search-modal" tabindex="-1" role="dialog" aria-labelledby="layer_msg_title" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<div>
					<h1>"${searchWord }"에 대한 검색 결과가 없습니다.</h1>

					<h1>다음 서비스를 찾고 있나요?</h1>
				</div>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>

				<h4 class="modal-title" id="layer_msg_title">알림</h4>
			</div>
			<div class="modal-body" id="layer_msg_content">

				<div>
					<ul>
						<li><a href="${pageContext.request.contextPath}/hire/영어"> 영어 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/수학"> 수학 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/피아노키보드"> 피아노/키보드 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/비즈니스-영어"> 비즈니스 영어 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/보컬"> 보컬 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/국어"> 국어 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/과학"> 과학 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/시창청음화성학"> 시창청음/화성학 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/작곡-편곡"> 작곡/편곡 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/음악-편집-및-제작"> 음악 편집 및 제작 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/기타"> 기타 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/BGM-사운드-제작"> BGM/사운드 제작 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/toeic"> TOEIC/speaking/writing 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/중국어"> 중국어 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/일본어일어"> 일본어(일어) 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/퍼스널트레이닝"> 퍼스널트레이닝(PT) </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/미디컴퓨터작곡"> 미디/컴퓨터작곡 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/비즈니스-중국어"> 비즈니스 중국어 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/소묘-드로잉"> 소묘/드로잉 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/사회"> 사회 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/미술-회화"> 미술 회화 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/연기"> 연기 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/일러스트-디자인"> 일러스트 디자인 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/영어-번역"> 영어 번역 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/축가"> 축가 요청 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/바이올린"> 바이올린 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/비즈니스-일본어"> 비즈니스 일본어 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/성악"> 성악 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/명함-디자인"> 명함 디자인 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/로고-디자인"> 로고 디자인 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/논술"> 논술 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/인쇄물-디자인"> 인쇄물 디자인 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/개인용-사진-촬영"> 개인용 사진 촬영 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/toefl"> TOEFL 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/기업-상업용-사진-촬영"> 기업/상업용 사진 촬영 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/방송댄스"> 방송댄스 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/검정고시"> 검정고시 과외 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/프로그래밍"> 프로그래밍/코딩 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/사진촬영"> 사진 촬영/편집 레슨 </a></li>
						<li><a href="${pageContext.request.contextPath}/hire/스트릿-댄스"> 스트릿댄스 레슨 </a></li>
					</ul>
				</div>

			</div>
			<div class="modal-footer">

				<div>
					<div class="other-cat-desc">
						<p>다른 이름으로 서비스가 존재할 수 있어요.</p>
						<p>다음 카테고리에서 찾아보시는 건 어떠세요?</p>
					</div>
					<ul>
						<li><a href="/레슨"> 레슨 </a></li>
						<li><a href="/홈-리빙"> 홈/리빙 </a></li>
						<li><a href="/이벤트"> 이벤트 </a></li>
						<li><a href="/비즈니스"> 비즈니스 </a></li>
						<li><a href="/디자인-개발"> 디자인/개발 </a></li>
						<li><a href="/건강-미용"> 건강/미용 </a></li>
						<li><a href="/기타"> 기타 </a></li>
					</ul>
				</div>

				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>