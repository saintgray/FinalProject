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

	
	/* 윗부분 */
	
	
	
	article{
		margin-top: 150px;
		margin-bottom: 80px;
		padding-left: 100px;
		padding-right: 100px;
	}
	.post{
		background-color: #FFD601;
		height: 250px;
		width : 70%;
		margin-left: auto;
		margin-right: auto;
		margin-bottom: 30px;
		padding : 30px 30px 30px 30px; 
	}
	#goPostBtn{
		font-size : 1.1em;
		font-weight: 200;
		color : #E1DEE6;
		width: 120px;
    	height: 35px;
	}
	
	.post-regdate{
		float : right;
		color : #142B6F;
		font-size: 1.2em;
	}
	.post-title{
		font-size: 2.25em;
		font-weight: bold;
		margin : 30px 0px 20px 0px;
	}
	.post-cat{
		font-size: 1.8em;
		font-weight: 550;
	}
	
	/* 중앙부분 */
	.rqMemList{
		width : 70%;
		margin : 0 auto;
		padding : 10px 8% 10px 8% ; 
	}
	.memTable{
		border-collapse: separate;
  		border-spacing: 0 7px;
  		
	}
	.oneMember{
		padding : 15px 0px 15px 0px;
		border-bottom: 1pt solid #E1DEE6;
	}
	.m_photo{
		width:110px;
		height:110px;
		border-radius: 50%;
	}
	.rqMname{
		padding : 0px 5px 0px 15px;
		font-size: 1.625em;
		font-weight: bold;	
	}
	#goChat{
		background-color: #142B6F!important;
		height: 30px;
		vertical-align: baseline;
		padding : 0px 6px 0px 6px;		
	}
	

</style>
 
</head>
<body>


<!-- 현 로그인 정보 -->

<sec:authorize access="isAuthenticated()">
	<c:set var="myidx">
		<sec:authentication property="principal.m_idx"/>
	</c:set>
	<c:set var="mytype">
		<sec:authentication property="principal.m_type"/>
	</c:set>
</sec:authorize>


<div class="gw">

	<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	<article >
	
			<div class="post" id="rqpost">
				<button type="button" class="btn btn-light" id="goPostBtn">
					<a href="${pageContext.request.contextPath}/post/view?idx=${requestPost.post_idx}">작성 게시글 </a>
				</button>
				<span class="post-regdate">${requestPost.post_regdate}</span>
				<div class="post-title">${requestPost.post_nm}</div>
				<div class="post-cat">${requestPost.cat_type} / ${requestPost.cat_nm}</div>
			</div>
			
			<div class="rqMemList">
				<c:forEach items="${requestPost.list}" var="member">
					<div class="oneMember">	
						<table class="memTable">
							<tr>
								<td rowspan="3"><input type="hidden" class="matchidx" value="${member.match_idx}"> </td>
								<td rowspan="3" class="midxRow"><input type="hidden" id="rqM_idx" value="${member.m_idx}"/></td>
								<td rowspan="3">
									<img src="${pageContext.request.contextPath}/resources/files/member/${member.m_photo}" class="m_photo">
								</td>		
								<td>
									<span class="rqMname">${member.m_nm}</span>
									<button type="button" class="btn btn-light" id="goChat">
										<a style="color: white"  href="${pageContext.request.contextPath}/chat/chatroom?myidx=${myidx}&matchidx=${member.match_idx}&reciever=${member.m_idx}" >채팅 하기 </a>
									</button>
								</td>			
							</tr>
							<tr>
								<td>
									<c:if test="${mytype eq 'mentee'}">
										<span style="padding-left: 15px; font-weight: 500;">프로필소개 : ${member.line}</span>
									</c:if>
								</td>		
							</tr>
							<tr>	
								<td >후기 가져오면 좋을듯..?</td>		
							</tr>
						</table>
					</div>	
				</c:forEach>
			</div>
	
	</article>


</div>

  
  <%@include file="/WEB-INF/views/layout/footer.jsp" %>
		
	
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
		
	$('#deleteReq').on('click',function(){
		
		var info='';
		info+='정말로 문의한 회원을 삭제하시겠습니까?\r\n';
		info+='<br>\r\n';
		info+='삭제한 회원은 채팅목록에서도 삭제됩니다.';
		info+='<span id="target-mat-idx" style="color:red">'+$(this).parent().siblings('.mat-idx').children('#matchidx').val()+'</span>';
		
		$('#deleteConfirm .modal-body').html(info);
			
	})
	
		// 회원삭제 눌렀을 시
		$("#deleteMatch").on('click',function(){
			
			
			var match_idx=$('#target-mat-idx').text();
	        	
			
			console.log(${member.match_idx})
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
		})
	
	//-------------------------------------------post view에합쳐야하는 내용
	
	
		
});

</script>
	
	


</body>

</html>