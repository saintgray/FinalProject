<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
	.m_img{
		width:40px;
		height:40px;
		border-radius: 50%;
	}
	
	.article{
	padding: 20px 40px 0;
    border: 1px solid;
    border-radius: 6px;
	}
</style>
<title>회원정보보기</title>
</head>
<body>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<h1 class="mx-5 banner">회원정보</h1>
<div class="container">
	<div class="article">
	
	<h3>이메일: ${memberinfo.m_email}</h3>
	<h3>이름 : ${memberinfo.m_nm}</h3>
	<h3><img class="mx-2 m_img" src="${pageContext.request.contextPath}/resources/files/member/${memberinfo.m_photo}"></h3>
	<h3>회원 고유번호 : ${memberinfo.m_idx}</h3>
	<h3>가입 일자: ${memberinfo.m_regdate}</h3>
	<h3>탈퇴 일자 : ${memberinfo.m_quitdate}</h3>
	<h3>블랙리스트 유무 : ${memberinfo.m_blacklist}</h3>
	<h3>회원 신고 누적횟수 : ${memberinfo.reportCount}</h3>
	</div>
	
	<%-- <c:forEach var="item" items="${memberinfo.reportList}">
		<h1>신고자: ${item.m_nm}</h1>
		<h1>신고내용: ${item.report_content}</h1>
		<h1>채팅내용: ${item.message}</h1>
	
	</c:forEach> --%>
	<div class="d-flex flex-row flex-wrap justify-content-center my-5">
	<sec:authorize access="hasRole('ADMIN')">
		<c:set var="admin_idx">
			<sec:authentication property="principal.admin_idx"/>
		</c:set>
		
		
		    <button type="button" class="btn btn-general" id="listbtn">목록</button>
		    <button type="button" class="btn btn-danger" id="reportbtn">신고보기</button>
		   <%--  <c:if test="${m_idx eq memberinfo.m_idx}">
				<button type="button" class="btn btn-general" id="editbtn">수정</button>
				<button type="button" class="btn btn-danger" id="delbtn">삭제</button>	
			</c:if> --%>	
		
	</sec:authorize>
	</div>
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
<script>

    $(
  		function(){
  			
  			$('#listbtn').click(
		      	function(){
		      	
		      	location.href="${pageContext.request.contextPath}/admin/member/list?selectPage=${param.selectPage}&numOfMemberPerPage=${param.numOfMemberPerPage}";
		      	
		      	});
  			
  			$('#reportbtn').click(function(){
  				location.href="${pageContext.request.contextPath}/admin/reported/list?m_idx=${memberinfo.m_idx}";
  			})
  			  
  		})

</script>
</html>