<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<div class="container" id="PostListArea">

<div>
검색 영역
<select id="parentCategory">
	<option value="">분야선택</option>
	<option value="1">음악</option>
	<option value="2">미술</option>
	<option value="3">요리</option>
</select>
<select id="childCategory">

</select>
<select id="loc_idx">
	<option value="">지역선택</option>
	
</select>
<button id="searchBtn">검색</button>

</div>

<div>
추천 멘토/멘티 리스트 영역
</div>

<div>
검색 결과 리스트 영역
</div>

</div>


<script>

$(document).ready(function(){
	
});

/*
 
 검색 -> post/search -> List<PostListInfo> 받아오기 -> 화면 출력
 
 */

</script>


</body>
</html>