<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
input{
display: block;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
	<form>
		<input type="text" name="m_email" placeholder="아이디">
		<input type="password" name="m_password" placeholder="비밀번호">
		<input type="text" name="m_nm" placeholder="이름">
		<input type="selectbox" name="interest" value="음악">
		<input type="selectbox" name="interest" value="미술">
		<input type="selectbox" name="interest" value="요리">
		<input id="chk_email" type="button" value="이메일 중복확인">
		<input id="testregister" type="button" value="회원등록">
	</form>
</body>
<script>
	$(document).ready(function(){
		
		$('#testregister').on('click',function(){
			
			var infos=$(form).serialize;
			
			$.ajax({
				url:"${pageContext.request.contextPath}/register",
				data: infos,
				type: 'POST',
				success: function(data){
					alert(data);
				},
				error: function(data){
					alert(data);
				}
				
			})
			
		})
		
		$('#chk_email').on('click',function(){
			
			var infos={
					m_email:$('input[name=m_email]').val() 		
			}
			
			
			$.ajax({
				url:"${pageContext.request.contextPath}/chk_email",
				data : infos,
				type: 'POST',
				success: function(data){
					alert(data);
					
				},
				error: function(data){
					alert(data);
				}
				
			})
		})
		
	})

</script>
</html>