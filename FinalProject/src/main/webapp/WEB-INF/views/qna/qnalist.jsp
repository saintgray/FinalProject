<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
@media(max-width: 750px){
	.subinfo{
	display: none;
	}
}

#listTable{
	border-collapse: separate;
	border-spacing: 0 30px;
	text-align: center;
}
.indexes{
	outline : 1px solid rgb(123,123,123);
	background : rgb(197,197,197);
}
.pageswip{

	    font-size: 30px;
	    cursor: pointer;
}
.pageNum{
	line-height: 36px;
	
}
.pageNum:hover{
	text-decoration: none;
}
</style>
<title>QNA</title>
</head>
<body>
<div class="gw">
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
	
	<div class="d-flex flex-column justify-content-center" id="globalwrap">
	<h1 class="mx-5 banner">1대1문의 리스트</h1>
	<table class="mx-auto" id="listTable">
		
	<tr class="indexes">
		<td>번호</td>
		<td>제목</td>
		<td>등록일</td>
	</tr>
		<c:forEach var="item" items="${pageView.qnaList}">
			<tr class="my-5">
				<td><span class="px-5">${item.qna_idx}</span></td>
				<td><a class="px-5" href="${pageContext.request.contextPath}/qna/content?qna_idx=${item.qna_idx}&selectPage=${param.selectPage}&numOfQnaPerPage=${param.numOfQnaPerPage}">${item.qna_title}</a></td>
				<td><span class="px-5">${item.qna_regdate}</span></td>
			</tr>			
		</c:forEach>
	</table>
	
		<!-- 페이지 숫자 출력 영역 ----------------------------------------------------->
		
		<div class="d-flex justify-content-center my-5">
		
			<c:if test="${pageView.curPageIndex gt 0}">
				<i class="bi bi-caret-left pageswip" id="prev"></i>
			</c:if>
			
			<c:forEach begin="${pageView.numOfPagePerPage*(pageView.curPageIndex)+1}" end="${(pageView.numOfPagePerPage*(pageView.curPageIndex)+1)+(pageView.numOfPagePerPage-1)}" var="pnum">
			
				<c:if test="${pnum le pageView.totalPage}">
					<c:if test="${pnum eq pageView.selectPage}">
						<span class="mx-2 pageNum btn btn-warning">${pnum}</span>
					</c:if>
					<c:if test="${pnum ne pageView.selectPage}">
						<a class="mx-2 pageNum btn btn-grey" href="${pageContext.request.contextPath}/qna/list?selectPage=${pnum}&numOfQnaPerPage=5">${pnum}</a>
					</c:if>
				</c:if>
				
			</c:forEach>
			
			
			<fmt:parseNumber var="index" integerOnly="true" value="${pageView.totalPage/10}"/>
			<c:if test="${pageView.curPageIndex lt index}">
				<i class="bi bi-caret-right pageswip" id="next"></i>
			</c:if>
		
		</div>
		
		<!--------------------------------------------------------------------->
		
		
	</div>
	
	
	
	
	


<%@ include file="/WEB-INF/views/layout/footer.jsp"%>
</div>
</body>

<script>
	$('#prev').on('click',function(){
		
		if(${pageView.curPageIndex}>0){
			var selectPage=${pageView.numOfPagePerPage*(pageView.curPageIndex-1)+1};
			
			location.href='${pageContext.request.contextPath}/qna/list?selectPage='+selectPage+'&numOfQnaPerPage=5';	
		}
			
	})
	
	
	$('#next').on('click',function(){
		
		//console.log(Math.floor(${pageView.totalPage/10}));
		//console.log(${pageView.curPageIndex});
		if(Math.floor(${pageView.totalPage/10}) > ${pageView.curPageIndex}){
			var selectPage=${pageView.numOfPagePerPage*(pageView.curPageIndex+1)+1};
			location.href='${pageContext.request.contextPath}/qna/list?selectPage='+selectPage+'&numOfQnaPerPage=5';	
		}
		
		
	})


</script>
</html>