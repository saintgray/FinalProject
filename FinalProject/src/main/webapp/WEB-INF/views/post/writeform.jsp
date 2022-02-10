<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<%@ include file="/WEB-INF/views/post/pageset/writeformpageset.jsp"  %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- Container -->
<div class="container">

<sec:authorize access="isAuthenticated()">
	<c:set var="idx">
	   <sec:authentication property="principal.m_idx" />
	</c:set>
	<c:set var="type">
	   <sec:authentication property="principal.m_type" />
	</c:set>
</sec:authorize>

<!-- 프로필 출력 -->
<div>
	
</div>

<!-- 게시글 작성 -->
<div>

<form role="form" method="post" enctype="multipart/form-data" id="writePost">

<!-- 제목 -->
<input type="text" name="post_nm" id="post_nm" placeholder="제목을 입력하세요."><br>

<!-- 내용 -->
<textarea name="post_content" id="content"></textarea> <br>

<!-- 카테고리 인덱스 -->
<select id="parentCategory" onchange="selectCategory(this.value)">
	<option value="">선택</option>
	<option value="1">음악</option>
	<option value="2">미술</option>
	<option value="3">요리</option>
</select>

<select id="childCategory" name="cat_idx">
	<option value="19">실험용</option>
</select>

<br>

<input type="hidden" name="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
<input type="hidden" name="m_idx" value="${idx}">

<!-- 파일업로드 -->
<input type="file" name="attachFile" id="attachFile" multiple> 
<br>

<button type="reset">리셋</button> <button type="submit">작성</button> <button type="button" id="ajaxBtn">ajax로 작성</button>

</form>

</div>



</div>

<script>

$(document).ready(function(){

	/* $('button[type="submit"]'). */
	
})
</script>
</body>

</html>