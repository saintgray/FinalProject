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

		<div class="list-group">
			<c:if test="${empty listView.list}">
				등록된 요청글이 없습니다.
			</c:if>

			<c:if test="${not empty listView.list}">
				<c:forEach items="${listView.list}" var="listInfo">

					<a href="view?idx=${listInfo.post_idx}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<h5 class="mb-1">
								<c:out value="${listInfo.post_nm}" escapeXml="true" />
							</h5>
							<small>${listInfo.match_yn}</small>
						</div>
						<p class="mb-1">${listInfo.cat_nm}/${listInfo.loc_nm}</p>
					</a>

				</c:forEach>
			</c:if>
		</div>

		<div id="paging">
			<c:if test="${listView.totalPageCount > 0}">
				<c:forEach begin="1" end="${listView.totalPageCount}" var="pnum">
					<a href="list?p=${pnum}" class="${listView.currentPage eq pnum ? 'curPage' : ''}">${pnum}</a>
				</c:forEach>

			</c:if>
		</div>

	</div>

</body>
</html>