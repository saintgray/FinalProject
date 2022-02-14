<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>신고내용</title>
</head>
<body>
<%@include file="/WEB-INF/views/layout/header.jsp" %>

	<h1 class="banner">신고내역</h1>
	
	<c:if test="${empty list}">
		<h1>이 회원은 신고당한 이력이 없습니다.</h1>
	</c:if>
	
	<c:if test="${not empty list}">
		<c:forEach var="item" items="${list}">
			<h1>신고자: ${item.m_nm}</h1>
			<h1>신고내용: ${item.report_content}</h1>
			<h1>채팅내용: ${item.message}</h1>
		
		</c:forEach>
	</c:if>
	
	
	
	
	<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>