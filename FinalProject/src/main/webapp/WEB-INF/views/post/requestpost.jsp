<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
         <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>받은 제의 리스트</title>
</head>
<body>

<!-- 현 로그인 정보 -->
<h1>현로그인 정보</h1>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.m_idx"/>
<sec:authentication property="principal.name"/>
<sec:authentication property="principal.photo"/>
<sec:authentication property="principal.m_type"/>
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="myname">
		<sec:authentication property="principal.name"/>
	</c:set>
	<c:set var="myphoto">
		<sec:authentication property="principal.photo"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>




<!-- 받은제의 그룹에서 선택한 게시글 -->
<div id="requestGroup${requestPost.post_idx}">


<h1>그룹리스트</h1>

<h3>게시글 고유번호 : ${requestPost.post_idx}</h3>
<h3>게시글 타이틀 : ${requestPost.post_nm}</h3>
<h3>게시글 생성일자 : ${requestPost.post_regdate}</h3>
<h3>게시글 요청대상 : ${requestPost.wanted}</h3>
<h3>게시글 카테고리 : ${requestPost.cat_nm}</h3>

<h2>멤버리스트</h2>

<table>


<c:forEach items="${requestPost.list}" var="member">
		
			<tr>
				<td>매칭 고유번호 : ${member.match_idx}</td>
				<td class="postidxRow"><span class="postidx" style="color:red">${member.post_idx}</span>게시글 고유번호 : ${member.post_idx}</td>
				
				<td class="midxRow"><span class="midx">${member.m_idx}</span>문의한 회원 고유번호 : ${member.m_idx}</td>
				<td>문의한 회원 이름 : ${member.m_nm}</td>
				<td>문의한 회원 사진 : ${member.m_photo}</td>
				<td class="wantedRow"><span class="wanted">${requestPost.wanted}</span>요청 대상 타입: ${requestPost.wanted}</td>
				<td>매칭 여부 : ${member.matched_yn}</td>
				<td>매칭 여부 : ${member.line}</td>
				<td><input type="button" value="문의하기" class="rqBtn"></td>
				<!-- 여기를 ajax처리한다 -->
				<!-- myidx, mytype, midx, postidx전송해서 match테이블 확인 -->
				<!-- 0:테이블존재 >이미 문의한 게시글입니다. / 0보다큼: 테이블무존재>새로생성>채팅한마디 받아야함 -->
				<!-- myidx, mytype, midx, matchidx, message 전송 > chat만듬  -->
				<!-- chat만들어지면 상대방에게 채팅을 보냈습니다. 확인후 꺼짐 -->
				<td><input type="text" id="msg"><input type="button" value="채팅보내기" class="msgBtn"></td>
			</tr>
		
</c:forEach>

</table>

			
					
	<br><br>
	</div>
	
	<script>
$(document).ready(function(){
	
	/*ajax처리*/
	// 문의하기 눌렀을 시
	$('.rqBtn').click(function(){	// 자손표시 어케하냐
		
	console.log($(this).parent().siblings('.postidxRow').children('.postidx').text());
	console.log($(this).parent().siblings('.midxRow').children('.midx').text());
	console.log('${myidx}');
	console.log($(this).parent().siblings('.wantedRow').children('.wanted').text());
		
	var postidx = $(this).parent().siblings('.postidxRow').children('.postidx').text();
	var midx = $(this).parent().siblings('.midxRow').children('.midx').text();
	var wanted = $(this).parent().siblings('.wantedRow').children('.wanted').text();
	console.log(postidx);
	console.log(midx);
	console.log(wanted);
		 $.ajax({
			url : '${pageContext.request.contextPath}/match/matchchk',
			type : 'POST',
			data : {
				postidx : postidx,
				myidx	: ${myidx},
				midx : midx,
				wanted : wanted
				},
			success : function(data){
				// 전송에 성공하면 실행될 코드
				if(data==0){	// 테이블이 이미 있다는 뜻 = 문의를 했던 글이라는 뜻
					alert('이미 문의한 게시글입니다. 내 채팅목록을 확인해주세요!');
				} else {
					//채팅테이블 생성할 함수실행
					alert('#member.m_idx 님에게 보낼 멋진 첫 한마디를 작성해주세요!');
				}
			}
		})  
	});

	// 채팅 입력했을 시
	$('#requestMember msgBtn').click(function(){	// 자손표시 어케하냐
							$.ajax({
								url : 'insertchat',
								type : 'get',
								data : {
								match_idx 	: $('#member.post_idx'),
								m_reciever	: $('#member.m_idx'),
								m_sender	: $('#myidx'),
								message 	: $('#msg').val
								},
							success : function(data){
								// 전송에 성공하면 실행될 코드
								if(data=='1'){	// 테이블이 이미 있다는 뜻 = 문의를 했던 글이라는 뜻
									alert('#member.m_idx님에게 채팅을 전송했습니다!');
								} else {
									alert('전송오류');
								
								}
							}
							})
						});
});



</script>
	
</body>

</html>