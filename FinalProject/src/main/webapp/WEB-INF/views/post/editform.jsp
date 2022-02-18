<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
	<c:set var="idx">
	   <sec:authentication property="principal.m_idx" />
	</c:set>
	<c:set var="type">
	   <sec:authentication property="principal.m_type" />
	</c:set>
</sec:authorize>

<c:if test="${idx ne editRequest.m_idx}">
<script>
alert('수정 권한이 없습니다.');
history.go(-1);
</script>
</c:if>

<c:if test="${idx eq editRequest.m_idx}">
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

<!-- 프로필 출력 : 멘토일 때에만 -->
	<c:if test="${type eq 'mentor'}">
		<div class="d-flex flex-column my-3">
			<div class="descript my-1 ms-0 me-1">프로필</div>
			<c:if test="${writerProfile ne null}">
				<table>
					<tr>
						<td rowspan="2"><img
							src="${pageContext.request.contextPath}/resources/files/member/${writerProfile.m_photo}"
							height="50"></td>
						<td>${writerProfile.m_nm}/ ${writerProfile.loc_nm}</td>
					</tr>
					<tr>
						<td colspan="2">${writerProfile.line}</td>
					</tr>
				</table>
			</c:if>
			
			<c:if test="${writerProfile eq null}">
			글쓴이의 프로필 정보가 없습니다. 프로필 등록이 필요합니다.
			</c:if>
		</div>
	</c:if>

<!-- 게시글 작성 -->
<div>

<form role="form" method="post" enctype="multipart/form-data" id="writePost">

<input type="hidden" name="m_idx" value="${idx}">
<input type="hidden" name="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
<input type="hidden" name="post_idx" value="${editRequest.post_idx}">
<br>

<!-- 제목 -->
<div class="input-group mb-3">
	<span class="input-group-text" id="inputGroup-sizing-default">제목</span>
	<input type="text" class="form-control" name="post_nm" id="post_nm" value="${editRequest.post_nm}"><br>
</div>

<!-- 내용 -->
<textarea name="post_content" id="content">${editRequest.post_content}</textarea> <br>

<!-- 카테고리 -->
선택된 분야 번호 : ${editRequest.cat_idx}
<input type="hidden" name="cat_idx" value="${editRequest.cat_idx}">
<br>

<input type="hidden" name="wanted" value="${type eq 'mentor'?'mentee':'mentor'}">
<input type="hidden" name="m_idx" value="${idx}">

<!-- 파일업로드 -->
<div>
	<input type="file" name="attachFile" id="attachFile" multiple>
<!-- 업로드한 파일 미리보기 -->
	<div id="filePreview">
	</div>
</div>

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
</c:if>