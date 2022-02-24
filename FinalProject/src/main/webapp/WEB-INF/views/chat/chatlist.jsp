<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
         <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>채팅목록</title>
</head>
<body>

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

<div class="gw">
		
<!-- 채팅목록 가져오기 -->
	<div class="chatRoomList">
	<table>
	<c:forEach items="${list}" var ="list" >
			
				<tr>
				<c:set var="matchYN">${list.match_yn}</c:set>
				<c:if test="${matchYN eq 'Y'}"><td>매칭 성공</td></c:if>
				<c:if test="${matchYN eq 'N'}"><td>매칭 전</td></c:if>
					<td>매칭 여부 : ${list.match_yn}</td>
					<td>회원 번호 : ${list.reciever_idx}</td>
					<td>회원 이름 : ${list.memberInfo.m_nm}</td>
					<td>회원 사진 : ${list.memberInfo.m_photo}</td>
					<td>카테고리 이름 : ${list.cat_nm}</td>
					<td>카테고리 타입 : ${list.cat_type}</td>
					<td>매칭 고유번호 : ${list.match_idx}</td>
					
					<td>
						<!-- <button type="button" id="intoChat">이사람과채팅하기ajax</button> -->
						<a href="${pageContext.request.contextPath}/chat/chatroom?myidx=${list.sender_idx}&matchidx=${list.match_idx}&reciever=${list.reciever_idx}">이사람과 채팅하기</a>
					</td>
				</tr>
			
	</c:forEach>
	</table>
	</div>
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>

	
</body>
</html>