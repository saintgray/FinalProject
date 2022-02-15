<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
@media(max-width: 750px){
	.subinfo{
	display: none;
	}
}

#listTable{
	border-collapse: separate;
	border-spacing: 0 30px;
	text-align: center;
}
.indexes{
	outline : 1px solid rgb(123,123,123);
	background : rgb(197,197,197);
}
</style>
<title>QNA</title>
</head>
<body>
<div class="gw">
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
	
	<div class="d-flex flex-column justify-content-center" id="globalwrap">
	<h1 class="mx-5 banner">1대1문의 리스트</h1>
	<table class="mx-auto" id="listTable">
		
	<tr class="indexes">
		<td>번호</td>
		<td>제목</td>
		<td>등록일</td>
	</tr>
		<c:forEach var="item" items="${pageView.qnaList}">
			<tr class="my-5">
				<td><span class="px-5">${item.qna_idx}</span></td>
				<td><a class="px-5" href="${pageContext.request.contextPath}/qna/content?qna_idx=${item.qna_idx}&selectPage=${param.selectPage}&numOfQnaPerPage=${param.numOfQnaPerPage}">${item.qna_title}</a></td>
				<td><span class="px-5">${item.qna_regdate}</span></td>
			</tr>			
		</c:forEach>
	</table>
	
	
		<div class="d-flex justify-content-center my-5">
		<c:forEach begin="1" end="${pageView.totalPage}" var="pnum">
			<a class="mx-2" href="${pageContext.request.contextPath}/qna/list?selectPage=${pnum}&numOfQnaPerPage=5">${pnum}</a>
		</c:forEach>
		</div>
	</div>
	
	
	
	
	


<%@ include file="/WEB-INF/views/layout/footer.jsp"%>
</div>
</body>
</html>