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
				$('#w_email').text('*이메일을 입력하세요').css('visibility','visible');
				invailed=true;
				
			}else if($('#m_email').val().indexOf('@')<0){
				$('#w_email').text('*올바른 이메일 형식을 입력하세요').css('visibility','visible');
				invailed=true;
			}
			if($('#m_pw').val().length==0){
				$('#w_pw').text('*비밀번호를 입력하세요').css('visibility','visible');
				invailed=true;
			}
			
			
			
			
			if(!invailed){
				$('#insertarea').append($('<img src="${pageContext.request.contextPath}/resources/files/server/icons/loading/loading.svg" id="loading">'));
				$('form').submit();
			}
		})
		
		
		$('#m_email, #m_pw').on('focus',function(){
			$(this).siblings('.warning').css('visibility','hidden');
			$('#auth_warning').text('');
		})
		
		
		$('input').on('keydown',function(e){
			
			
			if(e.keyCode==13){
				
				
				$('#loginbtn').trigger('click');
			}
		})
		
		// forgetMe 
		///////////////////////////
		$('#forgetMe').on('click',function(){
			location.href="${pageContext.request.contextPath}/findaccount";	
		})
		
	})
</script>


<title>로그인</title>
</head>
<body>


<div class="gw">
	<%@include file="/WEB-INF/views/layout/header.jsp" %>
	<div class="container" id="loginglobalwrap">
		<div class="banner text-center">
		<img src="${pageContext.request.contextPath}/resources/files/server/bannerimg/logo.svg">
		</div>
		<div class="container d-flex flex-wrap flex-column justify-content-center p-2" id="insertarea">
		
			<form action="${pageContext.request.contextPath}/member/login" method="post">
				
				<div class="my-4">
					<input type="text" class="form-control" placeholder="이메일" name="username" id="m_email" value='<c:out value="${insertedEmail}"></c:out>'>
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
					<c:if test="${msg ne null}">
				
						${msg}
					
					</c:if>
				</div>
				
				
				
				<div class="my-2" id="btnarea">
					<button type="button" class="btn btn-general" id="loginbtn">로그인</button>
				</div>	
				
				
				<!-- <input type="checkbox" name="remember-me">자동로그인 -->
				
			</form>
			
		</div>
		
		
	
	</div>
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>