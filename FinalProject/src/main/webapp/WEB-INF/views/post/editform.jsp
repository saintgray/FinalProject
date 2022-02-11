<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<%@ include file="/WEB-INF/views/post/pageset/editformpageset.jsp"  %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- Container -->
<div class="container">

<sec:authorize access="isAuthenticated()">
	<c:set var="idx">
	   <sec:authentication property="principal.m_idx" />
	</c:set>
	<c:set var="type">
	   <sec:authentication property="principal.m_type" />
	</c:set>
</sec:authorize>

<!-- 프로필 출력 -->
<div>
프로필 정보가 출력될 영역입니다.
</div>

<!-- 게시글 작성 -->
<div>

<form role="form" method="post" enctype="multipart/form-data" id="writePost">

<input type="hidden" name="m_idx" value="${idx}">
<input type="hidden" name="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
<input type="hidden" name="post_idx" value="${editRequest.post_idx}">
<br>

<!-- 제목 -->
<input type="text" name="post_nm" value="${editRequest.post_nm}" id="post_nm"> <br>

<!-- 내용 -->
<textarea name="post_content" id="content"></textarea> <br>

<!-- 카테고리 인덱스 -->
<!-- <select id="parentCategory" onchange="selectCategory(this.value)">
	<option value="">선택</option>
	<option value="1">음악</option>
	<option value="2">미술</option>
	<option value="3">요리</option>
</select> -->

<!-- <select name="cat_idx" id="cat_idx">
	<option value="8">실험용</option>
	<option value="9">실험용2</option>
</select> -->

선택된 분야 번호 : ${editRequest.cat_idx}
<input type="hidden" name="cat_idx" value="${editRequest.cat_idx}">
<br>

<input type="hidden" name="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
<input type="hidden" name="m_idx" value="${idx}">

<!-- 파일업로드 -->
<input type="file" name="attachFile" id="attachFile" multiple> 
<br>

<button type="reset">리셋</button> <button type="button" id="ajaxBtn">작성</button>

</form>

</div>

</div>

<script>

$(document).ready(function(){
	
    var formData = new FormData(document.getElementById('writePost'));
    
	/* var formObj = $("form[role='form']"); */
	
	/* $("#attachFile").on("change", function(e){
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
		}
		
	}); */

	$("#ajaxBtn").on("click", function(e){

		var post_nm = $('#post_nm').val();
	    var content = $('#content').summernote('code');
	    
	    formData.set("post_nm", post_nm);
	    formData.set("post_content", content);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/post/edit',
			type: 'post',
			data: formData,
			success: function(data){
				
				console.log(data);
			
				if(data.cnt==1){
					alert('글을 수정했습니다.');
					location.href='${pageContext.request.contextPath}/post/view?idx='+data.idx;
				} else {
					console.log('수정 실패');
				}
			},
			error: function(){
				console.log('통신 오류');
			},
			processData: false,
			contentType: false
		});
		
	});
	
	

	
	
	// 카테고리 선택 관련
	// https://huskdoll.tistory.com/497
	// https://golddigger.tistory.com/42
	
	
	
	 
})
</script>
</body>

</html>