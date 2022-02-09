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
@media(max-width: 720px){

	.subinfo{
	 display: none;
		
	}
	
	
}

	
	.m_img{
		width:40px;
		height:40px;
		border-radius: 50%;
	}
	#globalwrap{
		height:100%;
	}
/* 	#list{
		margin-top: 10px;
		margin-bottom: 10px;
	}
	 */
	 #listTable{
	 	border-collapse: separate;
    	border-spacing: 0 13px;
	 }
</style>
<title>회원관리</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<div class="d-flex flex-column justify-content-center" id="globalwrap">
	<table class="mx-auto" id=listTable>
		
		<c:forEach var="items" items="${member.list}">
			
			 <tr class="py-2">
				<td><img class="mx-2 m_img" src="${pageContext.request.contextPath}/resources/files/member/${items.m_photo}"></td>
				<td><span class="mx-2">${items.m_idx}</span></td>
				<td><a class="mx-2 justify-content-center" href="${pageContext.request.contextPath}/admin/member/info?m_idx=${items.m_idx}&selectPage=${param.selectPage}&numOfMemberPerPage=${param.numOfMemberPerPage}">${items.m_email}</a></td>
				<td><span class="mx-2">${items.m_nm}</span></td>
				<td><span class="mx-2 subinfo">${items.m_regdate}</span></td>
				<td><span class="mx-2 subinfo">${items.m_quitdate}</span></td>
				<td><span class="mx-2 subinfo">${items.m_blacklist}</span></td>
				<td><span class="mx-2 subinfo">신고 : ${items.reportCount}</span></td>
			</tr>
		
		</c:forEach>
	</table>
	<div class="d-flex justify-content-center my-5">
		<c:forEach begin="1" end="${member.totalPage}" var="pnum">
				<a class="mx-2" href="${pageContext.request.contextPath}/admin/member/list?selectPage=${pnum}&numOfMemberPerPage=5">${pnum}</a>
		</c:forEach>
	</div>
</div>		
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>