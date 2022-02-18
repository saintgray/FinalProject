<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<title>채팅창</title>
<style>

	.text_right {
		text-align: right;
	}
	
	.text_left {
		text-align: left;
	}
	
	#sendermsg {	  
		padding : 15px;
		display: inline-block;
		height: 50px;
		margin: 6px;
		border : 1px solid orange;
	}
	
	#recievermsg {
		padding : 15px;
		display: inline-block;
		height: 50px;
		margin: 6px;
		background-color: navy;
		color : white;
	}
	
</style>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<h3>현로그인 정보</h3>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.m_idx"/>
<sec:authentication property="principal.name"/>
<sec:authentication property="principal.m_type"/>
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
myidx: ${myidx} / myname : ${myname} / myphoto : ${myphoto} / mytype : ${mytype}

<h3>참여자 정보</h3>

matchidx : ${matchidx}<br>
sender	 : ${myidx}<br>
reciever : ${reciever}<br>



matchyn : ${match.match_yn}
matchdate : ${match.match_date}



<h2>Chatting Page (채팅방번호: ${matchidx})</h2>

<!-- chatRoom의 Header -->

	<!-- 상대방 프로필로 이동하기 -->
	<!-- 미완 -->
	<a href="${pageContext.request.contextPath}/member/profile/profilemain">${reciever}의 이름</a>
	
	<!-- 더보기 -->
	
	
	<!-- 신고하기버튼  -->
	<!-- 합치기만하면됨 -->
	<a href="${pageContext.request.contextPath}/chat/report?matchidx=${matchidx}&sender=${myidx}&reciever=${reciever}">신고하기</a>
	
	<!-- 채팅나가기 -->
	<!-- 미완 : 채팅목록으로 리다이렉트/그리고 ajax로 update match mentee_outyn또는 mentor_outyn Y로 하기-->
	<button data-bs-target="#leaveChk" data-bs-toggle="modal">이 채팅 나가기</button>
	

	<c:if test="${match.match_yn eq 'N' && match.match_date eq null }">
	
	<!-- 매칭하기 -->
	<!-- 보이는 조건 : 매칭여부 N & 매칭날짜가null이어야함-->
	<button id="match">매칭 하기</button>
	</c:if>
	<%-- <script>
	var matchdate = ${match.match_date};
	var currentTime = new Date();
	var matchdate
	var canUnmatch = 
	var unmatchYN = matchdate.getTime() < currentTime.getTime()+3;
	</script>
	<c:if test="${match.match_yn eq 'Y' && match.match_date <  }"> --%>
	
	<!-- 매칭취소하기 -->
	<!-- 보이는 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이전이어야한다 -->
	
	<button id="unmatch">매칭 취소</button>
	<%-- </c:if> --%>
	
	
	
	<button id="unmatch">매칭 완료</button>
	
	
	
	<!-- 후기쓰기 -->
	<!-- 미완 -->
	<button id="review">후기 쓰기</button>


<!-- chatRoom의 Body -->

<div id="chatBox" class="chattingBox">
<c:forEach items ="${chatlist}" var="c">
	<c:set var="presender" value="${c.m_sender}"/>
	<c:set var="prereciever" value="${c.m_reciever}"/>
	<c:set var="present" value="${c.sent}"/>
	<c:set var="premessage" value="${c.message}"/>
	
	
	<!-- 내 메세지 창 -->
	<c:if test="${presender==myidx}">
		<div class='well text_right'>
			<span>${c.sent}</span>
			<span id="sendermsg" class="rounded-pill"><strong>${presender} -> ${premessage}</strong></span>
		</div>
	</c:if>
	
	<!-- 상대방 메세지 창 -->
	<c:if test="${presender!=myidx}">
		<div class='well text_left'>
			<span id="recieverphoto">상대방 사진</span>
			<span id="recievermsg" class="rounded-pill">${prereciever} -> ${premessage}</span>
			<span>${c.sent}</span>
		</div>
	</c:if>	
</c:forEach>	

</div>

<br>보내는 사람 : ${myidx} 받는사람 : ${reciever}
	<br>
	
		<div>
			<div>
				<input type="text" id="message" />
				<input type="button" id="sendBtn" value="전송" />
			</div>
			<br>
			<div class="well" id="chatdata">
				<!-- User Session Info Hidden -->
				<input type="hidden" value='${myidx}' id="sessionuseridx">
			</div>
		</div>


<!-- 확인모달들 여기 모아둠 -->
<!-- 채팅 나감 모달 -->
		<div class="modal fade" id="leaveChk" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalToggleLabel2"></h5>
		      </div>
		      
		      <div class="modal-body">
		         정말로 채팅창을 나가시겠습니까?
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="leaveChat" >네</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>

<script>

	// 채팅관련 ------------------------------------------------------------------------------
	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/echo"/>");


	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onerror = onError;
	

	
	$(document).ready(function(){
		
		// 메세지를 보낼 때
		$("#sendBtn").on('click',function(evt){
			
			console.log('메세지 버튼 클릭');
			sendMessage();	// 메세지 보내는 함수 실행
			
			$('#message').val('');	
			
			$('#message').focus();

		});
		
		
		// 채팅 나가기 누를때
		 $("#leaveChat").on('click',function(){
			
			$.ajax({
				url : '${pageContext.request.contextPath}/chat/leavechat',
				type : 'POST',
				data : {
					matchidx : ${matchidx},
					myidx : ${myidx},
					reciever : ${reciever},
					mytype : '${mytype}'
				},
				success : function(data){
					if(data==1){
						location.href="${pageContext.request.contextPath}/chat/chatlist";
						//성공했을때 > 채팅목록으로 나간다
					}else{
						//에러있을때
						alert('오류입니다.');
					}
				}
			})
		}); 
		
	});
	
	
	function sendMessage() {
		//websocket으로 메시지를 보내기
		
		var msg = {
			reciever : ${reciever},
			matchidx : ${matchidx},
			message : $("#message").val()
		};
		console.log(msg);
		console.log('sendMessage');
		sock.send(JSON.stringify(msg));
	};

	

	function onOpen(){
		console.log('Info : connection opened');
		//열리면 그동안의 데이터 가져와야한다.//이부분은 다른 부분 참고하기
		
	};

	
	function onMessage(evt) { 
		console.log('onMessage');
		var data = evt.data; 	// 전달받은 데이터이다.
		console.log(data);
		
		// -----------------------------------------------
		msgData = JSON.parse(data); 
		
		var sessionid = null;
		var message = null;
		//var sent = 
		
		// 현재 세션아이디 //	
		var currentuser_session = ${myidx};					//$('#sessionuserid').val();		// ${myidx}시도해보기
		console.log('current session id: ' + currentuser_session);
		
	
			// 나와 상대방이 보낸 메세지를 구분하여 출력
			if (msgData.m_sender == currentuser_session) {			// sender와 내 세션아이디가 같다면 내가보내는 것
				// 오른쪽에 출력되도록하기
				var printHTML = "<div class='well text_right'>";
				printHTML += "<span>"+msgData.sent+"</span>";
				printHTML += "<span id='sendermsg' class='rounded-pill'><strong>" + currentuser_session +"->"+msgData.message+"<strong></span>";
				printHTML += "</div>";

				$('#chatBox').append(printHTML);
			} else {
				var printHTML = "<div class='well text_left'>";
				printHTML += "<span id='recieverphoto'>상대방사진</span>";
				printHTML += "<span id='recievermsg' class='rounded-pill'>" + msgData.m_reciever + "-> " + msgData.message +"</span>";
				printHTML += "<span>"+msgData.sent+"</span>";
				printHTML += "</div>";

				$('#chatBox').append(printHTML);
			}

			console.log('chatting data: ' + data);
		
	};

	function onClose(evt) {
		$("#data").append("연결 끊김");
	};
	
	function onError(err){
		console.log('Error:', err);
	};

	
	

	
</script>

</body>

</html>