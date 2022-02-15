<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/default/summernote-bs4.js"></script> --%>
<!-- timepicker script & css -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- profilemain CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/profilemain.css">

<title>내 프로필</title>
</head>
<body>


<div class="gw">
	<%@include file="/WEB-INF/views/layout/header.jsp" %>
	
	
	<div class="container" id="profileglobalwrap">
		<!-- 등록한 프로필이 없을때 + 등록했던 프로필을 모두 삭제했을 때 -->
		<c:set var="m_idx">
			<sec:authentication property="principal.m_idx"/>
		</c:set>
		
		<!-- 만약 이 프로필이 비어있다면 -->
		<c:if test="${empty profile}">
			<c:set var="m_idx">
				<sec:authentication property="principal.m_idx"/>
			</c:set>
		
			<!-- 이 프로필의 소유주 idx 가 현재 로그인한 사람의 idx 와 같다면 -->
			<c:if test="${profileOwnerIdx eq m_idx}">
		
				<div id="regarea" class="d-flex flex-column mx-auto my-4">
					<h3 id="msg">내 프로필이 비었습니다.<br> 지금 등록하세요</h3>
					
					<img src="${pageContext.request.contextPath}/resources/files/server/icons/icon_plus.png" id="plus_icon">
								
				</div>	
				
			</c:if>
			
			<!-- 이 프로필의 소유주 idx 가 현재 로그인한 사람의 idx 와 다르다면  -->
			<c:if test="${profileOwnerIdx ne m_idx}">
				
				<div class="d-flex flex-wrap justify-content-center">
					<h1> 이 회원은 프로필이 없습니다. </h1>
				</div>
			</c:if>
			
		</c:if>
		
		
		<!-- 해당 유저의 프로필이 있고 해당 유저가 탈퇴하지 않았을 시 -->
		<c:if test="${not empty profile and empty profile.m_quitdate}">
		
			<c:set var="photo">
				<sec:authentication property="principal.photo"/>
			</c:set>
			<c:set var="m_idx">
				<sec:authentication property="principal.m_idx"/>
			</c:set>
			
			<!-- 프로필 사진, 별점, 매칭수, 리뷰수 -->
			<div id="maininfo" class="d-flex flex-wrap my-5 justify-content-center">
				<img src="${pageContext.request.contextPath}/resources/files/member/${photo}" id="myphoto" class="mx-5">
				<div class="d-flex flex-wrap flex-column">
					<div class="d-flex flex-wrap mb-2 justify-content-center">
						<div id="bg_template">
					        <img src="${pageContext.request.contextPath}/resources/files/server/icons/teststar.png" class="star">
					        <img src="${pageContext.request.contextPath}/resources/files/server/icons/teststar.png" class="star">
					        <img src="${pageContext.request.contextPath}/resources/files/server/icons/teststar.png" class="star">
					        <img src="${pageContext.request.contextPath}/resources/files/server/icons/teststar.png" class="star">
					        <img src="${pageContext.request.contextPath}/resources/files/server/icons/teststar.png" class="star">
					    </div>
					</div>
					
					<div class="d-flex flex-wrap  justify-content-around my-2 activity">
						<span class="activity_info">평점 : ${profile.avgStars}</span>
						<span class="br-col"></span>
						<span class="activity_info">고용수 : 0개</span>
						<span class="br-col"></span>
						<span class="activity_info">리뷰수 : 0개</span>
					</div>
					
				</div>
			</div>
			<!-- ------------------------------------------- -->
			
			<!-- 한줄 소개 -->
			<div class="d-flex flex-column mb-5">
				<div class="d-flex flex-wrap">
					<div class="banner flex-grow-1">
						한줄 소개
					</div>
					<c:if test="${m_idx eq profile.m_idx}">
						<button id="editline" class="btn btn-general edit ms-auto" data-bs-toggle="modal" data-bs-target="#editarea">수정</button>
					</c:if>
				</div>
				<span id="originline">${profile.line}</span>
			</div>
			<!-- ------------------------------------------- -->
			
			<!-- 연락 가능 시간  -->
			<div class="d-flex flex-column mb-5">
				<div class="d-flex flex-wrap">
					<div class="banner flex-grow-1">
						연락 가능 시간
					</div>
					<c:if test="${m_idx eq profile.m_idx}">
						<button id="editcalltime" class="btn btn-general edit ms-auto" data-bs-toggle="modal" data-bs-target="#editarea">수정</button>
					</c:if>
				</div>
				<span>${profile.calltime}</span>
			</div>
			<!-- ------------------------------------------- -->
			
			<!-- 경력 -->
			
			<div class="d-flex flex-column mb-5">
				<div class="d-flex flex-wrap">
					<div class="banner flex-grow-1">
						경력
					</div>
					<c:if test="${m_idx eq profile.m_idx}">
						<button id="editcareer" class="btn btn-general edit ms-auto" data-bs-toggle="modal" data-bs-target="#editarea">수정</button>			
					</c:if>
				</div>
				<div id="careerarea">
					${profile.career}
				</div>
				
				<div>
			 	<!-- 첨부 파일 영역 -->
			 	<!-- DB에서 해당 프로필의 고유번호에 해당하는 첨부파일을 받아와 다운로드 형태로 출력 -->
				</div>	
			</div>
			
			
			<!-- ------------------------------------------- -->
			
			<!-- QNA -->
			
			<div class="d-flex flex-column mb-5">
				<div class="d-flex flex-wrap">
					<div class="banner flex-grow-1">
						QNA
					</div>
					<c:if test="${m_idx eq profile.m_idx}">
						<button id="editqna" class="btn btn-general edit ms-auto" data-bs-toggle="modal" data-bs-target="#editarea">수정</button>
					</c:if>
				</div>
				<div id="qnaarea">
					${profile.qna}
				</div>
			</div>
			
			
			
			
			
			
		
			<!-- 수정시 해당 항목을 수정하는 팝업 영역 -->
			<div class="modal fade" id="editarea" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        ...ㄴㅇ라너이러나ㅣㅇ러
				      </div>
				      <div class="modal-footer d-flex flex-wrap justify-content-around">
				        <button type="button" class="btn btn-grey" data-bs-dismiss="modal" id="close-modal">취소</button>
				        <button type="button" class="btn btn-general editbtn">수정</button>
				      </div>
				    </div>
				</div>	
			</div>
			
			
			<!-- 프로필에 등록한 첨부파일들 -->
			<div class="banner">
				등록파일
			</div>
			<div class="d-flex flex-row flex-wrap" id="attachedFilesWrap">
				
				<div class="d-flex flex-wrap  flex-grow-1" id="attachFilesArea">
					<c:if test="${empty profile.files}">
						<span class="fw-bold" style="color:rgb(70,70,70)">파일이 없습니다</span>
					</c:if>
					
					<c:forEach var="file" items="${profile.files}">
					
						<div class="select d-flex flex-wrap">
							<span style="display:none" class="fileName">${file.file_nm}</span>
							<a class="mx-2" href="${pageContext.request.contextPath}/resources/files/member/profile_attachfiles/${file.file_nm}" download>${file.file_originnm}</a>
							<img src="${pageContext.request.contextPath}/resources/files/server/icons/icon_x.png" class="delRow me-3">
						</div>
							
										
					
					</c:forEach>
				
				</div>
				
				<div class="d-flex flex-column justify-content-center">
					<label for="addfiles" id="label_files">
						<i class="fi fi-rr-add"></i>
					</label>
					<input multiple type="file" style="display:none" id="addfiles">
				</div>
			</div>
			
			<c:if test="${profile.m_idx eq m_idx}">
				<div class="d-flex flex-wrap justify-content-center mb-5">
					<button type="button" class="btn btn-danger" id="delProfile">프로필 삭제</button>
				</div>
			</c:if>
			
			
			
			<script>
			
				 // DB 에서 해당 회원의 평점을 계산해서 5점 만점에 평균 x점이 나왔다고 가정하자.
		        // 별 5개 이미지 길이만큼의 x에 대한 백분율 만큼 #bg_template 길이를 결정해 주면 될것이다.
		        // 예를 들어 3.3점이라 하자.
		        
		        var avgRank=${profile.avgStars};
		        // 일의 자리수 추출
		        var fullStars=Math.floor(avgRank);
		        // 소수점 자리수 추출
		        var remainStarSize=(avgRank%1).toFixed(2); 
		        var width=$('.star').width();
		        var border=$('.star').css('border-right-width').replace("px","");
		       console.log('fullStars>>>'+fullStars);
		       console.log('remainStarSize>>'+remainStarSize);
		       console.log('imgWidth'+width);
		       console.log('border>>'+border);
		       
		        // 노랑색 바의 길이 = fullStar의 갯수*(star이미지의 width + star 이미지의 border-right 두께) + 소숫점첫째자리*star 이미지의 넓이
		        barLength=fullStars*(width+parseInt(border))+($('.star').width())*remainStarSize;
		        console.log(barLength);
		        $('#bg_template').css('background-size',barLength+'px '+width+'px');
		        
		       
		      
		        // 별 랭킹의 전체 크기를 조정할 경우 css의 .star 스타일의 width 속성값을 조절한다.
		        // avgRank 는 해당 튜터의 평균 랭킹을 DB에서 계산한 다음 반환된 값이어야 한다.
		        // 랭킹이 들어간 레이아웃은 white 배경이어야 한다. >> 아닐 경우 새 별 이미지 작업 필요함
		        // background 의 url 이미지 경로와 별모양 이미지는 서버 경로의 정적파일(resources) 에 있는 서버용 이미지들 경로로 잡는다.
			</script>
			
			
			
		</c:if>
		
		
		<!-- 해당 유저의 프로필은 있는데 탈퇴한 회원인 경우 -->
		<c:if test="${not empty profile and not empty profile.m_quitdate}">
		
			<h1>탈퇴한 회원입니다.</h1>
			
		</c:if>
				
	</div>

</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>

<%@include file="/WEB-INF/views/member/profile/pageset/profilemainpageset.jsp" %>


</body>


</html>