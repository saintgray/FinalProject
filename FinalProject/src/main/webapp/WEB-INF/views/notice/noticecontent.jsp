<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>공지사항</title>
</head>
<body>

<%@include file="/WEB-INF/views/layout/header.jsp" %>

<div class="container gw">
	<h1> 공지사항 내용을 보여주는 jsp 입니다 </h1>
	<h1>제목 : ${content.notice_title}</h1>
	<h3>내용: ${content.notice_content}</h3>
	<h3>작성일 : ${content.notice_regdate}</h3>
	<h3>수정일  : ${content.notice_editdate}</h3>
	<h3>작성자: ${content.admin_nm }</h3>
	<h3>게시글 고유번호 : ${content.notice_idx}</h3>
	
	<sec:authorize access="hasRole('ADMIN')">
		<div class="d-flex flex-row flex-wrap justify-content-center">
			<button type="button" class="btn btn-general" id="editbtn">수정</button>
			<button type="button" class="btn btn-danger" id="delbtn">삭제</button>		
		</div>
	</sec:authorize>
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

<script>

	$(document).ready(function(){
		
		$('#editbtn').click(function(){
			// 수정하는 폼을 보여줌
			// 공지사항의 수정은 관리자만 할 수 있다
			location.href="${pageContext.request.contextPath}/admin/notice/edit?notice_idx=${content.notice_idx}";
			
		})
		
	})

</script>
</html>