<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

	<%@ include file="/WEB-INF/views/defaultpageset.jsp"%>

	<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>

	<!-- Container -->
	<div class="container" id="PostListArea">

		타입 : ${logininfo.m_type} <br> 글 수 : ${listView.totalCount} <br>

		<hr>

		리스트 영역

		<table>
			<tr>
				<th>글번호</th>
				<th>분야</th>
				<th>매칭유무</th>
				<th>제목</th>
			</tr>

			<c:if test="${empty listView.list}">
				<tr>
					<td colspan="4">등록된 요청글이 없습니다.</td>
				</tr>
			</c:if>

			<c:if test="${not empty listView.list}">
				<c:forEach items="${listView.list}" var="listInfo">
					<tr>
						<td>${listInfo.post_idx}</td>
						<td>${listInfo.cat_nm}</td>
						<td>${listInfo.match_yn}</td>
						<td><a href="view.do?idx=${listInfo.post_idx}">${listInfo.post_nm}</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div id="paging">
			<c:if test="${listView.totalPageCount > 0}">
				<c:forEach begin="1" end="${listView.totalPageCount}" var="pnum">
					<a href="list?p=${pnum}"
						class="${listView.currentPage eq pnum ? 'curPage' : ''}">${pnum}</a>
				</c:forEach>

			</c:if>
		</div>

	</div>

</body>
</html>