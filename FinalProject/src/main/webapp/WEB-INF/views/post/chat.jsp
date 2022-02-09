<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>
<body>
<%-- ${result eq 1?'매칭테이블생성완료' : result eq 0? '매칭테이블생성실패':'서버오류'0} --%><!-- 오류 확인하기 -->
<div>
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
${myidx}${myname}${myphoto}${mytype}


<c:if test="${match.mentor_idx == myidx}">
	<c:set var="reciever" value="${match.mentee_idx}"/>	
</c:if>
<c:if test="${match.mentee_idx == myidx}">
	<c:set var="reciever" value="${match.mentor_idx}"/>	
</c:if>
</div>

	<h1>Chatting Page (채팅방번호: ${match.match_idx})</h1>
	<br>포스트 번호: ${match.post_idx}
	<br>멘토 방나감여부: ${match.mentor_outyn}
	<br>멘티 방나감여부: ${match.mentee_outyn}
	<br>매칭 여부: ${match.match_yn}
	<br>매칭 날짜: ${match.match_date}
	<br>멘티 idx: ${match.mentee_idx}
	<br>멘토 idx: ${match.mentor_idx}
	<br>현재 로그인한 정보 : ${myidx}, ${myname}, ${myphoto}, ${mytype}
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
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;
	
	
	$(document).ready(function(){
		
		
		
		
		
		$("#sendBtn").on('click',function(){
			console.log('send message...');
			sendMessage();
			
			$('#message').val('');
			
			$('#message').focus();
			
			
			
		});
		
	});
	
	function sendMessage() {
		//websocket으로 메시지를 보내기
		
		var msg = {
			myidx : '${myidx}',
		    myname : '${myname}',
			sender : '${myidx}',
			reciever : '${reciever}',
			matchIdx : '${match.match_idx}',
			postidx : '${match.post_idx}',
			midx : '${match.match_idx}',
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
			$('<div id=\"chattingBox-1\" class=\"chattingBox\"></div>').html('<h3>${user.name} : 게시물 작성자-'+msgData.matchIdx+'</h3>').appendTo('body');
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
	
	
</script>
</html>