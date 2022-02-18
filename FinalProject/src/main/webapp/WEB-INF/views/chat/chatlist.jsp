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

<!-- 현 로그인 정보 -->
<h1>현로그인 정보</h1>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.m_idx"/>
<sec:authentication property="principal.m_type"/>
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>
myidx: ${myidx} myname : ${myname} myphoto : ${myphoto}$ mytype : {mytype}

	<!-- 채팅목록에서 선택시 채팅창으로 전환 -->
	
	<!-- 여기서 넘길 것 -->
	<!-- 내 로그인한 정보/idx type-->
	
	<!-- 여기서 받을 것 -->
	<!-- 매칭테이블 -->
	<!-- 상대회원의테이블 : 회원idx / 회원photo / 회원name /  -->
	<!-- 카테고리 : (받은제의의경우)내가 쓴 게시물의 카테고리 / (내가직접요청한경우)회원의 관심분야   -->
	<!-- 채팅테이블 : 최근 보낸  -->
	<!-- 지역테이블 : 회원 지역 -->
	
	<h2>채팅 목록</h2>
	
	<!-- 채팅목록 가져오기 -->
<table>

<c:forEach items="${list}" var ="list" >
		
			<tr>
				<td>매칭 여부 : ${list.match_yn}</td>
				<td>회원 번호 : ${list.m_idx}</td>
				<td>회원 이름 : ${list.m_nm}</td>
				<td>회원 사진 : ${list.m_photo}</td>
				<td>카테고리 이름 : ${list.cat_nm}</td>
				<td>카테고리 타입 : ${list.cat_type}</td>
				<td>매칭 고유번호 : ${list.match_idx}</td>
				
				<td>
					<!-- <button type="button" id="intoChat">이사람과채팅하기ajax</button> -->
					<a href="${pageContext.request.contextPath}/chat/chatroom?myidx=${myidx}&matchidx=${list.match_idx}&reciever=${list.m_idx}">이사람과 채팅하기</a>
				</td>
			</tr>
		
</c:forEach>

</table>

	
</body>
</html>