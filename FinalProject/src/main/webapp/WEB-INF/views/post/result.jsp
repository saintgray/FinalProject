<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<div class="container">
<c:if test="${result} eq 0">
작성 실패
</c:if>
<c:if test="${result} eq 1">
<h3>게시물이 정상적으로 등록되었습니다.</h3>
<hr>
${wRequest.post_nm} <br>
${wRequest.post_content}

</c:if>
</div>
</body>
</html>

