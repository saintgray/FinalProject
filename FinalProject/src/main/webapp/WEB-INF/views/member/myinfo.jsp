<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>내 정보</title>
</head>
<body>

<div class="gw">

	<%@include file="/WEB-INF/views/layout/header.jsp" %>
	<h1>내 정보입니다.</h1>
	<h3>개인정보를 수정할 수 있습니다 (비밀번호, 별명, 관심사, 지역...)</h3>
	<h3>최 하단에 회원 탈퇴로 갈 수 있는 안내문이 위치합니다.</h3>
	
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>



</body>
</html>