<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

	<%@ include file="/WEB-INF/views/defaultpageset.jsp"%>

	<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>

	<!-- Container -->
	<div class="container" id="PostListArea">
	
		<sec:authorize access="isAuthenticated()">
			<c:set var="idx">
				<sec:authentication property="principal.m_idx" />
			</c:set>
			<c:set var="type">
				<sec:authentication property="principal.m_type" />
			</c:set>
		</sec:authorize>

		<div class="row">
			<!-- 분야 선택 -->
			<div class="d-flex flex-column my-3 col-4" id="categorySection">
				<div class="descript my-1 ms-0 me-1">분야 선택</div>
				<button type="button" class="btn btn-grey fs-6"	onclick="resetCategory()">초기화</button>
				<!-- 카테고리 selectbox -->
				<div id="categoryInfos" class="d-flex flex-row flex-wrap  mb-5 mt-1">
				</div>
			</div>

			<!-- 지역 선택 -->
			<div class="d-flex flex-column my-3 col" id="locSection">
				<div class="descript mb-2">지역 선택</div>
				<div class="d-flex flex-wrap justify-content-around" id="locarea">

				</div>
			</div>
			<input type="hidden" id="m_idx" value="${idx}">
			<input type="hidden" id="wanted" value="${type}">
			<button id="searchBtn">검색</button>

		</div>

		<div id="recommendList" class="list=group">
			
		</div>

		<div id="searchResult" class="list-group">
			<div class="descript mb-2">검색 결과</div>
			<c:if test="${not empty listView.list}">
				<c:forEach items="${listView.list}" var="listInfo">

					<a href="view?idx=${listInfo.post_idx}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<h5 class="mb-1">
								<c:out value="${listInfo.post_nm}" escapeXml="true" />
							</h5>
						</div>
						<p class="mb-1">${listInfo.cat_nm}/${listInfo.loc_nm}</p>
					</a>

				</c:forEach>
			</c:if>
			
			<c:if test="${empty listView.list}">
				검색 결과가 없습니다.
			</c:if>
			
		</div>
		
		<nav aria-label="paging">
			<c:if test="${listView.totalPageCount > 0}">
				<ul class="pagination justify-content-center">
					<c:forEach begin="1" end="${listView.totalPageCount}" var="pnum">
						<li class="page-item"><a class="page-link" href="searchTest?cat=${cat}&loc=${loc}&p=${pnum}">${pnum}</a></li>
					</c:forEach>
				</ul>
			</c:if>
		</nav>

	</div>
	
<!-- Footer -->
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

	<script>
		let cat_idx;
		let cat_select;

		function resetCategory() {
			$('#categoryInfos').html('');
			cat_idx = 0;

			selectCategory();
		}

		function selectCategory(dom) {

			var interest = $(dom).children('option:selected').val();

			$.ajax({
				url : '${pageContext.request.contextPath}/category/list',
				type : 'GET',
				data : {interest : interest},
				datatype : 'json',
				success : function(data) {

					// remove all next Siblings		
					$(dom).parent().nextAll().remove();

					if (data.length == 0) {

						// 현재 선택한 interest 값을 cat_idx 에 저장한다.
						cat_idx = interest;
						console.log(cat_idx);
						cat_select=true;

					} else {

						var html = "";
							html += '<div class="selectarea mx-1">\r\n';
							html += '<select onchange="selectCategory(this)">\r\n';
							html += '<option value="">선택</option>\r\n';

						$(data).each(function(index, items) {
							console.log(items.cat_idx);
							console.log(items.cat_nm);

							html += '<option value="'+items.cat_idx+'">'+items.cat_nm+'</option>';

						})
						html += '</select>\r\n';
						html += '</div>'

						$('#categoryInfos').append(html);
						console.log(html);
						cat_idx = interest;

						}

					},
				error : function(data) {
					console.log(data);
				}
			});

		}

		function getLocations() {
			$.ajax({
				url : "${pageContext.request.contextPath}/loc/list",
				type : "POST",
				dataType : "json",
				success : function(data) {
					$(data).each(function(index, item) {
						var html = '<div class="form-check mx-3">\r\n';
							html += '<input class="form-check-input inp_loc" type="radio" id="loc'+item.loc_idx+'" name="loc" value="'+item.loc_idx+'">\r\n';
							html += '<label class="form-check-label" for="loc'+item.loc_idx+'">\r\n';
							html += item.loc_nm
							html += '</label>\r\n';
							html += '</div>\r\n';

							$('#locarea').append(html);

					})

					var html = '<div class="form-check mx-3">\r\n';
						html += '<input class="form-check-input inp_loc" type="radio" id="noneLoc" name="loc" value="">\r\n';
						html += '<label class="form-check-label" for="noneLoc">선택안함</label>\r\n';
						html += '</div>\r\n';
						
					$('#locarea').append(html);

				},
				error : function(data) {
					console.log('통신실패');
					console.log(data);
					}
				})

		}
		
		// 추천멘토/멘티리스트 : 회원이 가입시 선택한 분야/지역 적용, 무작위 5건
		function recommendList(){
			var m_idx=$('#m_idx').val();
			var wanted=$('#wanted').val();
			
			$.ajax({
				url: '${pageContext.request.contextPath}/post/recommend',
				type: 'post',
				data: {
					m_idx : m_idx,
					wanted : wanted
				},
				success: function(data){
					console.log(data);
					
					var html='';
					
					if(data.length==0){
						// 추천 리스트가 없을 때
						// 새로운 요청글을 등록해보세요! (요청글 등록 버튼 띄우기)
						
					} else {
						// 추천 리스트가 있을 때
						// 리스트 표시하기
						html+='<div class="descript mb-2">이 \r\n';
						html+='<c:if test="${type eq \'mentor\'}">멘티</c:if>\r\n';
						html+='<c:if test="${type eq \'mentee\'}">멘토</c:if>\r\n';
						html+='는 어떠세요?\r\n';
						html+='</div>\r\n';
						
						$(data).each(function(index, item) { 
							html+='		<a href="view?idx='+item.post_idx+'" class="list-group-item list-group-item-action">\r\n';
						 	html+='			<div class="d-flex w-100 justify-content-between">\r\n';
						 	html+='				<h6 class="mb-1">'+item.post_nm+'</h6>\r\n';
						 	html+='			</div>\r\n';
						 	html+='			<p class="mb-1">'+item.cat_nm+' / '+item.loc_nm+'</p>\r\n';
						 	html+='		</a>\r\n';
						})
					}
					
					$('#recommendList').append(html);
					
				},
				error: function(data){
					console.log('통신오류');
					console.log(data);
				}
			});
		}
		
		$(document).ready(function() {
			selectCategory(30);
			getLocations();
			recommendList();
			
			$('#searchBtn').on("click", function(){
				// 검색하기
	
				console.log('cat_idx:', cat_idx);
				console.log('cat_select:', cat_select);
					
				// 아예 분야를 선택하지 않거나 / 분야를 끝까지 선택하거나
				// 분야 선택을 시작했지만 끝까지 가지 않았을 때
				// cat_idx 가 undefined 가 아니고 cat_select 가 true 가 아닐 때
				if(cat_idx!==undefined && cat_select!=true){
					alert('분야를 끝까지 선택하거나 초기화하세요.');
					return false;
				}
				
				if(cat_idx===undefined){
					cat_idx=0;
				}
					
				var loc_idx=0;
					
				console.log($('#locarea .inp_loc:checked').val());
					
				if($('#locarea .inp_loc:checked').val()>0){
					loc_idx=$('#locarea .inp_loc:checked').val();
				}
					
				console.log('cat_idx:', cat_idx);
				console.log('loc_idx:', loc_idx);
				
				var searchParams={
						cat : cat_idx,
						loc : loc_idx,
						p : 1
				};
					
				console.log(searchParams);
				
				const queryString = new URLSearchParams(searchParams).toString();
					
				location.href=location.pathname + '?' + queryString;
			});
		});

	</script>


</body>
</html>