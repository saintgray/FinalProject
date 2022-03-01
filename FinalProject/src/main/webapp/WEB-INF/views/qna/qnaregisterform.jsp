<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style>


	#wrap{
	
		margin-top: 150px;
		margin-bottom: 50px;
	}
	
	#regBtn{
	
		width:100px;
	}
</style>
<title>문의글 등록</title>
</head>
<body>

<div class="gw">
	<%@include file="/WEB-INF/views/layout/header.jsp" %>
	
	
	<div class="container" id="wrap">
	
		<div class="d-flex flex-row">
		
		
			<%@include file="/WEB-INF/views/layout/aside.jsp" %>
			
			
			<div class="flex-grow-1 px-5">
			
			
				<div class="input-group mb-2">
				
					<span class="input-group-text">제목</span>
					<input type="text" class="form-control" id="title"/>
					
				</div>
				
				
				<div id="content">
				
					
				
				</div>
			
				
				<div class="text-center my-4">
					<button type="button" class="btn btn-general" id="regBtn">등록</button>
				</div>
				
			</div>
		
		
		</div>
	
	
	
	
	</div>

</div>



<%@include file="/WEB-INF/views/layout/footer.jsp" %>




</body>



<script>

$(document).ready(function(){
	
	$('#regBtn').on('click',function(){
		
		
		var data={
				
				qna_title:$('#title').val().trim(),
				qna_content:$('#content').summernote('code')
				
				
		}
		
		$.ajax({
			url:'${pageContext.request.contextPath}/member/qna/register',
			type:'POST',
			data: data,
			success:function(data){
				if(data==1){
					alert('문의글이 등록되었습니다');
					location.href='${pageContext.request.contextPath}/qna/list';
					
				}else{
					alert('오류가 발생했습니다 잠시 후 다시 시도하세요');
				}
			},
			error:function(data){
				console.log(data);
				alert('오류가 발생했습니다 잠시 후 다시 시도하세요');
			}
			
		})
		
		
		
		
	})
	
	
	$('#sm_qna').css('color','#FCA106');
	
	
	$('#content').summernote({
		toolbar : [
					['style',[
								'bold',
								'italic',
								'underline',
								'clear' 
							] 
					],
					['font',[
								'strikethrough',
								'superscript',
								'subscript' 
							] 
					],
				[ 'fontsize',
						[ 'fontsize' ] ],
				/* ['color', ['color']], */
				[
						'para',
						[ 'ul', 'ol',
								'paragraph' ] ],
				[ 'height', [ 'height' ] ],
				[
						'insert',
						[ 'link',
								'picture',
								'video' ] ], ],

		minHeight : 500,
		maxHeight : 500,
		codemirror : {
			theme : 'monokai'
		},
		lang : 'ko-KR',
		placeholder : '내용'
	})
	
	
	
	
})


</script>
</html>