<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
	.article{
	padding: 20px 40px 0;
    border-radius: 6px;
	}
	#reportedarea{
		margin-top: 150px;
	}
</style>
<title>신고내용</title>
</head>
<body>

<div class="gw">
<%@include file="/WEB-INF/views/layout/header.jsp" %>

	
	<div class="container article" id="reportedarea">
	<h1 class="banner">신고내역</h1>
	
	<c:if test="${empty list}">
		<h1>이 회원은 신고당한 이력이 없습니다.</h1>
	</c:if>
	
	
	<c:if test="${not empty list}">
		<c:forEach var="item" items="${list}">
			<h5>신고자: ${item.m_nm}</h5>
			<h5>채팅내용: ${item.message}</h5><hr>
			<h4>신고내용: ${item.report_content}</h4><hr><br>
		
		</c:forEach>
	</c:if>
	</div>

</div>	
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

</html>