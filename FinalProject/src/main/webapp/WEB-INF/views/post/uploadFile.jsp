<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<input type="file" name="uploadFile" multiple>
<button id="uploadBtn">제출</button>

<script>

$(document).ready(function(){
	
	// 파일업로드 관련 
	var regex = new RegExp("(.*?)\.(jpg|jpeg|png|bmp|pdf)$");
	var maxSize = 5242880; // 5MB : 1024*1024*5
	
	function checkExtension(fileName, fileSize){
		
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
	
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/post/uploadFileResult',
			processData: false,
			contentType: false,
			data: formData,
			enctype : 'multipart/form-data',
			type: 'POST',
/* 			dataType: 'json', */
			success: function(data){
				console.log("Uploaded");
			}
		});
	});
	
});

</script>
</body>
</html>