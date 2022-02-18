<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>받은제의 그룹으로 보여지는 곳</title>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<!-- 받은 제의 그룹으로 나오기 -->


<!-- 임시 테스트  -->
<c:forEach items="${requestGroup}" var="rgroup">
<tr>
<br>
--그룹리스트
<br>
<td>게시글 고유번호 : ${rgroup.post_idx}</td><br>
<td><a href="${pageContext.request.contextPath}/post/requestpost?postidx=${rgroup.post_idx}">게시글 타이틀 : ${rgroup.post_nm}</a></td><br>
<td>게시글 생성일자 : ${rgroup.post_regdate}</td><br>
<td>게시글 요청대상 : ${rgroup.wanted}</td><br>
<td>게시글 카테고리 : ${rgroup.cat_nm}</td><br>
</tr>
<br>
--멤버리스트
<br>
<td><c:forEach items="${rgroup.list}" var="member">
						<tr><br>
							<td>매칭 고유번호 : ${member.match_idx}</td><br>
							<td>게시글 고유번호 : ${member.post_idx}</td><br>
							<td>회원 고유번호 : ${member.m_idx}</td><br>
							<td>회원 이름 : ${member.m_nm}</td><br>
							<td>회원 사진 : ${member.m_photo}</td><br>
							<td>매칭 여부 : ${member.match_yn}</td><br>
						</tr>
					</c:forEach>

	</c:forEach><br><br>
	

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>