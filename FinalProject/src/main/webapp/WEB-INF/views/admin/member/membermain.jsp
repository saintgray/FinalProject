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
#listTable span {
	padding: 0 10px;
}

@media ( max-width : 720px) {
	.subinfo {
		display: none;
	}
}

.m_img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
}

#globalwrap {
	height: 100%;
	min-width: 500px;
	margin-top: 100px;
	margin-bottom: 50px;
}
/* 	#list{
		margin-top: 10px;
		margin-bottom: 10px;
	}
	 */
#listTable {
	border-collapse: separate;
	border-spacing: 0 30px;
	text-align: center;
}

.indexes {
	outline: 1px solid rgb(123, 123, 123);
	background-color: rgb(197, 197, 197);
}

#membersearch {
	width: 500px;
}
#searchBtn{

cursor: pointer;
}
</style>
<title>회원리스트</title>
</head>
<body>
	<div class="gw">
		<%@ include file="/WEB-INF/views/layout/header.jsp"%>

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
					<td><a class="mx-2 subinfo"
						href="${pageContext.request.contextPath}/admin/member/list?selectPage=1&numOfMemberPerPage=5&blacklisted=Y">블랙리스트</a></td>
					<td><span class="mx-2 subinfo">신고</span></td>
				</tr>


				<c:forEach var="item" items="${member.list}">

					<tr class="py-2">
						<td><img class="mx-2 m_img"
							src="${pageContext.request.contextPath}/resources/files/member/${item.m_photo}"></td>
						<td><span class="mx-2">${item.m_idx}</span></td>
						<td><a class="mx-2 justify-content-center"
							href="${pageContext.request.contextPath}/admin/member/info?m_idx=${item.m_idx}&selectPage=${param.selectPage}&numOfMemberPerPage=${param.numOfMemberPerPage}">${item.m_email}</a></td>
						<td><span class="mx-2">${item.m_nm}</span></td>
						<td><span class="mx-2 subinfo">${item.m_regdate}</span></td>
						<td><span class="mx-2 subinfo">${item.m_quitdate}</span></td>
						<td>
							<!-- items.m_blacklist의 값이 N일경우X Y일경우O로 출력 --> <span
							class="mx-2 subinfo"> <c:if
									test="${item.m_blacklist eq 'N'}">
								X
							</c:if>
							 <c:if test="${item.m_blacklist eq 'Y'}">
								O
							</c:if>
						</span>
						</td>
						<td><span class="mx-2 subinfo">${item.reportCount}</span></td>
					</tr>

				</c:forEach>
			</table>

			<div class="d-flex justify-content-center my-5">
				<div class="input-group inner" id="membersearch">
					<div class="input-group-prepend">
						<select class="form-select" aria-label="Default select example" id="searchTypeBox">
							<option value="all" selected>전체</option>
							<option value="onlyname">이름</option>
							<option value="onlyid">아이디</option>
						</select> 
					</div>

					<input id="searchbararea" style="border-left: 0;" type="text" 
						class="form-control" aria-label="Amount (to the nearest dollar)"
						placeholder="검색">
					<img class="input-group-text" style="height: 100%"
							src="${pageContext.request.contextPath}/resources/files/server/icons/img_searchicon.svg" id="searchBtn">
					<sec:authorize access="hasRole('ADMIN')">
						<button type="button" class="btn btn-danger" id="blacklistbtn">블랙리스트</button>
					</sec:authorize>
				</div>
			</div>

			<div class="d-flex justify-content-center my-5" id="paging">
				<c:forEach begin="1" end="${member.totalPage}" var="pnum">
					<span class="mx-2">${pnum}</span>
						
				</c:forEach>
			</div>

		</div>
	</div>
	<!-- <div class="d-none"> -->
	<div>
		<form method="post" id="searchParameter">
			<input type="text" name="searchType" value="${member.searchType}">
			<input type="text" name="selectPage" value="${member.selectPage}">
			<input type="text" name="numOfMemberPerPage" value="${member.numOfMemberPerPage}">
			<input type="text" name="keyword" id="searchbar2">
		</form>
	</div>
	<%@ include file="/WEB-INF/views/layout/footer.jsp"%>
</body>
<script>
	$(function() {
		$('#blacklistbtn')
				.click(
						function() {

							location.href = '${pageContext.request.contextPath}/admin/member/list?selectPage=1&numOfMemberPerPage=5&blacklisted=Y';

						});
		$('#paging span').on('click',function(){
			
			$('#searchParameter input[name=selectPage]').val($(this).text());
			$('#searchParameter').submit();
			
			
		})
		
		$('#searchTypeBox').on('change',function(){
			//console.log($('#searchTypeBox option:selected').val());
			$('#searchParameter input[name=searchType]').val($('#searchTypeBox option:selected').val());
			
		})
		
		$('#searchBtn').on('click',function(){
			
			
			
			
			$('#searchParameter input[name=keyword]').val($('#searchbararea').val());
			$('#searchParameter input[name=selectPage]').val('1');
		 	$('#searchParameter').submit();
			
		})
		

	})
</script>
</html>