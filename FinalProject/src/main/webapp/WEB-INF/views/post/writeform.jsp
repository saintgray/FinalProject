<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/defaultpageset.jsp"%>
	<%@ include file="/WEB-INF/views/post/pageset/writeformpageset.jsp"%>

	<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>

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
			프로필 정보가 출력될 영역입니다.

			<%-- <c:if test="${writerProfile ne null}">
<table>
<tr>
	<td rowspan="2"><img src="${writerProfile.m_photo}"></td>
	<td>${writerProfile.m_nm} / 활동지역정보</td>
</tr>
<tr>
	<td colspan="2">${writerProfile.line}</td>
</tr>
</table>
</c:if>

<c:if test="${writerProfile eq null}">
글쓴이의 프로필 정보가 없습니다.
</c:if> --%>
		</div>

		<!-- 게시글 작성 -->
		<div>

			<form role="form" method="post" enctype="multipart/form-data"
				id="writePost">

				<!-- 제목 -->
				<input type="text" name="post_nm" id="post_nm"
					placeholder="제목을 입력하세요."><br>

				<!-- 내용 -->
				<textarea name="post_content" id="content"></textarea>
				<br>

				<!-- 카테고리 인덱스 -->
				<div id="categoryInfos">
				</div>

				<input type="hidden" name="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
				<input type="hidden" name="m_idx" value="${idx}">

				<!-- 파일업로드 -->
				<input type="file" name="attachFile" id="attachFile" multiple>
				<br>

				<button type="reset">리셋</button>
				<button type="button" id="ajaxBtn">작성</button>

			</form>

		</div>



	</div>

	<script>
		$(document).ready(function() {

			/* $('button[type="submit"]'). */

		})
	</script>
</body>

</html>