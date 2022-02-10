<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>받은 제의 리스트</title>
</head>
<body>

<!-- 받은제의 그룹에서 선택한 게시글 -->

<tr>
<br>
--그룹리스트
<br>
<td>게시글 고유번호 : ${requestPost.post_idx}</td><br>
<td>게시글 타이틀 : ${requestPost.post_nm}</td><br>
<td>게시글 생성일자 : ${requestPost.post_regdate}</td><br>
<td>게시글 요청대상 : ${requestPost.wanted}</td><br>
<td>게시글 카테고리 : ${requestPost.cat_nm}</td><br>
</tr>
<br>
--멤버리스트
<br>
<td><c:forEach items="${requestPost.list}" var="member">
						<tr><br>
							<td>매칭 고유번호 : ${member.match_idx}</td><br>
							<td>게시글 고유번호 : ${member.post_idx}</td><br>
							<td>회원 고유번호 : ${member.m_idx}</td><br>
							<td>회원 이름 : ${member.m_nm}</td><br>
							<td>회원 사진 : ${member.m_photo}</td><br>
							<td>매칭 여부 : ${member.matched_yn}</td><br>
							<td>매칭 여부 : ${member.line}</td><br>
							<td><a href="${pageContext.request.contextPath}/post/chat?midx=${member.m_idx}&postidx=${requestPost.post_idx}">문의하기</a>
						</tr>
					</c:forEach>

	<br><br>



</body>
</html>