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
#listTable span{
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
		min-width: 500px;
	    margin-top: 100px;
   	    margin-bottom: 50px;
	}
/* 	#list{
		margin-top: 10px;
		margin-bottom: 10px;
	}
	 */
	 #listTable{
	 	border-collapse: separate;
    	border-spacing: 0 30px;
    	text-align: center;
	 }
	 .indexes{
 	    outline: 1px solid rgb(123,123,123);
    	background-color: rgb(197,197,197);
	 }
</style>
<title>회원관리</title>
</head>
<body>
<div class="gw">
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	<div class="d-flex flex-column" id="globalwrap">
		<h1 class="mx-5 banner">회원 리스트</h1>
		<table class="mx-auto" id=listTable>
			 <tr class="py-2 indexes">
				<td>사진</td>
				<td><span class="mx-2">번호</span></td>
				<td>아이디</td>
				<td><span class="mx-2">이름</span></td>
				<td><span class="mx-2 subinfo">가입일</span></td>
				<td><span class="mx-2 subinfo">탈퇴일</span></td>
				<td><span class="mx-2 subinfo">블랙리스트</span></td>
				<td><span class="mx-2 subinfo">신고</span></td>
			</tr>
			
			
			<c:forEach var="items" items="${member.list}">
				
				 <tr class="py-2">
					<td><img class="mx-2 m_img" src="${pageContext.request.contextPath}/resources/files/member/${items.m_photo}"></td>
					<td><span class="mx-2">${items.m_idx}</span></td>
					<td><a class="mx-2 justify-content-center" href="${pageContext.request.contextPath}/admin/member/info?m_idx=${items.m_idx}&selectPage=${param.selectPage}&numOfMemberPerPage=${param.numOfMemberPerPage}">${items.m_email}</a></td>
					<td><span class="mx-2">${items.m_nm}</span></td>
					<td><span class="mx-2 subinfo">${items.m_regdate}</span></td>
					<td><span class="mx-2 subinfo">${items.m_quitdate}</span></td>
					<td>
					<!-- items.m_blacklist의 값이 N일경우X Y일경우O로 출력 -->
						<span class="mx-2 subinfo">
							<c:if test="${items.m_blacklist eq 'N'}">
								X
							</c:if>
							<c:if test="${items.m_blacklist eq 'Y'}">
								O
							</c:if>	
						</span>
					</td>
					<td><span class="mx-2 subinfo">${items.reportCount}</span></td>
				</tr>
			
			</c:forEach>
		</table>
		<div class="d-flex justify-content-center my-5">
			<c:forEach begin="1" end="${member.totalPage}" var="pnum">
					<a class="mx-2" href="${pageContext.request.contextPath}/admin/member/list?selectPage=${pnum}&numOfMemberPerPage=5">${pnum}</a>
			</c:forEach>
		</div>
	</div>	
</div>	
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>