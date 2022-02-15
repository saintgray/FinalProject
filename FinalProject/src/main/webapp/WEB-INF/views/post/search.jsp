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
			<input type="hidden" id="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
			<button id="searchBtn">검색</button>

		</div>

		<div>추천 멘토/멘티 리스트 영역</div>

		<div id="searchResult">
		검색 결과 리스트 영역
		</div>

	</div>


	<script>
		let cat_idx;

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

		$(document).ready(function() {
			selectCategory(30);
			getLocations();
			
			$('#searchBtn').on('click', function(){
				
				var loc_idx=0;
				var m_idx=$('#m_idx').val();
				var wanted=$('#wanted').val();
				
				console.log($('#locarea .inp_loc:checked').val());
				
				if($('#locarea .inp_loc:checked').val()>0){
					loc_idx=$('#locarea .inp_loc:checked').val();
				}
				
				console.log('m_idx:', m_idx);
				console.log('wanted:', wanted);
				console.log('cat_idx:', cat_idx);
				console.log('loc_idx:', loc_idx);
				
				var searchParams={};
				searchParams.m_idx=m_idx;
				searchParams.wanted=wanted;
				searchParams.cat_idx=cat_idx;
				searchParams.loc_idx=loc_idx;
				searchParams.pageNum=1;
				
				console.log(searchParams);
				
				$.ajax({
					url: '${pageContext.request.contextPath}/post/search',
					type: 'post',
					data: JSON.stringify(searchParams),
					dataType: 'json',
					contentType:'application/json; charset=UTF-8',
					processData: false,
					success: function(data){
						
						console.log(data);
						
						/* var html="";
						
						
						$(data).each(function(index, item) {
							
						}) 
						
						10개 이상일 경우 더보기 버튼 밑에 출력하기
						
						*/
					},
					error: function(data){
						console.log('통신오류');
					}
				})
			})
		});

		/*
		
		 검색 -> post/search -> PostListView 받아오기 -> 화면 출력
		
		 */
	</script>


</body>
</html>