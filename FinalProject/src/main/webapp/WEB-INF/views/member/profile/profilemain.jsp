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
	
}

</style>
<title>내 프로필</title>
</head>
<body>

<%@include file="/WEB-INF/views/layout/header.jsp" %>


<div class="container" id="profileglobalwrap">
	
	<c:if test="${empty profile}">
	
		
		<div id="regarea">
			<h3 id="msg">내 프로필이 비었습니다.<br> 지금 등록하세요</h3>
			
			<img src="${pageContext.request.contextPath}/resources/files/server/icons/icon_plus.png" id="plus_icon">
						
		</div>	
		
	</c:if>
	
	<c:if test="${not empty profile}">
	
		<h1> 내 프로필을 이 구역안에 출력되도록 하세요</h1>
	</c:if>

</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

<script>

	$(document).ready(function(){
		$('#plus_icon').on('click',function(){
			
			location.href="${pageContext.request.contextPath}/member/profile/register"
		})
		
	})
</script>
</html>