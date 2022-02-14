<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>QNA</title>
</head>
<body>

	<table>
		
	<tr>
		<td>번호</td>
		<td>제목</td>
		<td>등록일</td>
	</tr>
		<c:forEach var="item" items="${pageView.qnaList}">
			<tr>
				<td>${item.qna_idx}</td>
				<td>${item.qna_title}</td>
				<td>${item.qna_regdate}</td>
			</tr>			
		</c:forEach>
	</table>
	
	
	<div class="d-flex flex-row justify-content-center">
		<c:forEach begin="1" end="${pageView.totalPage}" var="pageNum">
			<span class="mx-1">${pageNum}</span>
		</c:forEach>
	</div>
	
	
	
	
	




</body>
</html>