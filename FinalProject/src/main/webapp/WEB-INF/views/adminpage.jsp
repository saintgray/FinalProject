<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>관리자 페이지에 들어왔습니다!!!!</h1>
<h1>일반 회원이 이 페이지를 볼 수 있다면 이 서비스는 망합니다.</h1>

<h3>아이디 : <sec:authentication property="principal.username"/></h3>
<h3>비밀번호 : <sec:authentication property="principal.password"/></h3> 
<h3>권한 : <sec:authentication property="principal.authorities"/></h3>
<!-- User 를 상속받아 만든 허가증에 든 추가 정보들 --> 
<h3>사진 파일명 : <sec:authentication property="principal.photo"/></h3> 
<h3>이름 : <sec:authentication property="principal.name"/></h3> 
<h3>프로필</h3>
<img src="${pageContext.request.contextPath}/resources/files/member/<sec:authentication property="principal.photo"/>">
</body>
</html>