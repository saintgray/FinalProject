<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>
#newPwArea{
	max-width: 500px;
	margin-top: 150px;
}
#w_pw,#w_repw{
	min-height: 40px;
}

</style>
<title>비밀번호 변경</title>

</head>
<body>

<div class="gw">
	<%@include file="/WEB-INF/views/layout/header.jsp" %>

	<div class="text-center mx-auto" id="newPwArea">
			
			<div class="d-flex flex-column justify-content-center">
				
					
				
				<input type="password" class="form-control my-1 mx-auto" placeholder="새 비밀번호" id="newPw">
				<div id="w_pw">
					<span class="warning fw-normal text-center invalid-feedback"></span>
				</div>
				
				
				<input type="password" id="repw" class="form-control my-1 mx-auto" placeholder="비밀번호 확인">
				<div id="w_repw">
					<span class="warning fw-normal text-center invalid-feedback"></span>
				</div>
				
				<div class="d-flex justify-content-center">
					<button type="button" class="btn btn-general" id="editPwBtn">비밀번호 수정</button>
				</div>
			</div>
			
	</div>

</div>


<%@include file="/WEB-INF/views/layout/footer.jsp" %>

</body>

<script>
$(document).ready(function(){

	$('#editPwBtn').on('click',function(){
		
		var valid=true;
		
		$('#newPwArea input[type=password]').each(function(index, item){
			
			if($(item).val().indexOf(' ')>=0){
				$(item).addClass('is-invalid');
				$(item).next().children('.invalid-feedback').text('* 공백은 사용할 수 없습니다').css('display','block');
				valid=false;
				return false;
			}else if($(item).val().trim().length==0){
				$(item).addClass('is-invalid');
				$(item).next().children('.invalid-feedback').text('* 비밀번호를 입력해주세요').css('display','block');
				valid=false;
				return false;
			}else if($('#newPw').val() != $('#repw').val()){
				$('#repw').next().children('.invalid-feedback').text('*비밀번호가 일치하지 않습니다').css('display','block');
				valid=false;
			}
			
		})
		
		if(valid){
			
			if(confirm('비밀번호를 수정하시겠습니까?')){
				
				var formData=new FormData();
				
				//console.log($('#newPw').val());
				formData.append('newPw',$('#newPw').val());
				formData.append('keycode','${param.keycode}');
				
				$.ajax({
					url:'${pageContext.request.contextPath}/resettingpassword',
					type:'POST',
					processData:false,
					contentType:false,
					cash:false,
					enctype:'multipart/form-data',
					data:formData,
					success:function(data){
						console.log('통신성공');
						console.log(data);
						if(data==1){
							alert('비밀번호가 수정되었습니다 보안을 위해 비밀번호를 재설정하세요');
							location.href='${pageContext.request.contextPath}/member/loginform';
							
						}else if(data==-1){
							// 해당 keycode를 가진 사람이 없음 >> 스케쥴러로 인해 member의 tempcode 를 비운 뒤임
							alert('전송된 이메일의 유효기간이 만료되었습니다');
							location.href='${pageContext.request.contextPath}/member/loginform';
						}else{
							alert('오류가 발생하였습니다 잠시 후 다시 시도해주세요')
						}
					},
					error:function(data){
						console.log('통신실패');
						console.log(data);
					}
						
				})
			}
			
		}	
	})
	
	
	$('input').on('focus',function(){
		$(this).removeClass('is-invalid');
		$(this).next().children('.invalid-feedback').css('display','none');
		
	})

})


</script>
</html>