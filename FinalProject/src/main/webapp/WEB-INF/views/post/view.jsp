<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${viewRequest eq null}">
<script>
alert('해당 게시물이 존재하지 않습니다.');
history.go(-1);
</script>
</c:if>
<c:if test="${viewRequest ne null}">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- Container -->
<div class="container" id="PostViewArea">

<sec:authorize access="isAuthenticated()">
	<c:set var="idx">
	   <sec:authentication property="principal.m_idx" />
	</c:set>
	<c:set var="type">
	   <sec:authentication property="principal.m_type" />
	</c:set>
</sec:authorize>

<input type="hidden" id="postidx" value="${viewRequest.post_idx}">
<input type="hidden" id="wanted" value="${viewRequest.wanted}">
<input type="hidden" id="midx" value="${viewRequest.m_idx}">
<input type="hidden" id="myidx" value="${idx}">

<table>
<tr>
	<c:if test="${viewRequest.m_idx eq idx}">
	<td>문의건수 : ${viewRequest.match_count} 건</td>
	<td>${viewRequest.cat_nm}</td>
	</c:if>
	
	<c:if test="${viewRequest.m_idx ne idx}">
	<td colspan="2">${viewRequest.cat_nm}</td>
	</c:if>

	<td>${viewRequest.post_nm}</td>
</tr>

<c:if test="${viewRequest.wanted eq 'mentee'}">

<c:if test="${writerProfile ne null}">
<tr>
	<td rowspan="2"><img src="${writerProfile.m_photo}"></td>
	<td colspan="2">${writerProfile.m_nm} / 활동지역정보</td>
</tr>
<tr>
	<td colspan="3">${writerProfile.line}</td>
</tr>
</c:if>

<c:if test="${writerProfile eq null}">
<tr>
<td colspan="3">글쓴이의 프로필 정보가 없습니다.</td>
</tr>
</c:if>

</c:if>

<tr>
	<td colspan="3">${viewRequest.post_content}</td>
</tr>


<c:if test="${viewRequest.m_idx eq idx}">
<tr>
	<td colspan="3">
	매칭정보 : match테이블에서 가져온 정보 출력 <br>
	${viewRequest.matchInfos}
	</td>
</tr>
</c:if>

<c:if test="${viewRequest.m_idx ne idx && viewRequest.wanted eq type}">
<tr>
	<td colspan="3"><button type="button" id="matchBtn">문의하기</button></td>
</tr>
</c:if>

<c:if test="${viewRequest.m_idx eq idx}">
<tr>
	<td><a href="${pageContext.request.contextPath}/post/edit?idx=${viewRequest.post_idx}">수정</a></td>
	<td><a href="javascript:deletePost(${viewRequest.post_idx})">삭제</a></td>
</tr>
</c:if>

</table>

</div>

<script>
function deletePost(idx){
	
	if(confirm('글이 삭제됩니다. 계속 진행하시겠습니까?')){
		
		$.ajax({
			url: '${pageContext.request.contextPath}/post/delete',
			type: 'post',
			data: {post_idx : idx},
			success: function(data){
				if(data==1){
					alert('게시글이 삭제되었습니다.');
					location.href="${pageContext.request.contextPath}/post/list";
				} else {
					console.log('삭제 실패');
				}
			},
			error: function(){
				console.log('비동기 통신 오류');
			}
		});
		
	}
	
}

$(document).ready(function(){
	
	$('#matchBtn').on('click', function(){
		
		var postidx=$('#postidx').val();
		var wanted=$('#wanted').val();
		var midx=$('#midx').val();
		var myidx=$('#myidx').val();
		
		console.log('postidx:', postidx);
		console.log('wanted:', wanted);
		console.log('midx:', midx);
		console.log('myidx:', myidx);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/post/matchchk",
			type: "post",
			data: {
				postidx : postidx,
				midx : midx,
				myidx : myidx,
				wanted: wanted
			},
			success : function(data){
				alert('매칭 생성');
				location.href="${pageContext.request.contextPath}/post/view?idx="+postidx;
				// 전송에 성공하면 실행될 코드
				if(data==0){	// 테이블이 이미 있다는 뜻 = 문의를 했던 글이라는 뜻
					alert('이미 문의한 게시글입니다. 내 채팅목록을 확인해주세요!');
				} else {
					setMatchidx(data);
					console.log(matchidx);
					//채팅테이블 생성할 함수실행
					alert(${member.m_idx}'님에게 보낼 멋진 첫 한마디를 작성해주세요!');
				}
			},
			error: function(data){
				console.log('통신 오류');
				console.log(data);
			}
		});
		
	})
});
</script>

</body>
</html>

</c:if>