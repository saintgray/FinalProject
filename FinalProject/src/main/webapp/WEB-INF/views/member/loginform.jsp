<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/loginform.css">
<title>로그인</title>
</head>
<body>


<div class="gw">
	<%@include file="/WEB-INF/views/layout/header.jsp" %>
	<div class="container" id="loginglobalwrap">
		<div class="banner text-center">
			로그인
		</div>
		<div class="container d-flex flex-wrap flex-column justify-content-center p-2" id="insertarea">
		
			<form action="${pageContext.request.contextPath}/member/login" method="post">
				
				<div class="my-4">
					<input type="text" class="form-control" placeholder="이메일" name="username" id="m_email" value='<c:out value="${error.insertedEmail}"></c:out>'>
					<div id="w_email" class="warning">
					</div>
				</div>
				<div class="my-4">	
					<input type="password" class="form-control" placeholder="비밀번호" name="password" id="m_pw">
					<div id="w_pw" class="warning">
					</div>
				</div>
				
				
				
				
				<div class="d-flex flex-row flex-wrap justify-content-between">
					<div class="form-check form-switch">
					  <input class="form-check-input" type="checkbox" role="switch" id="autoLogin" name="remember-me">
					  <label class="form-check-label" for="autoLogin">자동 로그인</label>
					</div>
					
					<div>
						<span id="forgetMe">비밀번호 찾기</span>
					</div>
				</div>		
				
				
				<!-- authentication failed message area -->
				<div id="auth_warning" class="warning text-center">
					
				
						${error.msg}
					
				
				</div>
				
				
				
				<div class="my-2" id="btnarea">
					<button type="button" class="btn btn-general" id="loginbtn">로그인</button>
				</div>	
				
				
				
				
			</form>
			
		</div>
		
		
	
	</div>
</div>

<h1></h1>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
<%@include file="/WEB-INF/views/member/pageset/loginformpageset.jsp" %>

</body>
</html>