<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chatroom.css">
<title>채팅창</title>

<!-- 채팅을 위해 필요 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

</head>
<body>




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
<span id="myname" class="d-none">${myname}</span>
<input type="hidden" value="${matchidx}">

<div class="gw">

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	<div class="chatRoom-whole">
	<!-- chatRoom Header--------------------------------------------------------------------------------------------- -->
		<div class="chatRoom-header">
		
			<div class="recieverName">
				<img src="${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}" class="profile_photo">
					<!-- 상대방 프로필로 이동하기 -->
					<c:if test="${mytype=='mentee'}">
						<button type="button" class="btn btn-success" id="profileBtn"><a href="${pageContext.request.contextPath}/member/profile/main?m_idx=${reciever}" style="color: white">${recieverInfo.m_nm}님의 프로필 보기</a></button>
					</c:if>
					<c:if test="${mytype=='mentor'}">
						<button type="button" class="btn btn-success" id="profileBtn">${recieverInfo.m_nm}님과의 채팅방</button>
					</c:if>
			</div>
			
			
			<div class="btns">
					<!-- 채팅나가기 -->
					<!-- 미완 : 채팅목록으로 리다이렉트/그리고 ajax로 update match mentee_outyn또는 mentor_outyn Y로 하기-->
						<button class="btn btn-light" data-bs-target="#leaveChk" data-bs-toggle="modal">채팅 </span>나가기</button>		
					
					<!-- 신고하기버튼  -->
						<button class="btn btn-light" data-bs-target="#reportForm" data-bs-toggle="modal" id="report" >신고하기</button>
				
					<span class="rightBtn">
					<c:if test="${mytype eq 'mentee'}">
						<!-- 매칭하기 -->
						<!-- 보이는 조건 : 매칭여부 N & 매칭날짜가null이어야함(작동)-->
							<button type="button" data-bs-target="#matchChk" data-bs-toggle="modal" id="match"   style="background-color : #FFD601; border: 1px solid #FFD601"
							class="${not(match.match_yn eq 'N' && match.match_date eq null)? 'hide': ''} btn btn-primary">매칭 하기</button>
						<!-- 보이는 조건 : 매칭여부 N & 매칭날짜가 있어야함(비작동)-->
							<button type="button" disabled="true"  style="background-color : #FFD601; border: 1px solid #FFD601"
							class="${not(match.match_yn eq 'N' && match.match_date ne null)? 'hide': ''} btn btn-primary">매칭 하기</button>
					
						<!-- 매칭취소 -->
						<!-- 보이는 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이전이어야한다 -->
							<button type="button" data-bs-target="#matchCancleChk" data-bs-toggle="modal" id="unmatch" style="background-color : #FFD601; border: 1px solid #FFD601"
							class="${not(match.match_yn eq 'Y' && unmatchYN eq'Y')? 'hide': ''} btn btn-primary">매칭 취소</button>
							
						<!-- 매칭완료 -->
						<!-- 보이는 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이후 -->
							<button id="matched" disabled="true"  style="background-color : #FFD601; border: 1px solid #FFD601"
							class="${not(match.match_yn eq 'Y' && unmatchYN eq'N')? 'hide': ''} btn btn-primary">매칭 완료</button>
						
						<!-- 후기쓰기 -->
							<button type="button" disabled="${mytype eq 'mentor'?'true':'false'}" style="background-color : #FFD601; border: 1px solid #FFD601"
							class="btn btn-primary" onclick="review()" id="reviewing">후기 쓰기</button>
					</c:if>
					<c:if test="${mytype eq 'mentor'}">
						<!-- 매칭 전 -->
						<!-- 보이는 조건 : 매칭여부 N & 매칭날짜가null이어야함(작동)-->
							<button type="button" disabled="true" style="background-color : #FFD601; border: 1px solid #FFD601"
							class="${not(match.match_yn eq 'N' && match.match_date eq null)? 'hide': ''} btn btn-primary">매칭 전</button>
						
						<!-- 매칭 중 -->
						<!-- 보이는 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이후 -->
							<button id="matched" disabled="true" style="background-color : #FFD601; border: 1px solid #FFD601"
							class="${not(match.match_yn eq 'Y')? 'hide': ''} btn btn-primary">매칭 중</button>
					</c:if>
					</span>
			</div>	
		</div>	
		
		<!-- chat Message--------------------------------------------------------------------------------------------- -->
		
		<div id="chatBox" class="chattingBox">
			<c:forEach items ="${chatlist}" var="c">
				<c:set var="presender" value="${c.m_sender}"/>
				<c:set var="prereciever" value="${c.m_reciever}"/>
				<c:set var="present" value="${c.sent}"/>
				<c:set var="premessage" value="${c.message}"/>
				<c:set var="sysmsgYN" value="${c.sysmsgYN}"/>
				
				<!-- 시스템 메세지 창 -->
				<c:if test="${sysmsgYN eq'Y'}">
					<div class='well text_center'>
						<span>${c.sent}</span>
						<span id="sysmsg" class="rounded-pill"><strong>${premessage}</strong></span>
					</div>
				</c:if>
				
				<!-- 일반회원 창 -->
				<c:if test="${sysmsgYN eq'N'}">
					<!-- 내 메세지 창 -->
					<c:if test="${presender==myidx}">
						<div class='well text_right'>
							<span>${c.sent}</span>
							<span id="sendermsg" class="rounded-pill"><strong>${premessage}</strong></span>
						</div>
					</c:if>
					
					<!-- 상대방 메세지 창 -->
					<c:if test="${presender!=myidx}">
						<div class='well text_left'>
							<span id="recieverphoto"><img src="${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}" class="m_photo"></span>
							<span id="recievermsg" class="rounded-pill">${premessage}</span>
							<span>${c.sent}</span>
						</div>
					</c:if>	
				</c:if>
			</c:forEach>	
		</div>
			
		<!-- input Message--------------------------------------------------------------------------------------------- -->
		
		<div class="inputMsg mx-auto mb-5">
			<div class="input-group">
				<input type="text" class="form-control" id="message" />
				<input type="button" class="btn btn-primary" id="sendBtn" value="전송" />
			</div>
			<br>
			<div class="well" id="chatdata">
				<!-- User Session Info Hidden -->
				<input type="hidden" value='${myidx}' id="sessionuseridx">
			</div>
		</div>
	</div>
</div>	

<%@include file="/WEB-INF/views/layout/footer.jsp" %>

<!-- 확인모달들 여기 모아둠--------------------------------------------------------------------------------------------- -->
<!-- 채팅 나감 모달 -->
		<div class="modal fade" id="leaveChk" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		        	<h4>정말로 채팅창을 나가시겠습니까?</h4>
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="leaveChat" >네</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>



<!-- 매칭 확인  -->
	<div class="modal fade" id="matchChk" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		        <h3>${recieverInfo.m_nm}님과 매칭하시겠습니까?</h3>
		         (매칭 후 3일동안만 매칭취소가 가능합니다. 3일이후에는 자동으로 매칭이 확정됩니다.)
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="matchY" >네</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>



<!-- 매칭취소 확인  -->
	<div class="modal fade" id="matchCancleChk" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		         <h3>${recieverInfo.m_nm}님과 매칭 취소하시겠습니까?</h3>
		                  한번 취소한 매칭은 다시 매칭이 불가능합니다.
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="matchCancleY" >네</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>





<!-- 리뷰 작성 모달 -->
		<div class="modal fade" id="reviewform" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title">리뷰작성</h5>
		      </div>
		      
		      <div class="modal-body">
		         	<div style=" margin-bottom : 5px;">실거래를 진행한 경우에만 리뷰를 작성해주세요. 허위 또는 악의적 리뷰는 이용에 제한이 있을 수 있습니다.</div>
		         	<br>
		         	<div>
		         		<span><img src="${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}" class="m_photo2"></span>
		         		<span style="font-size: 1.5rem; padding-left: 8px">${recieverInfo.m_nm} 님</span>
		         	</div>
		         	<div>
		         		<form class="rating">
						  <label>
						    <input type="radio" name="stars" value="1" id="rate"/>
						    <span class="icon">★</span>
						  </label>
						  <label>
						    <input type="radio" name="stars" value="2" id="rate"/>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						  </label>
						  <label>
						    <input type="radio" name="stars" value="3" id="rate"/>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						    <span class="icon">★</span>   
						  </label>
						  <label>
						    <input type="radio" name="stars" value="4" id="rate"/>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						  </label>
						  <label>
						    <input type="radio" name="stars" value="5" id="rate"/>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						    <span class="icon">★</span>
						  </label>
						</form>
		         	</div>
		         	<div>
						<textarea class="form-control" rows="3" id="comment" name="text" placeholder="${recieverInfo.m_nm}님과의 후기를 작성해주세요.">
						</textarea>
					</div>
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="regReview" >등록하기</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		


<!-- 신고하기폼(모달창) -->
		<div class="modal fade" id="reportForm" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalToggleLabel">신고하기</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      
		      <div class="modal-body">
		      
		           <div>신고하기 사유 확인이 불가할 경우 해당 신고건은 미조치됩니다.</div>
		          
						<div class="form-check">
			              <label class="form-check-label">
			                <input type="radio" class="form-check-input" name="rprt" value="add">서비스와 관련없는 광고/홍보
			              </label>
			            </div>
			            <div class="form-check">
			              <label class="form-check-label">
			                <input type="radio" class="form-check-input" name="rprt" value="assert">부적절한 언어(욕설/성희롱 등) 사용
			              </label>
			            </div>
			            <div>서비스 진행중 문제가 생겼다면 증빙자료(대화내역, 문자메세지, 녹취, 사진 등)과 함께 숨고 이메일 admin1@aljdream.com으로 접수해주세요. 신고 결과는 별도안내되지 않습니다.</div>
		            
		      </div>
		      
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" onclick="showConfirmRprt()">신고접수</button>
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<!-- 신고 확인(모달창) -->
		<div class="modal fade" id="confirm" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalToggleLabel2">알림사항</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      
		      <div class="modal-body">
		        	한번 접수한 신고내용은 수정이나 삭제가 불가합니다. 이 신고내용을 접수하시겠습니까?
		      </div>
		      
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="sendReport">네, 확인했습니다</button>
		        <button type="button" class="btn btn-secondary" data-bs-target="#reportForm" data-bs-toggle="modal" onclick="doubleCheck()" id="doubleChk">한번 더 확인하겠습니다</button>
		      </div>
		    </div>
		  </div>
		</div>

<!-- --------------------------------------------------------------------------------------------------------------------------- -->
<script>

//채팅관련 ------------------------------------------------------------------------------
//websocket을 지정한 URL로 연결
var sock = new SockJS("<c:url value="/echo"/>");
sock.onopen = onOpen;
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onerror = onError;
$(document).ready(function(){
	
	
	var myname=$('#myname').text();
	console.log(myname);
	
	// 메세지를 보낼 때
	$('#sendBtn').on('click',function(evt){
		
		console.log('메세지 버튼 클릭');
		sendMessage();	// 메세지 보내는 함수 실행
		
		$('#message').val('');	
		$('#message').focus();
	})
	
	
	// 채팅 나가기 누를때
	 $('#leaveChat').on('click',function(){
		
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
					var mngMsg = $('#myname').text()+'님이 채팅방을 나가셨습니다.';
					sendMngMessage(mngMsg);
					
					location.href="${pageContext.request.contextPath}/chat/chatlist";
					//성공했을때 > 채팅목록으로 나간다
				}else{
					//에러있을때
					alert('오류입니다.');
				}
			}, 
			error : function(){
				console.log('비동기통신 오류');
			}
		})
	})
	
	
	// 매칭하기 확인 누를때
	$("#matchY").on('click',function(){
		
		
		// ajax로 matchyn y으로 update
		var matchYN = 'Y';
		
		matchUpdate(matchYN);
		
		document.getElementById("match").style.display="none";
		document.getElementById("unmatch").style.display="inline-block"; 
		
		// ${reciever}님과 ${myidx}님이 매칭되었습니다! 화면에 채팅으로 올라간다(중앙에)
		var mngMsg = $('#myname').text()+'님과 ${recieverInfo.m_nm} 님의 매칭이 성사되었습니다!';
		console.log(mngMsg);
		
		sendMngMessage(mngMsg);
	})
	
	
	// 매칭취소 확인 누를때
	$('#matchCancleY').on('click', function(){
		
		var matchYN = 'N';
		
		matchUpdate(matchYN);
		
		document.getElementById("match").style.display="inline-block";
		document.getElementById("match").disabled = true;
		document.getElementById("unmatch").style.display="none";
		
		// ${reciever}님과  ${myidx}님의 매칭이 취소되었습니다. 화면에 채팅으로 올라간다(중앙에)
		var mngMsg = $('#myname').text()+'님과 ${recieverInfo.m_nm} 님의 매칭이 취소되었습니다. 더이상의 매칭이 불가합니다.';
		console.log(mngMsg);
		
		sendMngMessage(mngMsg);
	})
})
	  
	// 연결되었을 때
	function onOpen(){
		console.log('Info : connection opened');
	};
	
	// 메세지 보낼때
	function sendMessage() {
		//websocket으로 메시지를 보내기
		
		// 현재 시간
		var today = new Date();
		var todaysMnth = today.getMonth()+1;
		console.log(todaysMnth);
		var time = todaysMnth+"월 "+today.getDate()+"일 " +today.getHours() + ":" + today.getMinutes();
		
		var msg = {
			reciever : ${reciever},
			matchidx : ${matchidx},
			message : $("#message").val(),
			sent : time
		};
		console.log(msg);
		console.log('sendMessage');
		sock.send(JSON.stringify(msg));
	};
	
	 // 시스템메세지
	 function sendMngMessage(mngMsg) {
		
		var sysMsg ='###aljdream###'+mngMsg;
		console.log(sysMsg);
		// 현재 시간
		var today = new Date();
		var todaysMnth = today.getMonth()+1;
		console.log(todaysMnth);
		var time = todaysMnth+"월 "+today.getDate()+"일 " +today.getHours() + ":" + today.getMinutes();
		
		var msg = {
			reciever : ${reciever},
			matchidx : ${matchidx},
			// 시스템 상 메세지는 특정 문자열을 넣어서 진행하도록한다
			message : sysMsg,
			sent : time
		};
		console.log(msg);
		console.log('매니저메세지발송');
		sock.send(JSON.stringify(msg));
	};
	
	// 메세지 받을 때
	function onMessage(evt) { 
		console.log('onMessage');
		var data = evt.data; 	// 전달받은 데이터이다.
		console.log(data);
		
		// -----------------------------------------------
		msgData = JSON.parse(data); 
		
		var sessionid = null;
		var message = null;
		
		// 현재 세션아이디 //	
		var currentuser_session = ${myidx};					
		var recievernm = '${recieverInfo.m_nm}';
		console.log('current session id: ' + currentuser_session);
			
		// 1차로, 받은메세지가 시스템메세지인지아닌지 확인한다.
		var msg = msgData.message;
		var sysdistinct = msg.slice(0,14);
		
		if(sysdistinct =='###aljdream###'){
			
			// 매니저 메세지를 송출
			var systemMessage = msg.slice(14);
			console.log(systemMessage);
			var printHTML = "<div class='well text_center'>";
			printHTML += "<span>"+msgData.sent+"</span>";
			printHTML += "<span id='sysmsg' class='rounded-pill'><strong>" +systemMessage+ "<strong></span>";
			printHTML += "</div>";
			$('#chatBox').append(printHTML);
			
		}else{
			// 회원메세지를 송출
			// 나와 상대방이 보낸 메세지를 구분하여 출력
			if (msgData.m_sender == currentuser_session) {			// sender와 내 세션아이디가 같다면 내가보내는 것
				// 오른쪽에 출력되도록하기
				var printHTML = "<div class='well text_right'>";
				printHTML += "<span>"+msgData.sent+"</span>";
				printHTML += "<span id='sendermsg' class='rounded-pill'><strong>" +msgData.message+"<strong></span>";
				printHTML += "</div>";
	
				$('#chatBox').append(printHTML);
			} else {
				var printHTML = "<div class='well text_left'>";
				printHTML += "<span id='recieverphoto'><img src='${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}'class='m_photo'></span>";
				printHTML += "<span id='recievermsg' class='rounded-pill'>" + msgData.message +"</span>";
				printHTML += "<span>"+msgData.sent+"</span>";
				printHTML += "</div>";
				
				$('#chatBox').append(printHTML);
			}
		} 
		console.log('chatting data: ' + data);
		
	};
	
	function onClose(evt) {
		$("#data").append("연결 끊김");
	};
	
	function onError(err){
		console.log('Error:', err);
	};
//채팅관련 끝------------------------------------------------------------------------------
	  
	  
	// match여부 업데이트할 시
	function matchUpdate(matchYN){
		
		console.log(matchYN);		//넘어오는것 확인했습니다.
		console.log(${matchidx});	//넘어오는것 확인했습니다.
		$.ajax({
			url : '${pageContext.request.contextPath}/chat/matchupdate',
			type : 'post',
			data : {
				matchYN : matchYN,
				matchidx : ${matchidx}
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
		
	};
	
	// 리뷰버튼 눌렀을 때
	function review(){
		<!-- 후기등록 조건 : match_yn(매칭여부) Y && unmatchYN(매칭취소가능여부)N -->
		<!-- 후기등록 조건 : ableRv(작성가능여부)Y -->
		
		if(!((${match.match_yn eq 'Y'}) && (${unmatchYN eq 'N'}))){
			alert('후기 등록은 매칭한 상태이어야하고, 매칭일 3일이 지나고부터 가능합니다.');
		}else if(!${ableRv eq'Y'}){
			alert('이미 후기를 등록한 매칭입니다. 후기 등록은 한번만 가능합니다.');
		}else{
			$('#reviewform').modal('show');
		}
	};
	
	
	// 별점 작성시 함수
	$(':radio').change(function() {
		  console.log('New star rating: ' + this.value);
		});
	
	
	// 리뷰 등록시
	 $('#regReview').on('click',function(){
		var stars = $('#rate:checked').val();
		if(!$('#rate').prop('checked')) {
		    // 별점이 체크되지않았다면
		  alert('리뷰작성시 별점은 필수입니다. 확인해주세요!');
		}
		console.log(rating);
		var comment = $('#comment').val();
		console.log(comment);
		$.ajax({
			url : '${pageContext.request.contextPath}/review/regreview',
			type : 'POST',
			data : {
				rating : stars,
				comment : comment,
				matchidx : ${matchidx}
			},
			success : function(data){
				if(data==1){
					alert('리뷰가 등록되었습니다');
					document.getElementById("reviewing").disabled = true;
				}else{
					//에러있을때
					alert('오류입니다.');
				}
			}, 
			error : function(){
				console.log('비동기통신 오류');
			}
		})
	});
	
	// 신고접수하기 눌렀을 때
	function showConfirmRprt(){
		console.log($('input[name=rprt]:checked').length);
		if(!($('input[name=rprt]:checked').length>0)) {
			// 체크되지않았다면
		  alert('접수할 내용을 체크하지 않으셨습니다. 신고내용을 체크해주세요!');
		}else{
			// 확인 모달 보여줌
			$('#confirm').modal('show');
			$('#reportForm').modal('hide');
		}
	}
	
  	
	// 신고접수를 눌렀을 시
	 $("#sendReport").click(function(){
		var content = $('.form-check-input:checked').val();
		console.log(content);
	 	
		// 먼저 이 매칭에서 신고한 적이 없는지 확인
	 	if(!${ableRprt eq 'Y'}){
			 alert('신고는 한 채팅방에 한번만 가능합니다. 기타 문의는 알려드림 이메일 admin1@aljdream.com으로 접수바랍니다.');
		}else{
			chkTodayRprt(content);
		}
	});
	
	// 신고접수시 한번더확인하겠다고 할 때
	function doubleCheck(){
		$('#confirm').modal('hide');
		
	}
	
	// 하루 신고 최대치를 넘지않았는지 확인
	function chkTodayRprt(content){
		
		$.ajax({
			url : '${pageContext.request.contextPath}/report/maxrprt',
			type : 'post',
			data : {
				matchidx : ${matchidx},
				myidx : ${myidx}
			},
			success : function(data){
				if(data==1){
					console.log('신고접수 가능');
					reporting(content);
				}else{
					$('#reportForm').modal('hide');	
					alert('하루에 신고 가능한 횟수(5회)를 초과히였습니다.');
				}
			}, 
			error : function(){
				console.log('비동기통신 오류');
			}
		})
	};
	
	// 신고내용 전송
	function reporting(content){
		console.log(content);
		$.ajax({
			url : '${pageContext.request.contextPath}/report/sendreport',
			type : 'POST',
			data : {
					match_idx : ${matchidx},
					report_content : content,
					m_report : ${myidx},
					m_reported : ${reciever}
					},
					
			success : function(data){
				// 전송에 성공하면 실행될 코드
				if(data==1){	
					$('#reportForm').modal('hide');														
					alert('신고접수가 완료되었습니다.');
					document.getElementById("report").disabled = true;
				} else {
					alert('전송오류');
				}
			}, 
			error : function(){
				console.log('비동기통신 오류');
			}
		})
	};
		
	
	

	
	
</script>

</body>

</html>