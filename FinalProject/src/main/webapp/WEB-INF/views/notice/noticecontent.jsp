<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>공지사항</title>
</head>
<body>

<%@include file="/WEB-INF/views/layout/header.jsp" %>

<div class="container gw">
	<h1> 공지사항 내용을 보여주는 jsp 입니다 </h1>
	<h1>제목 : ${content.notice_title}</h1>
	<h3>내용: ${content.notice_content}</h3>
	<h3>작성일 : ${content.notice_regdate}</h3>
	<h3>수정일  : ${content.notice_editdate}</h3>
	<h3>작성자: ${content.admin_nm}</h3>
	<h3>게시글 고유번호 : ${content.notice_idx}</h3>
	
	<sec:authorize access="hasRole('ADMIN')">
		<c:set var="admin_idx">
			<sec:authentication property="principal.admin_idx"/>
		</c:set>
		
		<div class="d-flex flex-row flex-wrap justify-content-center">
		    <button type="button" class="btn btn-general" id="listbtn">목록</button>
		    <c:if test="${admin_idx eq content.admin_idx}">
				<button type="button" class="btn btn-general" id="editbtn">수정</button>
				<button type="button" class="btn btn-danger" id="delbtn">삭제</button>	
			</c:if>	
		</div>
	</sec:authorize>
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

<script>

    $(
  		function(){
  			
  			$('#listbtn').click(
		      	function(){
		      	
		      	location.href="${pageContext.request.contextPath}/notice?selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
		      	}
  		     );
  			
  			$('#editbtn').click(function(){
  				// 수정하는 폼을 보여줌
  				// 공지사항의 수정은 관리자만 할 수 있다
  				location.href="${pageContext.request.contextPath}/admin/notice/edit?notice_idx=${content.notice_idx}&selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
  				
  			})
  			
  			$('#delbtn').click(function(){
  				
  				if(!confirm("삭제 하시겠습니까?")){
  					return false;
  				}else{
  					//location.href="${pageContext.request.contextPath}/admin/notice/delete?notice_idx=${content.notice_idx}&selectPage=${param.selectPage}";
  					var data={
  							notice_idx:${content.notice_idx}
  					}
  					
  					$.ajax({
  						
  						url: '${pageContext.request.contextPath}/admin/notice/delete',
  						type: 'POST',
  						data: data,
  						success:function(data){
  							if(data==1){
  								alert('정상적으로 삭제되었습니다.');
  								location.href="${pageContext.request.contextPath}/notice?selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
  							}else if(data==0){
  								alert('오류가 발생했습니다. 잠시 후 다시 시도하세요');
  							}
  						},
  						error:function(data){
  							console.log(data);
  						}
  						
  					})
  				
  				}

  			})
  		})

</script>
</html>