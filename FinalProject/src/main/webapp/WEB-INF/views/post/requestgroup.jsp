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
	.head-title{
		margin : 60px 20px 10px 20px;
		font-size: 2.1em;
		font-weight: bold;
	}
	.m_photo{
		width:40px;
		height:40px;
		border-radius: 50%;
		
	}
	#rqcard{
		width:450px;
		margin: 60px;
		float:left;
		border: 1px solid #142B6F;
	}
	.card-header{	 
		background-color: #FFD601!important;
	}
	.post-title{
		text-align: center;
		font-size: 1.75rem;
		font-weight: bold;
	}
	.post-date{
		margin-bottom: 5px;
		font-size: 0.9em;
	}
	.post-category{
		margin-right : 20px;
		float: right;
		font-size: 1.45em;
		font-weight: bold;
	}
	.rqg-whole{
		margin :0% 5% 0% 5%;
	}
	.photo-list{
		padding-left : 100px; 
	}
	#rqMember{
		width : 300px;
		margin : 10px 60px 10px 60px;
		heigth : 20px;
	}
	.card-body{
		padding : ,15px,,15px;
	}
	.rqg-footer{
		clear: both;
   		position: relative;
   		margin-top: -200px;
	}
</style>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<!-- 현 로그인 정보 -->

<sec:authorize access="isAuthenticated()">
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="myname">
		<sec:authentication property="principal.name"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>

<div class="rqg-whole">
	<div class="head-title">
		받은 제의
	</div>
	
	<div>
	<c:forEach items="${requestGroup}" var="rgroup">
	
		<div class="card" id="rqcard">
		  <div class="card-header">
		  	<div class="post-date">${rgroup.post_regdate}</div>
			<div class="post-title">${rgroup.post_nm}</div>
			<div class="post-category">	${rgroup.cat_nm}</div>
		  </div>
		  <div class="card-body">
		  <div class="photo-list">
		  	<c:forEach items="${rgroup.list}" var="member" begin="0" end="3">
		  			<span><img src="${pageContext.request.contextPath}/resources/files/member/${member.m_photo}" class="m_photo"></span>
		  	</c:forEach>
		  	<c:if test="${rgroup.overfive eq 'Y'}">
					<img src="${pageContext.request.contextPath}/resources/files/member/threedots.png" class="m_photo">
			</c:if>
		</div>
		  </div>
		  <div class="card-footer">
			<c:if test="${mytype eq 'mentee'}">
				<a class="btn btn-outline-success" id="rqMember" href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}"><strong>제안한 멘토보기</strong></a>
			</c:if>
			<c:if test="${mytype eq 'mentor'}">
				<a class="btn btn-outline-success" id="rqMember" href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}"><strong>제안한 멘티보기</strong></a>
			</c:if>
		  </div>
		</div>
	
	</c:forEach>
	</div>
	
</div>

<div class="rqg-footer">
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</div>

</body>
</html>