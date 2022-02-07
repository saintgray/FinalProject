<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>

	$(document).ready(function(){
		$('body').on('click','#register',function(){
			location.href="${pageContext.request.contextPath}/termsform";
			
		})
		
		$('body').on('click','#logo',function(){
			location.href="${pageContext.request.contextPath}/";
		})
		$('#loginTab').on('click',function(){
			location.href="${pageContext.request.contextPath}/member/loginform";
		})
		
		 $('#logoutbtn').on('click',function(){
  	        	  
  	        	  location.href="${pageContext.request.contextPath}/logout";
  	     })
  	   	  
  	   	$('.changeType').on('click',function(){
       	  
       	  location.href="${pageContext.request.contextPath}/member/switchType"
         })
         
        $('#manageprofile').on('click',function(){
        	
        	
        	location.href="${pageContext.request.contextPath}/member/profile/main"
        })
	
		
	})

</script>