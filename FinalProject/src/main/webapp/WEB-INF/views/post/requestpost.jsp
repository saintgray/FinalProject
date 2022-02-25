<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<link rel="shortcut icon" href="#">
<title>받은 제의 리스트</title>
<style>
	
	/* 윗부분 */
	.post{
		background-color: #FFD601;
		height: 250px;
		width : 80%;
		margin : 0 auto;
		padding : 30px 30px 30px 30px; 
	}
	#goPostBtn{
		font-weight: 200;
		color : #E1DEE6;
		width: 100px;
		height: 30px;
		padding : 0px 6px 0px 6px;	
	}
	
	.post-regdate{
		float : right;
		color : #142B6F;
	}
	.post-title{
		font-size: 2.25em;
		font-weight: bold;
		margin : 40px 0px 20px 0px;
	}
	.post-cat{
		font-size: 1.8em;
		font-weight: 550;
	}
	
	/* 중앙부분 */
	.rqMemList{
		width : 80%;
		margin : 0 auto;
		padding : 10px 8% 10px 8% ; 
	}
	.memTable{
		border-collapse: separate;
  		border-spacing: 0 7px;
	}
	.oneMember{
		padding : 15px 0px 15px 0px;
		border-bottom: 1pt solid #E1DEE6;
	}
	.m_photo{
		width:110px;
		height:110px;
		border-radius: 50%;
	}
	.rqMname{
		padding : 0px 5px 0px 15px;
		font-size: 1.625em;
		font-weight: bold;	
	}
	#goChat{
		background-color: #142B6F!important;
		height: 30px;
		vertical-align: baseline;
		padding : 0px 6px 0px 6px;		
	}
	.rqp-footer{
		clear: both;
   		position: relative;
   		margin-top: -200px;
	}
</style>

</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- 현 로그인 정보 -->
<sec:authorize access="isAuthenticated()">
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>



<div class="post" id="rqpost">
	<button type="button" class="btn btn-light" id="goPostBtn">
		<a href="${pageContext.request.contextPath}/post/view?idx=${requestPost.post_idx}">작성 게시글 </a>
	</button>
	<span class="post-regdate">${requestPost.post_regdate}</span>
	<div class="post-title">${requestPost.post_nm}</div>
	<div class="post-cat">${requestPost.cat_nm}</div>
</div>

<div class="rqMemList">

	<c:forEach items="${requestPost.list}" var="member">
		<div class="oneMember">
		<table class="memTable">
		<tr>
			<td rowspan="3"><input type="hidden" class="matchidx" value="${member.match_idx}"> </td>
			<td rowspan="3" class="midxRow"><input type="hidden" id="rqM_idx" value="${member.m_idx}"/></td>
			<td rowspan="3">
				<img src="${pageContext.request.contextPath}/resources/files/member/${member.m_photo}" class="m_photo">
			</td>		
			<td>
				<span class="rqMname">${member.m_nm}</span>
				<button type="button" class="btn btn-light" id="goChat">
					<a style="color: #FFD601"  href="${pageContext.request.contextPath}/chat/chatroom?myidx=${myidx}&matchidx=${member.match_idx}&reciever=${member.m_idx}" >채팅 하기 </a>
				</button>
			</td>			
		</tr>
		<tr>
			<td>
				<c:if test="${mytype eq 'mentee'}">
					<span style="padding-left: 15px; font-weight: 500;">프로필소개 : ${member.line}</span>
				</c:if>
			</td>		
		</tr>
		<tr>	
			<td>후기 가져오면 좋을듯..?</td>		
		</tr>
		</table>
		</div>	
	</c:forEach>

</div>


<div class="rqp-footer">
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</div>
</body>

</html>