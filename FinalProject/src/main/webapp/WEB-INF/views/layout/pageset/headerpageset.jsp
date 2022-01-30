<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	$(document).ready(function(){
		$('body').on('click','#register',function(){
			location.href="${pageContext.request.contextPath}/register";
			
		})
		
		$('body').on('click','#logo',function(){
			location.href="${pageContext.request.contextPath}/";
		})
		
	})

</script>