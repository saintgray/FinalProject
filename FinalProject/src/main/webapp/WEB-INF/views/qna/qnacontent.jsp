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
.article {
	padding: 20px 40px 0;
	border: 1px solid;
	border-radius: 6px;
}
</style>
<title>1대1 문의내용</title>
</head>
<body>
<div class="gw">
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
	<h1 class="mx-5 banner">문의내용</h1>
	<div class="container article">

		<h3>제목: ${content.qna_title}</h3>
		<hr>
		<h6>작성자: ${content.m_nm} 이메일: ${content.m_email}</h6>
		<h6>작성일: ${content.qna_regdate}</h6>
		<hr>
		<h4>문의내용: ${content.qna_content}</h4>

	</div>

	<div class="d-flex flex-row flex-wrap justify-content-center my-5">
		<sec:authorize access="hasRole('ADMIN')">
			<c:set var="admin_idx">
				<sec:authentication property="principal.admin_idx" />
			</c:set>


			<button type="button" class="btn btn-general" id="listbtn">목록</button>
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
							location.href = "${pageContext.request.contextPath}/qna/list?selectPage=${param.selectPage}&numOfMemberPerPage=${param.numOfQnaPerPage}";

						});
		$('#replybtn')
				.click(
						function(){
							
							location.href = "${pageContext.request.contextPath}/admin/reply/register?m_idx=${content.m_idx}&qna_idx=${content.qna_idx}&selectPage=${param.selectPage}&numOfQnaPerPage=${param.numOfQnaPerPage}"
						})

	})
</script>
</html>