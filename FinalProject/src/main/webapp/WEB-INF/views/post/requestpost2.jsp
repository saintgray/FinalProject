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
<style>
.m_photo{
		width:40px;
		height:40px;
		border-radius: 50%;
	}
	
</style>

</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>



<!-- 현 로그인 정보 -->
<sec:authorize access="isAuthenticated()">
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="myname">
		<sec:authentication property="principal.name"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>



<h1>그룹리스트</h1>

<div class="container" id="rqpost">
	<button type="button" class="btn btn-light">
		<a href="${pageContext.request.contextPath}/post/view?idx=${requestPost.post_idx}">작성한게시글보기 </a>
	</button>
	<h3>게시글 타이틀 : ${requestPost.post_nm}</h3>
	<h3>게시글 생성일자 : ${requestPost.post_regdate}</h3>
	<h3>게시글 카테고리 : ${requestPost.cat_nm}</h3>
</div>

<h2>멤버리스트</h2>

<table>
	
	<c:forEach items="${requestPost.list}" var="member">
		
		<tr>
				<td class="mat-idx">
					<input type="text" class="matchidx" value="${member.match_idx}"> 
				</td>
				<%-- <td class="postidxRow"><input type="hidden" id="postidx" value="${member.post_idx}"><span class="postidx" style="color:red">${member.post_idx}</span></td> --%>
				
				<td class="midxRow">
					<input type="hidden" id="rqM_idx" value="${member.m_idx}"/>
					<span class="midx" ></span>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/chat/chatroom?myidx=${myidx}&matchidx=${member.match_idx}&reciever=${member.m_idx}" style="color:blue">문의한 회원 이름 : ${member.m_nm}</a>
				</td>
				
				<td>
					<img src="${pageContext.request.contextPath}/resources/files/member/${member.m_photo}" class="m_photo">문의한 회원 사진 : ${member.m_photo}
				</td>
				
				<td class="wantedRow">
					<input type="hidden" class="wanted" value="${requestPost.wanted}">
				</td>
				
				<c:if test="${mytype eq 'mentee'}">
					<td>프로필소개 : ${member.line}</td>
				</c:if>
				<td>
					<input type="button" value="문의하기" class="rqBtn">
				</td>
				<!-- <td class="msgRow">
					<input type="text" class="msg">
					<input type="button" value="채팅보내기" class="msgBtn">
				</td> -->
				<!-- <td>
					<button data-bs-target="#deleteConfirm" data-bs-toggle="modal" class="deleteReq">삭제하기</button>
				</td> -->
		</tr>
		
	</c:forEach>

</table>

	
	
<!-- 삭제하기 모달 -->
		<div class="modal fade" id="deleteConfirm" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		        	 
		      </div>
		      
		      <div class="modal-footer">
		    
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="deleteMatch" >네</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>
	

<!-- 문의하기 모달 -->
		<div class="modal fade" id="request" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		        	 이 회원에게 문의하시겠습니까?
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="rqYes" >네</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>		


<!-- 채팅보내기 모달 -->
		<div class="modal fade" id="sendchat" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		        	 성공적으로 문의가 이루어졌습니다! <br>
		        	()님에게 근사한 첫인상을 남길 첫마디를 작성해주세요!
	        	<div class="msgRow">
					<input type="text" class="msg">
					<input type="button" value="채팅보내기" class="msgBtn">
				</div>
				
		      </div>
		      
		      <div class="modal-footer">
		      	()님에게 보낸 첫마디는 내 채팅목록에서 확인해주세요.
		      </div>
		    </div>
		  </div>
		</div>	
	

	
<script>
$(document).ready(function(){
		
	/* $('.deleteReq').on('click',function(){
		console.log($(this).parent().siblings('.mat-idx'));
		console.log($(this).parent().siblings('.mat-idx').children('.matchidx').val());
		console.log()
		
		var info='';
		info+='정말로 문의한 회원을 삭제하시겠습니까?\r\n';
		info+='<br>\r\n';
		info+='삭제한 회원은 채팅목록에서도 삭제됩니다.';
		info+='<span id="target-mat-idx" style="color:red">'+$(this).parent().siblings('.mat-idx').children('.matchidx').val()+'</span>';
		
		$('#deleteConfirm .modal-body').html(info);
			
	}) */
	
		/* // 회원삭제 눌렀을 시
		$("#deleteMatch").on('click',function(){
			
			
			var match_idx=$('#target-mat-idx').text();
	        	
			
			console.log(match_idx);
			$.ajax({
				url : '${pageContext.request.contextPath}/post/matchupdate',
				type : 'post',
				data : {
					matchYN : 'N',
					matchidx : matchidx
					},
				success : function(data){
					if(data==1){
						console.log('match 업데이트 성공');
					}else{
						console.log('match 업데이트 실패');
					}
				}, 
				error : function(){
					console.log('비동기통신 오류');
				}
			})
		}) */
	
	//-------------------------------------------post view에합쳐야하는 내용
	/*ajax처리*/
	// 문의하기 눌렀을 시
	$('.rqBtn').click(function(myidx){	
		
		var mentor = "mentor";
		var mentee = "mentee";	
		var mytype = ${mytype};
	
		if(mytype == mentor){
			//멘토면프로필을 확인한다 > 프로필 있을경우 그대로 진행 , 없으면 프로필을 작성해주세요
			
			$.ajax({
				url : '${pageContext.request.contextPath}/post/profilechk',
				type : 'post',
				data : {myidx : myidx},
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
			sendrq($(this));
		}
	})

	
	function sendrq(dom){
		
		var postidx = $(dom).parent().siblings('.postidxRow').children('.postidx').text();
		var midx = $(dom).parent().siblings('.midxRow').children('.midx').text();
		var wanted = $(dom).parent().siblings('.wantedRow').children('.wanted').text();
		
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
	
	// 문의 후 작업
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
	})
		
	
		
});

</script>
	
	
<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>

</html>