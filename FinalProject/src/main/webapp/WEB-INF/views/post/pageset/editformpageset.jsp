<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>


<script>

function selectCategory(idx){
	
	var interest = idx;

	console.log(interest);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/category/list',
		type: 'GET',
		data: interest,
		datatype: 'json',
		success: function(data){
			console.log(data.length);
			
			/* if(data.length>0){
				
				
			}
			
			var html='<select id="childCategory" name="cat_idx">';
			$(data).each(function(index, items){
				console.log(items.cat_idx);
				console.log(items.cat_nm);
				
				html+='<option value="'+items.cat_idx+'">'+items.cat_nm+'</option>';
				
			})
			html+="</select>"
			
			console.log(html);
			
			$('#category').html(html);
			
			
			$(data).each(function(index, items){
				console.log(items.cat_idx);
				console.log(items.cat_nm);
				
				html+= '<div class="input-group justify-content-center my-4">\r\n';
					html+= '<label for="interest'+items.cat_idx+'">\r\n';
						html+='<img src="${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg">\r\n';
						html+='<span class="hidden">'+items.cat_idx+'</span>\r\n';
						html+='<span>'+items.cat_nm+'</span>\r\n';
					html+='</label>\r\n';
					html+='<input type="checkbox" id="interest'+items.cat_idx+'" name="interest" class="interest hidden" value="'+items.cat_idx+'">\r\n';
				html+='</div>\r\n'; */
			
			
		},
		error: function(data){
			console.log(data);
		}
	});
	
}

// 파일업로드 관련 : 용량 제한, 확장자 제한
function checkExtension(fileName, fileSize){
	
	var regex = new RegExp("(.*?)\.(jpg|jpeg|png|PNG|bmp|pdf)$");
	var maxSize = 5242880; // 5MB : 1024*1024*5
	
	if(fileSize > maxSize){
		alert("5MB 이하의 파일만 업로드할 수 있습니다.");
		return false;
	}
	
	if(!regex.test(fileName)){
		alert("이미지 또는 PDF 파일만 업로드할 수 있습니다.");
		return false;
	}
	
	return true;
	
}

$(document).ready(function(){	
	
	$('#content').summernote({
		toolbar: [
		    
		    ['style', ['bold', 'italic', 'underline', 'clear']],
		    ['font', ['strikethrough', 'superscript', 'subscript']],
		    ['fontsize', ['fontsize']],
		    
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
		    ['insert', ['link', 'picture', 'video']],
		  ],
		 height: 600,
         codemirror: {
        	 theme: 'monokai'
         },
         lang: 'ko-KR',
         placeholder: '내용을 입력하세요.'
         

	});
	
	/* 글 수정시 summernote에 글내용 추가 */
    $('#content').summernote('editor.insertText', "${editRequest.post_content}");
	
	
});

</script>