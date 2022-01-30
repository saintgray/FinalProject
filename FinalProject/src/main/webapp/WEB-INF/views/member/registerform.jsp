<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
input{
display: block;
}
#regGlobalWrap{
	margin-top: 100px;
	width: 500px;
}

label img{
	vertical-align: text-bottom;
}
label span{
	font-size: 20px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	
	
<!-- Register body area -->
<div id="regGlobalWrap" class="container">	

    <div class="d-flex flex-column">

        <div class="input-group my-4">
            <input type="text" name="m_email" class="form-control" placeholder="아이디" aria-label="Username">
            <span class="input-group-text">@</span>
            <input type="text" name="?????" class="form-control" placeholder=".com" aria-label="Server">
        </div>
        
        <div class="input-group mt-4 mb-4">
            <input type="password" name="m_password" class="form-control" placeholder="비밀번호" aria-label="Password">
        </div>
        <div class="input-group mt-4 mb-4">
            <input type="password" class="form-control" placeholder="비밀번호 확인" aria-label="Password">
        </div>
        
        <div class="input-group mt-4 mb-4">
            <input type="password" name="m_nm" class="form-control" placeholder="닉네임" aria-label="Name">
        </div>

      
	</div>
	
	
	
	<div class="d-flex flex-column">
	
	
		<!-- DB 에서 카테고리를 가져와서 each 문을 사용하여 이 밑의 내용을 출력한다. -->
		<div class="input-group">
			<label for="interest">
				<img src="${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg">
				<span class="hidden">DB에서 카테고리 타입이 취미인 모든 카테고리를 가져와서 이 span 태그에 그 카테고리의 idx를 넣는다.</span>
				<span> DB에서 카테고리 타입이 취미인 모든 카테고리를 가져와서 이 span 태그에 그 카테고리의 이름을 넣는다</span>
			</label>
			<input type="checkbox" id="interest" name="interest" class="hidden interest" value="DB에서 가져온 카테고리 idx">
		</div>
		<!-- ----------------------------------------------------- -->
	
		
	</div>
	
	<!-- 테스트용 form 태그 -->
	<form id="registerinfos">
			<input type="text" name="m_email" placeholder="아이디">
			<input type="password" name="m_password" placeholder="비밀번호">
			<input type="text" name="m_nm" placeholder="이름">
			<input type="checkbox" name="interest" value="음악">
			<input type="checkbox" name="interest" value="미술">
			<input type="checkbox" name="interest" value="요리">
			<input id="chk_email" type="button" value="이메일 중복확인">
			<input id="testregister" type="button" value="회원등록">
	</form>
	
</div>


</body>
<script>
	$(document).ready(function(){
		
		
		
		$('.interest').on('change',function(){
			console.log($(this).prop('checked'));
			
			if($(this).prop('checked')){
				$(this).siblings('label').children('img').attr('src','${pageContext.request.contextPath}/resources/files/server/icons/check_on.svg');
			}else{
				$(this).siblings('label').children('img').attr('src','${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg');
			}
			
			
		})
		
		$('#testregister').on('click',function(){
			
			var infos=$('#registerinfos').serialize();
			console.log(infos);
			
			$.ajax({
				url:"${pageContext.request.contextPath}/register",
				data: infos,
				type: 'POST',
				success: function(data){
					alert(data);
				},
				error: function(data){
					alert(data);
				}
				
			})
			
		})
		
		$('#chk_email').on('click',function(){
			
			var infos={
					m_email:$('input[name=m_email]').val() 		
			}
			
			
			$.ajax({
				url:"${pageContext.request.contextPath}/chk_email",
				data : infos,
				type: 'POST',
				success: function(data){
					alert(data);
					
				},
				error: function(data){
					alert(data);
				}
				
			})
		})
		
		
		
		
	})

</script>
</html>