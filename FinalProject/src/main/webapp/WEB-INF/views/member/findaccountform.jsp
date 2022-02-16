<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findaccount.css">
<title>회원정보 찾기</title>
</head>
<body>	

	<div class="gw">
		<%@ include file="/WEB-INF/views/layout/header.jsp" %>
		
		<div id="findaccountarea">
			
			<h1 class="banner">비밀번호 찾기</h1>
		
			<div class="my-4">
				<input type="text" class="form-control" placeholder="이메일" id="email">
				<div id="fb" class="warning invalid-feedback">
					  
				</div>
			</div>
			<div class="descript">가입 시 등록하신 이메일을 입력해주세요</div>
			
			
			
			<div class="d-flex justify-content-center my-5">
				<button type="button" class="btn btn-general" id="findMe">확인</button>
			</div>		
		
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
	<script>
		$(document).ready(function(){
			$('#findMe').on('click',function(){
				console.log($('#email').val().indexOf('@'));
				if($('#email').val().indexOf(' ')>=0 || $('#email').val().indexOf('@')==-1){
					showWarning($('#email'),'*올바른 이메일 주소를 입력하세요');
				}else if($('#email').val().trim().length==0){
					showWarning($('#email'),'*이메일을 입력해주세요');
				}else{
					var data={
						m_email_prefix:$('#email').val().substring(0,$('#email').val().indexOf('@')),
						m_email_suffix:$('#email').val().substring($('#email').val().indexOf('@')+1)
					}
					
					console.log(data);
						$.ajax({
							url:'${pageContext.request.contextPath}/chk_email',
							type:'POST',
							data:data,
							success:function(data){
								console.log(data);
								if(data=='ABLEREGISTER'){
									showWarning($('#email'),'*계정 정보가 없습니다 이메일을 다시 확인하세요');
								}else{
									
									$.ajax({
										url:'${pageContext.request.contextPath}/findaccount',
										type:'POST',
										data:{email:$('#email').val().trim()},
										success:function(data){
											if(data==1){
												alert('등록하신 계정으로 이메일을 발송했습니다');
											}else{
												alert('오류가 발생하였습니다 잠시 후 다시 시도하세요');
											}
											
										},
										error:function(data){
											console.log(data);
											alert('오류가 발생하였습니다 잠시 후 다시 시도하세요');
										}
									})
									
									
								}
							},
							error:function(data){
								alert('일시적인 오류가 발생하였습니다 잠시 후 다시 시도하세요');
								console.log(data);
							}
							
						})
						
				}
				
			})
			
			$('#email').on('focus',function(){
				$(this).removeClass('is-invalid');
				$('#fb').text(' ');
			})
			
		})
		
		
		function showWarning(dom, msg){
			$(dom).addClass('is-invalid');
			$('#fb').text(msg);
		}
	
	</script>
</html>