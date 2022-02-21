<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style>
	
	#editarea{
		margin-top: 150px;
		margin-bottom: 150px;
	}
</style>
<title>공지사항수정</title>
</head>
<body>

<div class="gw">
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div id="editarea" class="container">
<h1 class="banner">공지사항 수정</h1>

<%-- 	<input type="text" name="notice_title" placeholder="제목 입력" value="${noticeContent.notice_title}"><br>
	<input type="text" name="notice_content" placeholder="내용 입력" value="${noticeContent.notice_content}"><br>
	<input type="hidden" name="notice_idx" value="${noticeContent.notice_idx}"> --%>
	
	<input type="text" placeholder="제목" id="notice_title" value="${noticeContent.notice_title}" class="form-control input-group">
		
		
		<div class="notice_content">
			${noticeContent.notice_content}
		</div>
	
	<sec:authorize access="hasRole('ADMIN')">
	<button type="button" class="btn btn-general" id="editProcessbtn">수정</button>
	<button type="button" class="btn btn-danger" id="cancelbtn">취소</button>
	</sec:authorize>	

</div>
</div>

	<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
<script>

$(document).ready(function(){
	$('.notice_content').summernote({
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline', 'clear']],
		    ['font', ['strikethrough', 'superscript', 'subscript']],
		    ['fontsize', ['fontsize']],
		    /* ['color', ['color']], */
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
		    ['insert', ['link', 'picture', 'video']],
		  ],
		 
		 minHeight: 500,
		 maxHeight: 500,
         codemirror: {
        	 theme: 'monokai'
         },
         lang: 'ko-KR',
         placeholder: '내용'	
	})
	
	$('#editProcessbtn').on('click',function(){
		

		$.ajax({
			
			url: '${pageContext.request.contextPath}/admin/notice/edit',
			type:'POST',
			// 보낼 data : form 태그 내에 있는 모든 name 속성 요소의 값을 파라미터로 만들어줌
			data:{
				notice_title: $('#notice_title').val(),
				notice_content:$('.notice_content').summernote('code'),
				notice_idx:${param.notice_idx}
			},
			success: function(data){
				if(data==1){
					alert('정상적으로 수정되었습니다');
					
					//location.href="${pageContext.request.contextPath}/notice/content?notice_idx=${noticeContent.notice_idx}&selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
					history.go(-2);
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
	      	//location.href="${pageContext.request.contextPath}/notice?selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
	      	history.go(-2);
	      	});
})
</script>
</html>