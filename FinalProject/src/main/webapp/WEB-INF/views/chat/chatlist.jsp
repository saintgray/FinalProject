<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
         <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>채팅목록</title>
<style>

	.chatlist-whole{
		width : 70%;
		margin : 0 auto;
		padding : 20px 8% 10px 8% ; 
	}
	.chatlist-title{
		margin : 60px 20px 30px 25px;
		font-size: 2.1em;
		font-weight: bold;
	}
	
	table{
		width: 100%;
		margin-bottom: 20px; 
	}
	td{
		 padding-left: 20px;
	}
	.matchYN{
		height : 40px;
		padding : 7px 20px 10px 15px;
		background-color: #FFD601;
	}
	.matchYNfont{
		font-size: 1.0em;
		font-weight: 500;
		padding-left: 10px;
		padding-right: 10px;
	}
	.m_photo{
		width:110px;
		height:110px;
		border-radius: 50%;
		margin: 15px 0px 0px 15px;
	}
	.recievernm{
		font-size: 1.8em;
		font-weight: bold;
	}
	.revievercat{
		font-size: 1.4em;
		font-weight: 500 ;
	}
	#goChat{
		width : 100px;
		height : 30px;
		float: right;
		margin: 0px 20px 15px 20px;
		font-size: 1.2em;
		font-weight: 500;
		background-color: #142B6F!important;
	}
	#goChat>a{
		color: #FFF;
	}
	
	
</style>
</head>
<body>

<div class="gw">

<%@include file="/WEB-INF/views/layout/header.jsp" %>

		<!-- 현 로그인 정보 -->
		<sec:authorize access="isAuthenticated()">
			<c:set var="myidx">
				<sec:authentication property="principal.m_idx"/>
			</c:set>
			<c:set var="mytype">
				<sec:authentication property="principal.m_type"/>
			</c:set>
		</sec:authorize>
		



	<div class="chatlist-whole">
		<div class="chatlist-title">채팅</div>
	<!-- 채팅목록 가져오기 -->
		<div>
			
			<c:forEach items="${list}" var ="list" >
				<table>

					<tr>
						<td><input type="hidden" class="recieveridx" value="${list.reciever_idx}"></td>
						<td><input type="hidden" class="matchidx" value="${list.match_idx}"></td>
					</tr>
					<tr>
						<td colspan="2" >
							<div class="matchYN">
							<c:if test="${list.match_yn eq 'Y'}"><span class="matchYNfont badge bg-success" style="background-color: #F84C0B!important">매칭 중</span></c:if>
							<c:if test="${list.match_yn eq 'N'}"><span class="matchYNfont badge bg-dark">매칭 전</span></c:if>
							</div>
						</td>
					</tr>
					<tr>
						<td rowspan="2" style="width: 140px;"><img src="${pageContext.request.contextPath}/resources/files/member/${list.memberInfo.m_photo}" class="m_photo">
						<td class="recievernm">${list.memberInfo.m_nm}</td>
					</tr>
					<tr>
						<td class="revievercat">${list.cat_type} / ${list.cat_nm}</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="button" class="btn btn-primary float-end" id="goChat" style="height:40px;width:150px;">
								<a href="${pageContext.request.contextPath}/chat/chatroom?myidx=${list.sender_idx}&matchidx=${list.match_idx}&reciever=${list.reciever_idx}">채팅하기</a>
							</button>	
						</td>
					</tr>
					
				</table>	
					
			</c:forEach>
			
		
		</div>
	</div>
</div>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>


</body>
</html>