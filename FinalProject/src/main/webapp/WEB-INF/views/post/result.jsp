<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result} eq 0">
<script>
alert('작성 실패');
history.go(-1);
</script>
</c:if>
<c:if test="${result} eq 1">

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

<!-- Container -->
<div class="container">

<!-- 프로필 출력 -->
<div>

</div>

<!-- 게시글 작성 -->
<div>

<input type="text" name="m_idx" value="${post.m_idx}">
<input type="text" name="wanted" value="${post.wanted}"><br>

<!-- 제목 -->
<input type="text" name="post_nm" value="${post.post_nm}"> <br>

<!-- 내용 -->
<textarea>${post.post_content}</textarea> <br>

<!-- 카테고리 인덱스 -->
<input type="text" value="카테고리 인덱스 : ${post.cat_idx}">

<br>

</div>

<!-- 파일업로드 -->
<div>
<input type="file" name="uploadFile" multiple>
</div>

</div>

</body>

<script>

$(document).ready(function(){
	
	// 카테고리 선택 관련
	// https://huskdoll.tistory.com/497
	// https://golddigger.tistory.com/42
	
	
	var formObj = $("form[role='form']");
	
/* 	// submit 클릭시 기본동작 막기
	$("button[type='submit']").on("click", function(e){
		
		e.preventDefault();
		console.log('글작성 버튼 클릭');
		
	}); */
	
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
 	
/* 	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: 'uploadFile',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
			}
		});
	});  */
	
});

</script>
</html>

</c:if>