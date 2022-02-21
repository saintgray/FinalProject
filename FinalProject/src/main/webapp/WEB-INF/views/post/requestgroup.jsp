<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>받은제의 그룹으로 보여지는 곳</title>
<style>
	.m_photo{
		width:40px;
		height:40px;
		border-radius: 50%;
	}
	.card{
		width:500px;
		margin: 60px;
	}
</style>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<!-- 현 로그인 정보 -->
<h1>현로그인 정보</h1>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.m_idx"/>
<sec:authentication property="principal.name"/>
<sec:authentication property="principal.photo"/>
<sec:authentication property="principal.m_type"/>
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="myname">
		<sec:authentication property="principal.name"/>
	</c:set>
	<c:set var="myphoto">
		<sec:authentication property="principal.photo"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>

<c:forEach items="${requestGroup}" var="rgroup">

<div class="card">
  <div class="card-header">
        게시글 고유번호 : ${rgroup.post_idx}
	게시글 타이틀 : ${rgroup.post_nm}
	게시글 생성일자 : ${rgroup.post_regdate}
	게시글 카테고리 : ${rgroup.cat_nm}
  </div>
  <div class="card-body">
  	<c:forEach items="${rgroup.list}" var="member" begin="0" end="3">
  			<span><img src="${pageContext.request.contextPath}/resources/files/member/${member.m_photo}" class="m_photo"></span>
  	</c:forEach>
  	<c:if test="${rgroup.overfive eq 'Y'}">
			<img src="${pageContext.request.contextPath}/resources/files/member/threedots.png" class="m_photo">
	</c:if>
  </div>
  <div class="card-footer">
	<c:if test="${mytype eq 'mentee'}">
		<a class="btn btn-outline-success" id="rqMember" href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}">제안한 멘토보기</a>
	</c:if>
	<c:if test="${mytype eq 'mentor'}">
		<a class="btn btn-outline-success" id="rqMember" href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}">제안한 멘티보기</a>
	</c:if>
	
  </div>
</div>

</c:forEach><br><br>

<script>





</script>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>