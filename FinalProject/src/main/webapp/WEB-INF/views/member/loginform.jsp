<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/loginform.css">
<script>

	$(document).ready(function(){
		
		$('#loginbtn').on('click',function(){
			var invailed=false;
			if($('#m_email').val().length==0){
				$('#w_email').text('이메일을 입력하세요').css('visibility','visible');
				invailed=true;
				
			}
			if($('#m_pw').val().length==0){
				$('#w_pw').text('비밀번호를 입력하세요').css('visibility','visible');
				invailed=true;
			}
			
			
			
			
			if(!invailed){
				$('#insertarea').append($('<img src="${pageContext.request.contextPath}/resources/files/server/icons/loading/loading.svg" id="loading">'));
				$('form').submit();
			}
		})
		
		
		$('#m_email, #m_pw').on('focus',function(){
			$(this).siblings('.warning').css('visibility','hidden');
		})
	})
</script>

<title>로그인</title>
</head>
<body>

<%@include file="/WEB-INF/views/layout/header.jsp" %>

<div class="container" id="loginglobalwrap">

	<div class="banner">로그인</div>
	
	<div class="container d-flex flex-wrap flex-column justify-content-center" id="insertarea">
	
		<form action="${pageContext.request.contextPath}/member/login" method="post">
			
			<div class="my-4">
				<input type="text" class="form-control" placeholder="이메일" name="username" id="m_email">
				<div id="w_email" class="warning">
				</div>
			</div>
			<div class="my-4">	
				<input type="password" class="form-control" placeholder="비밀번호" name="password" id="m_pw">
				<div id="w_pw" class="warning">
				</div>
			</div>
			<div class="my-2" id="btnarea">
				<button type="button" class="btn btn-general" id="loginbtn">로그인</button>
			</div>	
			
			<!-- <input type="checkbox" name="remember-me">자동로그인 -->
			
		</form>
		
	</div>
	
	

</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>