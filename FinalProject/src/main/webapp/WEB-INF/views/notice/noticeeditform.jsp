<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>공지사항수정</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<h1>공지사항 수정 폼입니다.</h1>

<form>
	<input type="text" name="notice_title" placeholder="제목 입력" value="${noticeContent.notice_title}"><br>
	<input type="text" name="notice_content" placeholder="내용 입력" value="${noticeContent.notice_content}"><br>
	<input type="hidden" name="notice_idx" value="${noticeContent.notice_idx}">
	<sec:authorize access="hasRole('ADMIN')">
	<input type="button" value="수정" id="editProcessbtn">
	<input type="button" value="취소" id="cancelbtn">
	</sec:authorize>	
</form>
	<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
<script>

$(document).ready(function(){
	
	$('#editProcessbtn').on('click',function(){
		

		$.ajax({
			
			url: '${pageContext.request.contextPath}/admin/notice/edit',
			type:'POST',
			// 보낼 data : form 태그 내에 있는 모든 name 속성 요소의 값을 파라미터로 만들어줌
			data: $('form').serialize(),
			success: function(data){
				if(data==1){
					alert('정상적으로 수정되었습니다');
					
					location.href="${pageContext.request.contextPath}/notice/content?notice_idx=${noticeContent.notice_idx}&selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
				}else{
					alert('오류가 발생하였습니다. 잠시 후 다시 시도하세요');
				}
			},
			error: function(data){
				console.log(data);
			}
		})
	})
	
	$('#cancelbtn').click(
	      	function(){
	      	location.href="${pageContext.request.contextPath}/notice?selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
	      	}
		     );
})
</script>
</html>