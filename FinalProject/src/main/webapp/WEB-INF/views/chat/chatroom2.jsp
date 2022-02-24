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
	.chattingBox {
		padding : 15px;
		border : 1px solid #AAA;
		margin: 10px 0;
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
myidx: ${myidx} myname : ${myname} myphoto : ${myphoto}$ mytype : {mytype}

<h3>참여자 정보</h3>

matchidx : ${matchidx}<br>
sender	 : ${myidx}<br>
reciever : ${reciever}<br>



	<h2>Chatting Page (채팅방번호: ${matchidx})</h2>
	
	<a href="${pageContext.request.contextPath}/chat/report?matchidx=${matchidx}&sender=${myidx}&reciever=${reciever}">신고하기</a>
	
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
	
</body>

<c:if test=""></c:if>

<script>
	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/echo"/>");


	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onerror = onError;
	

	
	$(document).ready(function(){
		
		
		$("#sendBtn").on('click',function(){
			console.log('메세지 버튼 클릭');
			sendMessage();	// 메세지 보내는 함수 실행
			
			$('#message').val('');	
			
			$('#message').focus();

		});
		
	});
	
	
	function onOpen(){
		console.log('Info : connection opened');
	}

	
	function sendMessage() {
		//websocket으로 메시지를 보내기
		
		var msg = {
			reciever : '${reciever}',
			matchidx : '${matchidx}',
			message : $("#message").val()
		};
		console.log(msg);
		sock.send(JSON.stringify(msg));
	}

	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt) { //변수 안에 function자체를 넣음.
		var data = evt.data; // 전달 받은 데이터
		
		//alert(data);
		
		msgData = JSON.parse(data); 
		
		var sessionid = null;
		var message = null;
		
		//current session id//
		var currentuser_session = $('#sessionuserid').val();
		console.log('current session id: ' + currentuser_session);
		
		var target = $('#chattingBox-1');
		
		if(target.length==0){
			$('<div id=\"chattingBox-1\" class=\"chattingBox\"></div>').html('<h3>${myname} : 게시물 작성자-'+msgData.matchIdx+'</h3>').appendTo('body');
			$('#chattingBox-1').append('<hr>')
		}

			

		// 나와 상대방이 보낸 메세지를 구분하여 출력
		if (msgData.user == currentuser_session) {
			var printHTML = "<div class='well text_right'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>[" + msgData.sender + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";

			$('#chattingBox-1').append(printHTML);
		} else {
			var printHTML = "<div class='well text_left'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>[" + msgData.reciever + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";

			$('#chattingBox-1').append(printHTML);
		}

		console.log('chatting data: ' + data);

		/* sock.close(); */
	}

	function onClose(evt) {
		$("#data").append("연결 끊김");
	}
	
	function onError(err){
		console.log('Error:', err);
	}


</script>
</html>