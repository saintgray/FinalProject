<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp"%>
<style>
#wrap{
		padding: 20px 40px 0;
		padding-bottom:10px;
	}

#contentarea{
		
		border-radius: 15px;
		background-color: #E1DEE660;
		min-height: 400px;
		
		padding: 20px 10px;
	
	}
</style>
<title>1대1 문의내용</title>
</head>
<body>
<div class="gw">
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
	<h1 class="mx-5 banner">문의내용</h1>
	<div class="d-flex justify-content-start mx-5 my-4">
	<sec:authorize access="hasRole('ADMIN')">
			<c:set var="admin_idx">
				<sec:authentication property="principal.admin_idx" />
			</c:set>
			<button type="button" class="btn btn-general" id="listbtn">목록</button>
			</sec:authorize>
			</div>
	<div class="container" id="wrap">

		<h1 align="center">제목: ${content.qna_title}</h1>
		<h6 align="right">작성자: ${content.m_nm} 이메일: ${content.m_email}</h6>
		<h6 align="right">작성일: ${content.qna_regdate}</h6>
		<hr>
		<div id="contentarea" class="shadow">
			<h4>${content.qna_content}</h4>
		</div>
	</div>

	<div class="d-flex flex-row flex-wrap justify-content-end mx-5 my-4">
		<sec:authorize access="hasRole('ADMIN')">
			<c:set var="admin_idx">
				<sec:authentication property="principal.admin_idx" />
			</c:set>
			<button type="button" class="btn btn-general" id="replybtn">답글</button>
		</sec:authorize>
	</div>
</div>
	<%@ include file="/WEB-INF/views/layout/footer.jsp"%>
</body>
<script>
	$(function() {

		$('#listbtn')
				.click(
						function() {
							//location.href = "${pageContext.request.contextPath}/qna/list?selectPage=${param.selectPage}&numOfMemberPerPage=${param.numOfQnaPerPage}";
							history.go(-1);
							
						});
		$('#replybtn')
				.click(
						function(){
							
							location.href = "${pageContext.request.contextPath}/admin/reply/register?m_idx=${content.m_idx}&qna_idx=${content.qna_idx}";
						})

	})
</script>
</html>