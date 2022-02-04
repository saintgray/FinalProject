<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<%@include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>



<title>프로필 등록</title>
</head>
<body>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div class="container d-flex- flex-wrap flex-column justify-content-around gw" id="profileformwrap">

	<div class="banner">프로필 등록</div>
	
	<div class="summernote"></div>


</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
<script>
$(document).ready(function(){
	$('.summernote').summernote({
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline', 'clear']],
		    ['font', ['strikethrough', 'superscript', 'subscript']],
		    ['fontsize', ['fontsize']],
		    ['color', ['color']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']]
		  ],
		 height: 600,
         codemirror: {
             theme: 'monokai'
         },
         lang: 'ko-KR',
         placeholder: '자기소개를 입력해주세요'
         //minHeight: 600,
         //maxHeight: 600,
         //width: 900
		
	})
})

</script>

</html>