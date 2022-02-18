<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp"%>
<style>

#listTable{
	border-collapse: separate;
	border-spacing: 0 30px;
	text-align: center;
}

@media(max-width: 750px){
	.subinfo{
	display: none;
	}
}

#globalwrap{
	height: 100%;
}

.indexes{
	outline : 1px solid rgb(123,123,123);
	background : rgb(197,197,197);
}
#noticesearch{
	width: 500px;
}


</style>
<title>공지사항</title>
</head>
<body>

<div class="gw">
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>

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
		 
	<div class="d-flex flex-column junity-content-center my-4" id="globalwrap">	 
		 <h1 class="mx-5 banner">공지사항 리스트</h1>
	
		<table class="mx-auto" id="listTable">
		<tr class="py-2 indexes">
		<td>번호</td>
		<td>제목</td>
		<td>작성일</td>
		</tr>
			<c:forEach var="items" items="${notices.noticeList}">

				<tr class="my-5">
				<td><span class="mx-2 px-5">${items.notice_idx}</span></td>
				<td><a class="mx-2 px-5"
					href="${pageContext.request.contextPath}/notice/content?notice_idx=${items.notice_idx}&selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}">${items.notice_title}</a></td>
				<td><span class="mx-2 px-5">${items.notice_regdate}</span></td>
				</tr>
			</c:forEach>
		</table>
		
		<div class="d-flex justify-content-center my-5" style="position:relative">
			
				<div class="input-group inner" id="noticesearch">
			          <div class="input-group-prepend">
			            <img class="input-group-text" style="height: 100%" src="${pageContext.request.contextPath}/resources/files/server/icons/img_searchicon.svg">
			          </div>
			          <input id="searchbar" style="border-left: 0;" type="text" class="form-control" aria-label="Amount (to the nearest dollar)"
			            placeholder="검색">
			            
			          <sec:authorize access="hasRole('ADMIN')">
							<button type="button" class="btn btn-general" id="regnoticebtn">공지사항
								등록</button>
							<!-- button 안에 <a> 태그는 쓰지 않으므로 이 버튼을 눌렀을때 스크립트로 해당 url 로 들어가게끔 할 것 -->
					  </sec:authorize>
		        </div>
				
			
		
		</div>
		
		
		<div class="d-flex justify-content-center my-5">
		<c:forEach begin="1" end="${notices.totalPage}" var="pnum">
			<a class="mx-2" href="${pageContext.request.contextPath}/notice?selectPage=${pnum}&numOfNoticesPerPage=5">${pnum}</a>
		</c:forEach>
		</div>
		
		
	</div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp"%>
</body>
<script>
	$('#regnoticebtn')
			.on(
					'click',
					function() {
						location.href = "${pageContext.request.contextPath}/admin/notice/register?selectPage=${param.selectPage}&numOfNoticesPerPage=${param.numOfNoticesPerPage}";
					})
</script>

</html>