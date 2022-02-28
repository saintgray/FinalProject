<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp"%>
<style>
@media ( max-width : 750px) {
	.subinfo {
		display: none;
	}
}

#listTable {
	border-collapse: separate;
	border-spacing: 0 30px;
	text-align: center;
	min-width: 600px;
}

.indexes {
	outline: 1px solid rgb(123, 123, 123);
	background: rgb(197, 197, 197);
}

.pageswip {
	font-size: 30px;
	cursor: pointer;
}

.pageNum {
	line-height: 36px;
}

.pageNum:hover {
	text-decoration: none;
}

#globalwrap {
	margin-top: 150px;
}
</style>
<title>QNA</title>
</head>
<body>
	<div class="gw">
		<%@ include file="/WEB-INF/views/layout/header.jsp"%>

		<div id="globalwrap">


			<h1 class="mx-5 banner">
				<a href="${pageContext.request.contextPath}/qna/list">1대1문의</a>
			</h1>

			<div class="d-flex flex-row"
				style="border-top: 1px solid rgb(195, 195, 195)">

				<%@ include file="/WEB-INF/views/layout/aside.jsp"%>


				<div class="flex-grow-1">
					<table class="mx-auto" id="listTable">

						<tr class="indexes">
							<td>번호</td>
							<td>제목</td>
							<td>등록일</td>
						</tr>
						<c:forEach var="item" items="${pageView.qnaList}">

							<tr class="my-2 qnaRow">
								<td><span class="px-5">${item.qna_idx}</span></td>
								<td><a class="px-5"
									href="${pageContext.request.contextPath}/qna/content?qna_idx=${item.qna_idx}">${item.qna_title}</a>
									<span class="qna_idx d-none">${item.qna_idx}</span></td>
								<td><span class="px-5">${item.qna_regdate}</span></td>
							</tr>

							<c:if test="${not empty item.replyInfo}">
								<tr style="background-color: rgb(210, 210, 210)">
									<td colspan="3">
										<div class="d-flex flex-row ps-5">
											<i class="bi bi-arrow-return-right"></i> 
											<span class="d-none">${item.replyInfo.reply_idx}</span>
											<span class="mx-2 reply"><strong>[답변]</strong> : ${item.qna_title}</span> 
											<span class="mx-2">${item.replyInfo.reply_regdate}</span>
											<span class="mx-2">${item.replyInfo.admin_nm}</span>
										</div>
									</td>
								</tr>
							</c:if>



						</c:forEach>
					</table>

					<!-- 페이지 숫자 출력 영역 --------------------------------------------------- -->

					<div class="d-flex justify-content-center my-5">

						<c:if test="${pageView.curPageIndex gt 0}">
							<i class="bi bi-caret-left pageswip" id="prev"></i>
						</c:if>

						<c:forEach
							begin="${pageView.numOfPagePerPage*(pageView.curPageIndex)+1}"
							end="${(pageView.numOfPagePerPage*(pageView.curPageIndex)+1)+(pageView.numOfPagePerPage-1)}"
							var="pnum">

							<c:if test="${pnum le pageView.totalPage}">
								<c:if test="${pnum eq pageView.selectPage}">
									<span class="mx-2 pageNum btn btn-warning">${pnum}</span>
								</c:if>
								<c:if test="${pnum ne pageView.selectPage}">
									<a class="mx-2 pageNum btn btn-grey"
										href="${pageContext.request.contextPath}/qna/list?selectPage=${pnum}&numOfQnaPerPage=5">${pnum}</a>
								</c:if>
							</c:if>

						</c:forEach>


						<fmt:parseNumber var="index" integerOnly="true"
							value="${pageView.totalPage/10}" />
						<fmt:parseNumber var="indexRest" integerOnly="true"
							value="${pageView.totalPage%10}" />


						<c:if
							test="${((pageView.curPageIndex lt index-1)) or ((indexRest gt 0) and (pageView.curPageIndex+1 eq index))}">

							<i class="bi bi-caret-right pageswip" id="next"></i>
						</c:if>


					</div>

				</div>

			</div>

		</div>



	</div>
	<%@ include file="/WEB-INF/views/layout/footer.jsp"%>
</body>

<script>
	$(document).ready(function(){
		
		$('.reply').on('click',function(){
			
			var replyIdx=$(this).prev().text();
			
			location.href='${pageContext.request.contextPath}/reply/content?reply_idx='+replyIdx;
			
			
		})
		
		$('#sm_qna').css('color','#FCA106');
		
		
		$('#prev').on('click',function(){
			
			if(${pageView.curPageIndex}>0){
				let selectPage=${pageView.numOfPagePerPage*(pageView.curPageIndex-1)+1};
				
				location.href='${pageContext.request.contextPath}/qna/list?selectPage='+selectPage+'&numOfQnaPerPage=5';	
			}
				
		})
		
		
		$('#next').on('click',function(){
			
			//console.log(Math.floor(${pageView.totalPage/10}));
			//console.log(${pageView.curPageIndex});
			if(Math.floor(${pageView.totalPage/10}) > ${pageView.curPageIndex}){
				let selectPage=${pageView.numOfPagePerPage*(pageView.curPageIndex+1)+1};
				location.href='${pageContext.request.contextPath}/qna/list?selectPage='+selectPage+'&numOfQnaPerPage=5';	
			}
			
			
		})
		
		
	})



</script>
</html>