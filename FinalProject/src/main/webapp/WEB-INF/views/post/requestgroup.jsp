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

	#body{
		height: 100%;
		width: 100%;
    	margin: 50px 0px 60px 0px;
    	min-height: 100%;
	}

	article{
		margin: 50px 0px 60px 0px;
		height: 100%;
	}
	#rqg-whole{
		width: 100%;
		padding : 0px 10px;
	}
	.head-title{
		margin : 0px 0px 50px;
		padding-left :40px; 
		font-size: 2.1em;
		font-weight: bold;
	}
	.ul-card{
		padding:0% 3%;
		height: 100%;
	}
	
	.ul-card>li{
		margin : 0% 4%;
		padding : 0px 10px 100px 10px; 
		position: relative;
		display: inline-block;
	}
	.li-card:nth-child(2n-1){
		float: left;
	}
	.li-card:nth-child(2n){
		float: right;
	}
	
	@media screen and (max-width: 1400px) {
		 .ul-card>li{
		 	max-width : 470px;
			margin-left: auto;
			margin-right: auto;
			padding : 0px 10px 80px 10px; 
			display: block;
		}
		
		.li-card:nth-child(2n-1){
			float: none;
		}
		.li-card:nth-child(2n){
			float: none;
		}
	}
	
	#rqcard{
		width: 430px;
		display: block;
		border: 1px solid #142B6F;
		
	}
	
	.card-header{	 
		background-color: #FFD601!important;
		height: 120px;
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
	
	.photo-list{
		padding-left : 80px; 

	}
	.m_photo{
		width:40px;
		height:40px;
		border-radius: 50%;
	}
	
	#rqMember{

		width : 300px;
		margin : 10px 50px 10px 50px;
		heigth : 20px;
	}
	.card-body{
		padding : 0px 15px 0px 15px;

	}
	#rqMember:hover{
		color:#FFF;
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


<div id="body">

<article>

<section class="container" id="rqg-whole">
	<div class="head-title">
		받은 제의
	</div>
	
	<ul class="ul-card">
	<c:forEach items="${requestGroup}" var="rgroup">
		<li class="li-card">
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
				<a class="btn btn-outline-success rqMember" href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}"><strong>제안한 멘토보기</strong></a>
			</c:if>
			<c:if test="${mytype eq 'mentor'}">
				<a class="btn btn-outline-success rqMember" href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}"><strong>제안한 멘티보기</strong></a>
			</c:if>
		  </div>
		</div>
		</li>
	</c:forEach>
	</ul>
	
</section>

</article>

</div>

<br><br>



<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

<script>
	$(document).ready(function(){
		
		$('.rqMember').on('click',function(){
			location.href='${pageContext.request.contextPath}/post/requestpost?postidx='+$(this).prev().text();
		})
		
	})

</script>
</html>