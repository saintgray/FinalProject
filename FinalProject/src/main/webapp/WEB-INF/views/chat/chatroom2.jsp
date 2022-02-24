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

	.hide {
		display: none;
	}


	.text_right {
		text-align: right;
	}
	
	.text_left {
		text-align: left;
	}
	
	.text_center {
		text-align: center;
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
	
	.chattingBox{
	margin-top : 30px;
	border-bottom : 1px gray;
	padding: 35px;
	width: 100%;
	height: 60%;
	overflow: scroll;
	}
	
	.chattingBox::-webkit-scrollbar { 
	    display: none; 
	}
	
	
	.m_photo{
		width:40px;
		height:40px;
		border-radius: 50%;
	}
	
	/* 별점작성부분 */
	.rating {
	  display: inline-block;
	  position: relative;
	  height: 50px;
	  line-height: 50px;
	  font-size: 50px;
	}
	
	.rating label {
	  position: absolute;
	  top: 0;
	  left: 0;
	  height: 100%;
	  cursor: pointer;
	}
	
	.rating label:last-child {
	  position: static;
	}
	
	.rating label:nth-child(1) {
	  z-index: 5;
	}
	
	.rating label:nth-child(2) {
	  z-index: 4;
	}
	
	.rating label:nth-child(3) {
	  z-index: 3;
	}
	
	.rating label:nth-child(4) {
	  z-index: 2;
	}
	
	.rating label:nth-child(5) {
	  z-index: 1;
	}
	
	.rating label input {
	  position: absolute;
	  top: 0;
	  left: 0;
	  opacity: 0;
	}
	
	.rating label .icon {
	  float: left;
	  color: transparent;
	}
	
	.rating label:last-child .icon {
	  color: #000;
	}
	
	.rating:not(:hover) label input:checked ~ .icon,
	.rating:hover label:hover input ~ .icon {
	  color: yellow;
	}
	
	.rating label input:focus:not(:checked) ~ .icon:last-child {
	  color: #000;
	  text-shadow: 0 0 5px #09f;
	} 
	
</style>
<!-- 채팅을 위해 필요 -->
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

<!-- chatRoom의 Header--------------------------------------------------------------------------------------------- -->


	<!-- 상대방 프로필로 이동하기 -->
	<!-- 미완 -->
	<c:if test="${mytype=='mentee'}">
	<h3><a href="${pageContext.request.contextPath}/main?m_idx=${reciever}">${recieverInfo.m_nm}${myname}</a></h3>
	</c:if>
	<c:if test="${mytype=='mentor'}">
	<h3>${recieverInfo.m_nm}${myname}</h3>
	</c:if>
	
	
	
	
	<!-- 채팅나가기 -->
	<!-- 미완 : 채팅목록으로 리다이렉트/그리고 ajax로 update match mentee_outyn또는 mentor_outyn Y로 하기-->
	<button data-bs-target="#leaveChk" data-bs-toggle="modal">채팅 나가기</button>
	

	<!-- 매칭하기 -->
	<!-- 보이는 조건 : 매칭여부 N & 매칭날짜가null이어야함-->
	
	<button type="button" data-bs-target="#matchChk" data-bs-toggle="modal" id="match"  class="${not(match.match_yn eq 'N' && match.match_date eq null)? 'hide': ''}">매칭 하기</button>
	
	
	
	<!-- 매칭취소하기 -->
	<!-- 보이는 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이전이어야한다 -->
	
	<button type="button" data-bs-target="#matchCancleChk" data-bs-toggle="modal" id="unmatch" class="${not(match.match_yn eq 'Y' && unmatchYN eq'Y')? 'hide': ''}" >매칭 취소</button>
	
	
	
	<!-- 매칭완료 -->
	<!-- 보이는 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이후 -->
	<button id="matched" disabled="true" class="${not(match.match_yn eq 'Y' && unmatchYN eq'N')? 'hide': ''}">매칭 완료</button>
	
	
	<!-- 후기쓰기 -->
	<button type="button" onclick="review()" id="review">후기 쓰기</button>
	<%-- <button type="button" onclick="review()" id="review" disabled="${not(ableRv eq 'Y')? 'true': 'false'}">후기 쓰기</button> --%>
	<!-- 신고하기버튼  -->
	<button data-bs-target="#reportForm" data-bs-toggle="modal" id="report" >신고하기</button>
	
	
	
<!-- chatRoom의 Body--------------------------------------------------------------------------------------------- -->

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
			<span id="sendermsg" class="rounded-pill"><strong>${premessage}</strong></span>
		</div>
	</c:if>
	
	<!-- 상대방 메세지 창 -->
	<c:if test="${presender!=myidx}">
		<div class='well text_left'>
			<span id="recieverphoto"><img src="${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}" class="m_photo"></span>
			<span id="recievermsg" class="rounded-pill">${recieverInfo.m_nm} -> ${premessage}</span>
			<span>${c.sent}</span>
		</div>
	</c:if>	
	
	
</c:forEach>	

</div>


<br>보내는 사람 : ${myidx} 받는사람 : ${reciever}<br>
	
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
	



<!-- 확인모달들 여기 모아둠--------------------------------------------------------------------------------------------- -->
<!-- 채팅 나감 모달 -->
		<div class="modal fade" id="leaveChk" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
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



<!-- 매칭 확인  -->
	<div class="modal fade" id="matchChk" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		    
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		      </div>
		      
		      <div class="modal-body">
		        <h3>${reciever}님과 매칭하시겠습니까?</h3>
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
		         ${recieverInfo.m_nm}님과 매칭 취소하시겠습니까?<br>
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
		         	<div>실거래를 진행한 경우에만 리뷰를 작성해주세요. 허위 또는 악의적 리뷰는 이용에 제한이 있을 수 있습니다.</div>
		         	<div>멘토 정보 :  ${recieverInfo.m_nm} 
		         		<span><img src="${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}" class="m_photo"></span>
		         	</div>
		         	<div>별점
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
						<textarea class="form-control" rows="5" id="comment" name="text" ></textarea>
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
			                <input type="radio" class="form-check-input" name="input-type" value="add">서비스와 관련없는 광고/홍보
			              </label>
			            </div>
			            <div class="form-check">
			              <label class="form-check-label">
			                <input type="radio" class="form-check-input" name="input-type" value="assert">부적절한 언어(욕설/성희롱 등) 사용
			              </label>
			            </div>
			            <div>서비스 진행중 문제가 생겼다면 증빙자료(대화내역, 문자메세지, 녹취, 사진 등)과 함께 알려드림 이메일 admin1@aljdream.com으로 접수해주세요. 신고 결과는 별도안내되지 않습니다.</div>
		            
		      </div>
		      
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" data-bs-target="#confirm" data-bs-toggle="modal">신고접수</button>
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">삭제</button>
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
		        <button type="button" class="btn btn-secondary" data-bs-target="#reportForm" data-bs-toggle="modal">한번 더 확인하겠습니다</button>
		      </div>
		    </div>
		  </div>
		</div>

<!-- --------------------------------------------------------------------------------------------------------------------------- -->
<script>

	  
	$(document).ready(function(){
		 	
		 
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
						gone();
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
		
		// 채팅창나감을 알림
		function gone(){
			
			var msgMsg = (${myname}'님이 채팅방을 나가셨습니다.');
			console.log(msgMsg);
			
			sendMngMessage(mngMsg);
		}
		
		// 매칭하기 확인 누를때
		$("#matchY").on('click',function(){
			// ajax로 matchyn y으로 update
			var matchYN = 'Y';
			
			matchUpdate(matchYN);
			
			document.getElementById("match").style.display="none";
			document.getElementById("unmatch").style.display="inline-block"; 
			
			// ${reciever}님과 ${myidx}님이 매칭되었습니다! 화면에 채팅으로 올라간다(중앙에)
			matchSuccess();
		})
		
		
		// 매칭취소 확인 누를때
		$('#matchCancleY').on('click', function(){
			
			var matchYN = 'N';
			
			matchUpdate(matchYN);
			
			document.getElementById("match").style.display="inline-block";
			document.getElementById("match").disabled = true;
			document.getElementById("unmatch").style.display="none";
			 
			// ${reciever}님과  ${myidx}님의 매칭이 취소되었습니다. 화면에 채팅으로 올라간다(중앙에)
			matchCancle();
		});
		
		
		
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
			
		}

		// 매칭취소를 알림
		function matchCancle(){
			
			var msgMsg = (${myname}+'님과'+${recieverInfo.m_nm}+'님의 매칭이 취소되었습니다! 더이상의 매칭이 불가합니다.');
			console.log(msgMsg);
			
			sendMngMessage(mngMsg);
		}
		
		// 매칭성사를 알림
		function matchSuccess(){
			
			var msgMsg = (${myname}+'님과'+${recieverInfo.m_nm}+'님의 매칭이 성사되었습니다!');
			console.log(msgMsg);
			
			sendMngMessage(mngMsg);
		}
		
		
		// 별점 작성시 함수
		$(':radio').change(function() {
			  console.log('New star rating: ' + this.value);
			});
		
		
		// 리뷰버튼 눌렀을 때
		function review(){
			console.log('오긴함');
			<!-- 후기등록 조건 : 매칭여부 Y && 매칭날짜가 현재보다 3일이후 -->
			
			if(!((${match.match_yn eq 'Y'}) && (${unmatchYN eq 'N'}))){
				alert('후기 등록은 매칭일 3일이 지나고부터 가능합니다.');
			}else{
				$('#reviewform').modal('show');
			}
		}

		
		// 리뷰 등록시
		 $('#regReview').on('click',function(){
			var rating = $('#rate:checked').val();
			console.log(rating);
			var comment = $('#comment').val();
			console.log(comment);
			$.ajax({
				url : '${pageContext.request.contextPath}/review/regreview',
				type : 'POST',
				data : {
					rating : rating,
					comment : comment,
					matchidx : ${matchidx}
				},
				success : function(data){
					if(data==1){
						alert('리뷰가 등록되었습니다');
						document.getElementById("review").disabled = true;
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
		
		
		
		
		// 신고접수를 눌렀을 시
		 $("#sendReport").click(function(){
				
			var content = $('.form-check-input:checked').val();
		
			console.log(content);
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
						alert('하루에 신고 가능한 횟수(5회)를 초과히였습니다.');
					}
				}, 
				error : function(){
					console.log('비동기통신 오류');
				}
			})
		})
	
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
		}
	});
    
    
    
	// 채팅관련 함수------------------------------------------------------------------------------------------------
	
	// 채팅관련 ------------------------------------------------------------------------------
	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/echo"/>");


	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onerror = onError;
	
	
	function sendMessage() {
		//websocket으로 메시지를 보내기
		
		// 현재 시간
		var today = new Date();
		var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
		
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

	
	
	function sendMngMessage(mngMsg) {
		// 매니저메세지
		
		var msg = {
			reciever : ${reciever},
			matchidx : ${matchidx},
			message : mngMsg,
			role : 'system'
		};
		console.log(msg);
		console.log('매니저메세지발송');
		sock.send(JSON.stringify(msg));
	};

	
	

	function onOpen(){
		console.log('Info : connection opened');
		
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
		var recievernm = '${recieverInfo.m_nm}';

		console.log('current session id: ' + currentuser_session);
		
		
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
				printHTML += "<span id='recieverphoto'><img src="${pageContext.request.contextPath}/resources/files/member/${recieverInfo.m_photo}" class="m_photo"></span>";
				printHTML += "<span id='recievermsg' class='rounded-pill'>" + recievernm + "-> " + msgData.message +"</span>";
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