<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
         <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<link rel="shortcut icon" href="#">
<title>받은 제의 리스트</title>
 <!--  <%@ include file="/WEB-INF/views/defaultpageset.jsp" %>-->
</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>



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
				
				<td class="midxRow"><span class="midx" >${member.m_idx}</span>문의한 회원 고유번호 : ${member.m_idx}</td>
				<td>
					<a href="${pageContext.request.contextPath}/chat/chatroom?myidx=${myidx}&matchidx=${member.match_idx}&reciever=${member.m_idx}" style="color:blue">문의한 회원 이름 : ${member.m_nm}</a>
				</td>
				<td>문의한 회원 사진 : ${member.m_photo}</td>
				<td class="wantedRow"><span class="wanted">${requestPost.wanted}</span>요청 대상 타입: ${requestPost.wanted}</td>
				<td>매칭 여부 : ${member.matched_yn}</td>
				<td>매칭 여부 : ${member.line}</td>
				<td><input type="button" value="문의하기" class="rqBtn"></td>
				<td class="msgRow">
					<input type="text" class="msg">
					<input type="button" value="채팅보내기" class="msgBtn">
				</td>
			</tr>
		
</c:forEach>

</table>

</div>
	
<script>
$(document).ready(function(){

	
	/*ajax처리*/
	// 문의하기 눌렀을 시
	$('.rqBtn').click(function(){	
		
		var mentor = "mentor";
		var mentee = "mentee";	
		var mytype = ${mytype};
	
		if(mytype == mentor){
			//멘토면프로필을 확인한다 > 프로필 있을경우 그대로 진행 , 없으면 프로필을 작성해주세요
			
			$.ajax({
				url : '${pageContext.request.contextPath}/post/profilechk',
				type : 'post',
				data : ${myidx},
				success : function(data){
					if(data != null){
						console.log("멘토확인");
						sendrq();
					}else{
						// 프로필작성하기로 보내기
						alert('작성된 프로필이 없습니다. 프로필을 먼저 등록해주세요!');
						location.href = '${pageContext.request.contextPath}/member/profile/profilemain';
					}
				}
			})
		}else if(mytype == mentee) {
			console.log("멘티확인");
			sendrq();
		}
	});

	
	function sendrq(){
		
		var postidx = $(this).parent().siblings('.postidxRow').children('.postidx').text();
		var midx = $(this).parent().siblings('.midxRow').children('.midx').text();
		var wanted = $(this).parent().siblings('.wantedRow').children('.wanted').text();
		
		console.log(postidx);
		console.log(midx);
		console.log(wanted);
	
		 $.ajax({
			url : '${pageContext.request.contextPath}/post/matchchk',
			type : 'POST',
			data : {
				postidx : postidx,
				myidx	: ${myidx},
				midx 	: midx,
				wanted 	: wanted
				},
				
			success : function(data){
				// 전송에 성공하면 실행될 코드
				if(data==0){	// 테이블이 이미 있다는 뜻 = 문의를 했던 글이라는 뜻
					alert('이미 문의한 게시글입니다. 내 채팅목록을 확인해주세요!');
				} else {
					setMatchidx(data);
					console.log(matchidx);
					//채팅테이블 생성할 함수실행
					alert('#member.m_idx 님에게 보낼 멋진 첫 한마디를 작성해주세요!');
				}
			}
		})  
	}
	
	
	//ajax로 받은 결과 matchidx에 저장
	function setMatchidx(data){
		matchidx = data;
	}
	
		// 채팅 입력했을 시
		$('.msgBtn').click(function(){
			
			// var postidx = $(this).parent().siblings('.postidxRow').children('.postidx').text();
			var midx = $(this).parent().siblings('.midxRow').children('.midx').text();
			var msg = $(this).siblings('.msg').val();
			
			console.log(midx);
			console.log(msg);
			
			$.ajax({
				url : '${pageContext.request.contextPath}/post/insertchat',
				type : 'post',
				data : {
				match_idx 	: 28,
				m_reciever	: midx,
				m_sender	: ${myidx},
				message 	: msg
				},
			success : function(data){
				// 전송에 성공하면 실행될 코드
				if(data=='1'){	
					alert('님에게 채팅을 전송했습니다! 채팅내용은 내 채팅목록에서 확인해주세요.');
				} else {
					alert('전송오류');
				}
			}
		})
	});
});

</script>
	
	
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

</html>