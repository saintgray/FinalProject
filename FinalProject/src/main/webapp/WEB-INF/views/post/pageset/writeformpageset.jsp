<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>


<script>
let cat_idx;

function resetCategory(){
	$('#categoryInfos').html('');
	cat_idx=0;
		
	selectCategory();
}

function selectCategory(dom){
	
	var interest = $(dom).children('option:selected').val();

	$.ajax({
		url: '${pageContext.request.contextPath}/category/list',
		type: 'GET',
		data: {interest : interest},
		datatype: 'json',
		success: function(data){
			
			// remove all next Siblings		
			$(dom).parent().nextAll().remove();
			
			if(data.length==0){
				
				// 현재 선택한 interest 값을 cat_idx 에 저장한다.
				cat_idx = interest;
				console.log(cat_idx);
				
			}else{
			
				var html="";
				html+='<div class="selectarea mx-1">\r\n';
				html += '<select onchange="selectCategory(this)">\r\n';
				html += '<option value="">선택</option>\r\n';
				
				$(data).each(function(index, items){
					console.log(items.cat_idx);
					console.log(items.cat_nm);
					
					html += '<option value="'+items.cat_idx+'">'+items.cat_nm+'</option>';
				
				})
				html += '</select>\r\n';
				html+='</div>'
				
				$('#categoryInfos').append(html);
				console.log(html);
			
			}
			
		},
		error: function(data){
			console.log(data);
		}
	});
	
}

// 파일업로드 관련 : 용량 제한, 확장자 제한
function checkExtension(fileName, fileSize){
	
	// var parts = fileName.split('.');
	// var ext = parts[parts.length-1].toLowerCase();
	
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

// 파일업로드 관련 : 업로드 결과 미리보기
/* function showUploadResult(){
	
	
	if (inputFile[i].type.match('image.*')) { 
		// 이미지 파일일 경우 미리보기 만들기
		var filesAmount = inputFile.length; 
		for (i = 0; i < filesAmount; i++) { 
			var reader = new FileReader(); 
			reader.onload = function(event) { 
				$($.parseHTML('<img>')).attr('src', event.target.result).attr('height', '200px').appendTo($('#filePreview')); 
				} 
			reader.readAsDataURL(inputFile[i]); 
		}
	} else {
		// 이미지 파일이 아닐 경우
	}
} */

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
	
	// ROOT 카테고리의 인덱스인 30을 넣어 카테고리 검색 초기화
	selectCategory(30);	
        
    var formData = new FormData(document.getElementById('writePost'));
	
	$("#attachFile").on("change", function(e){
		console.log(e.target.files);
		var inputFile = e.target.files;
		
		if(inputFile.length == 0){
		    alert("파일이 없습니다.");
		    return;
		}
		
		for(var i=0; i<inputFile.length; i++){
			if(!checkExtension(inputFile[i].name, inputFile[i].size)){
				return false;
			}
			formData.append("fileList", inputFile[i]);
			
			// 첨부된 파일 목록으로 보여주기

			
			if (inputFile[i].type.match('image.*')) { 
				// 이미지 파일일 경우 미리보기 만들기
				var filesAmount = inputFile.length; 
				for (i = 0; i < filesAmount; i++) { 
					var reader = new FileReader(); 
					reader.onload = function(event) { 
						$($.parseHTML('<img>')).attr('src', event.target.result).attr('height', '200px').appendTo($('#filePreview')); 
						} 
					reader.readAsDataURL(inputFile[i]); 
				}
			} else {
				// 이미지 파일이 아닐 경우
			}
			
		}
		
		/*
		$.ajax({
			url: '${pageContext.request.contextPath}/post/uploadfile',
			type: 'post',
			data: inputFile,
			
		});
		*/
		
	});

	$("#submitBtn").on("click", function(e){

		var post_nm = $('#post_nm').val();
	    var content = $('#content').summernote('code');
	    /* var cat_idx = $('#cat_idx').val(); */
	    
	    formData.set("post_nm", post_nm);
	    formData.set("post_content", content);
	    formData.set("cat_idx", cat_idx);
		
 		/* key 확인하기 */
		for (let key of formData.keys()) {
			   console.log(key);
		}

		/* value 확인하기 */
		for (let value of formData.values()) {
		      console.log(value);
		}
		
		if(!cat_idx>0){
			alert('분야를 반드시 선택하셔야 합니다.');
			return;
		}
		
		$.ajax({
			url: '${pageContext.request.contextPath}/post/write',
			type: 'post',
			data: formData,
			success: function(result){
				
				console.log(result);
			
				if(result.cnt==1){
					alert('요청글을 등록하였습니다.');
					location.href='${pageContext.request.contextPath}/post/view?idx='+result.idx;
				} else {
					console.log('등록 실패');
				}
			},
			error: function(){
				console.log('통신 오류');
			},
			processData: false,
			contentType: false
		});
		
	});
	
});

</script>