<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
#noticeList span{
	padding: 0 10px;
}
</style>
<title>공지사항</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
		<h1>공지사항 페이지 입니다.</h1>
	
		<!--  List<Notice> 객체가 Model 에 notices 라는 포장지로 감싸져있음 -->
		<!--  c:forEach 태그의 items 속성은 List<Notice> 를 의미함 -->
		<!-- var 속성은 그 리스트 안의 Notice 를 의미함 -->
		<c:forEach var="items" items="${notices.noticeList}">
			<div class="d-flex flex-row flex-wrap" id="noticeList">
				<span>${items.notice_idx}</span>
				<span>${items.notice_title}</span>
				<span>${items.notice_regdate}</span>		
			</div>
		</c:forEach>
		<c:forEach begin="1" end="${notices.totalPage}" var="pnum">
			<a href="${pageContext.request.contextPath}/notice?selectPage=${pnum}&numOfNoticesPerPage=5">${pnum}</a>
		</c:forEach>
		
		
		
	
	
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>



</body>

</html>