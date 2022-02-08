<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
#noticeList span{
	padding: 0 10px;
}
</style>
<title>공지사항</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
		<h1>공지사항 페이지 입니다.</h1>
	
		<!--  List<Notice> 객체가 Model 에 notices 라는 포장지로 감싸져있음 -->
		<!--  c:forEach 태그의 items 속성은 List<Notice> 를 의미함 -->
		<!-- var 속성은 그 리스트 안의 Notice 를 의미함 -->
		
		<%-- 	<%
		NoticePageView  notice = (NoticePageView)request.getAttribute("notices");
		List<Notice> notices = notice.getNoticeList();
		for(int i =0 ; i < notices.size(); i++){
			Notice item = notices.get(i);
		%>
			<div class="d-flex flex-row flex-wrap" id="noticeList">
			<span><%=item.getNotice_idx()%></span> 
			<span><%=item.getNotice_title()%></span>
			</div>
		<% 
		}
		%> --%>
		
		
	    <%--  <%= request.getParameter("selectPage") %>
		${param.selectPage}
		 --%>
		 
		<c:forEach var="items" items="${notices.noticeList}">
			<div class="d-flex flex-row flex-wrap" id="noticeList">
				
				<span>${items.notice_idx}</span>
				<span><a href="${pageContext.request.contextPath}/notice/content?notice_idx=${items.notice_idx}&selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}">${items.notice_title}</a></span>
				<span>${items.notice_regdate}</span>		
			</div>
		</c:forEach>
		
		<c:forEach begin="1" end="${notices.totalPage}" var="pnum">
			<a href="${pageContext.request.contextPath}/notice?selectPage=${pnum}&numOfNoticesPerPage=5">${pnum}</a>
		</c:forEach>
		
		<sec:authorize access="hasRole('ADMIN')">

			<h3>관리자만 볼 수 있는 영역입니다</h3>
			<button type="button" class="btn btn-general" id="regnoticebtn">공지사항 등록</button>
			<!-- button 안에 <a> 태그는 쓰지 않으므로 이 버튼을 눌렀을때 스크립트로 해당 url 로 들어가게끔 할 것 -->
		</sec:authorize>
		
		
	
	
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>



</body>
<script>
	$('#regnoticebtn').on('click',function(){
		location.href="${pageContext.request.contextPath}/admin/notice/register";
	})
</script>

</html>