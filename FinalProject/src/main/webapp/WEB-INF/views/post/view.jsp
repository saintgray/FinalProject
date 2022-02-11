<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${viewRequest eq null}">
<script>
alert('해당 게시물이 존재하지 않습니다.');
history.go(-1);
</script>
</c:if>
<c:if test="${viewRequest ne null}">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- Container -->
<div class="container" id="PostViewArea">

<table>
<tr>
	<td>매치유무</td>
	<td>${viewRequest.cat_nm}</td>
	<td>${viewRequest.post_nm}</td>
</tr>

<c:if test="${writerProfile ne null}">
<tr>
	<td rowspan="2"><img src="${writerProfile.m_photo}"></td>
	<td colspan="2">${writerProfile.m_nm} / 활동지역정보</td>
</tr>
<tr>
	<td colspan="3">${writerProfile.line}</td>
</tr>
</c:if>

<c:if test="${writerProfile eq null}">
<tr>
<td colspan="3">글쓴이의 프로필 정보가 없습니다.</td>
</tr>
</c:if>

<tr>
	<td colspan="3">${viewRequest.post_content}</td>
</tr>

<tr>
	<td colspan="3">매칭정보</td>
</tr>

<sec:authorize access="isAuthenticated()">
	<c:set var="idx">
	   <sec:authentication property="principal.m_idx" />
	</c:set>
</sec:authorize>

<c:if test="${viewRequest.m_idx eq idx}">
<tr>
	<td><a href="${pageContext.request.contextPath}/post/edit?idx=${viewRequest.post_idx}">수정</a></td>
	<td>삭제</td>
</tr>
</c:if>

</table>

</div>

</body>
</html>

</c:if>