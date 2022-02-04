<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
	#profileformwrap{
		padding:10px;
	}
	.guide{
		margin-top:150px;
		text-align:  center;
	}
</style>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>



<title>프로필 등록</title>
</head>
<body>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div class="container d-flex- flex-wrap flex-column justify-content-around gw" id="profileformwrap">
	
	<span id="index">1</span>
	
	<div class="banner">프로필 등록</div>
	
	
	<div class="progress">
  		<div class="progress-bar bg-warning" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
	</div>
	
	
	<div class="container d-flex flex-column flex-wrap guide" id="line">
	
			<div class="subbanner">
				WHO AM I?
			</div>
			<div class="descript mb-5">
				멘티들에게 자신을 한 줄로 소개해보세요!
			</div>
			
			<div class="my-5 mx-auto">
				<input style="width: 50%" type="text" class="form-control" placeholder="" name="line">
			</div>
			
		
			<div class="d-flex flex-row justify-content-center my-5">
				<button type="button" class="btn btn-grey prev mx-4">이전</button>
				<button type="button" class="btn btn-general next mx-4">다음</button>
			</div>
	</div>
	
	
	
	
	
	
	
	<div class="summernote"></div>


</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
<script>
$(document).ready(function(){
	
	
	
	
	
	
	/* $('.summernote').summernote({
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
		
	}) */
})

</script>

</html>