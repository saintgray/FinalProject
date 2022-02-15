<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>공지사항등록</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<h1>공지사항 등록 폼입니다.</h1>

<div>

<form>
<input type="text" name="notice_title" placeholder="제목 입력"><br>
<input type="text" name="notice_content" placeholder="내용 입력"><br>
<input type="button" value="등록" id="registerbtn">
</form>
</div>


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
<script>

$(document).ready(function(){
	
	$('#registerbtn').on('click',function(){
		

		$.ajax({
			
			url: '${pageContext.request.contextPath}/admin/notice/register',
			type:'POST',
			// 보낼 data : form 태그 내에 있는 모든 name 속성 요소의 값을 파라미터로 만들어줌
			data: $('form').serialize(),
			success: function(data){
				if(data==1){
					alert('정상적으로 등록되었습니다');
					location.href="${pageContext.request.contextPath}/notice?selectPage=1&numOfNoticesPerPage=5";
				}else{
					alert('오류가 발생하였습니다. 잠시 후 다시 시도하세요');
				}
			},
			error: function(data){
				console.log(data);
			}
		})
	})	
})
</script>
</html>