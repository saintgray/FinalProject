<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
	#wrap{
		margin-top:150px;
	}
	
	
	
	#contentarea{
		
		border-radius: 15px;
		background-color: #E1DEE6;
		min-height: 400px;
		
		padding: 20px 10px;
	
	}
	
	#contentarea::before{
		content:'';
		display: block;
		outline: 1px solid #E1DEE6;
		
	}
</style>
<title>답변</title>
</head>
<body>

<div class="gw">
	<%@include file="/WEB-INF/views/layout/header.jsp" %>

	<div class="container" id="wrap">
	
		<div>
			<h3><strong>[답변] : </strong>${content.qna_title}</h3>
			<div class="text-end fs-6 fw-light">답변일 : ${content.reply_regdate} -  ${content.admin_nm}</div>
		</div>
		
		
		<div id="contentarea">
		
		
		
			${content.reply_content}
		
		
		
		</div>
	
	
	
	
	
	
	
	</div>



</div>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>
		

</body>
</html>