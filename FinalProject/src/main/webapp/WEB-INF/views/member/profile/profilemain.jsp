<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
#profileglobalwrap{
	margin-top: 150px;
}
#regarea{
	position: relative;
    width: 500px;
    height: 300px;
    border: 5px solid rgb(59,59,59);
    border-style: dashed;
    border-radius: 30px;
}
#regarea #msg{
	font-size: 28px;
    color: rgb(59,59,59);
    font-weight: 700;
    padding: 20px;
    text-align: center;
}

#plus_icon{
	position :absolute;
	left: 50%;
	bottom: 10px;
	width: 50px;
	height: 50px;
	transform: translate(-50%);
	cursor: pointer;
	
}

</style>

<title>내 프로필</title>
</head>
<body>
<%-- <c:if test="${not empty error}">
	<script>
		alert(error);
		location.href="${pageContext.request.contextPath}/";
	</script>
</c:if> --%>


<%@include file="/WEB-INF/views/layout/header.jsp" %>


<div class="container" id="profileglobalwrap">
	<!-- 등록한 프로필이 없을때 + 등록했던 프로필을 모두 삭제했을 때 -->
	<c:if test="${empty profile}">
	
		
		<div id="regarea" class="d-flex flex-column mx-auto my-4">
			<h3 id="msg">내 프로필이 비었습니다.<br> 지금 등록하세요</h3>
			
			<img src="${pageContext.request.contextPath}/resources/files/server/icons/icon_plus.png" id="plus_icon">
						
		</div>	
		
	</c:if>
	
	
	<!-- 해당 유저의 프로필이 있을 때 -->
	<c:if test="${not empty profile}">
	
		<h1> 내 프로필을 이 구역안에 출력되도록 하세요</h1>
		
		<h1>내 별점: ${profile.avgStars}</h1>
		<h1>회원 고유번호 : ${profile.m_idx}</h1>
		<h1>한줄소개 : ${profile.line}</h1>
		<h1>연락가능시간 : ${profile.calltime}</h1>
		<h1>프로필 등록일 : ${profile.profile_regdate}</h1>
		
		
		<h3>경력</h3>
		<div>
			${profile.career}
		</div>
		
		<h3>QNA</h3>
		<div>
			${profile.qna}
		</div>
	</c:if>

</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
<script>
	

	$(document).ready(function(){
		
		
		$('#plus_icon').on('click',function(){
			
			location.href="${pageContext.request.contextPath}/member/profile/register"
		})
		
	})
</script>
</body>


</html>