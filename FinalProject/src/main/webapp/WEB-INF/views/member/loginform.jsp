<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<script>

	$(document).ready(function(){
		
		$('#loginbtn').on('click',function(){
			var warningchk=false;
			if($('#m_email').val().length==0){
				$('#w_email').text('이메일을 입력하세요');
				
			}else if($('#m_pw').val().length==0){
				$('#w_pw').text('비밀번호를 입력하세요');
			}
			
			if($('#w_pw').val() || $('#w_email').val()){
				$('.warning').css('visibility','visible');
			}else{
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
	
	<div class="d-flex flex-wrap flex-row">
	
		<form action="${pageContext.request.contextPath}/member/login" method="post">
		<div>
			<input type="text" placeholder="이메일" name="username" id="m_email">
			<div id="w_email" class="warning"></div>
		</div>
		<div>	
			<input type="password" placeholder="비밀번호" name="password" id="m_pw">
			<div id="w_pw" class="warning"></div>
		</div>
			<button type="button" class="btn btn-general" id="loginbtn">로그인</button>
			
		</form>
	
	</div>
	
	

</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>