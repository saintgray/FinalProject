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
.hidden{
	display: none;
}
#basicInfos{
	display:none;
}
#interestInfos{
	min-height: 400px;
	background-color: rgb(245,245,245);
	border-radius: 10px;
}
#btncontroller, #regbtncontroller{
    padding: 10px 0;
    margin-bottom: 100px;
    margin-top: 20px;
}
#loading{
	width:50px;
	height:50px;
}
#interestInfosWrap{
	text-align: center;
}
#msgarea{
	color:#FFD601;
	font-weight:light;
}


</style>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	
	
<!-- Register body area -->
<div id="regGlobalWrap" class="container">
	<div class="banner">
		관심분야를 선택하세요!
	</div>

	<div id="basicInfos">
	
		    <div class="d-flex flex-column justify-content-center" id="infoswrap">
		
		        <div class="input-group my-4">
		            <input type="text" name="m_email_prefix" class="form-control" placeholder="이메일" aria-label="Username">
		            <span class="input-group-text">@</span>
		            <input type="text" name="m_email_suffix" class="form-control" placeholder="examples.com" aria-label="Server">
		            <input type="button" id="chk_email" value="이메일 중복 확인">
		        </div>
		        
		        <div class="input-group my-4">
		            <input type="password" name="m_password" class="form-control" placeholder="비밀번호" aria-label="Password">
		        </div>
		        <div class="input-group my-4">
		            <input type="password" class="form-control" placeholder="비밀번호 확인" aria-label="Password">
		        </div>
		        
		        <div class="input-group my-4">
		            <input type="password" name="m_nm" class="form-control" placeholder="닉네임" aria-label="Name">
		        </div>
		        
		        <div id="userinterestselect">
		        	
		        </div>
		        	      
			</div>
			
			<div id="regbtncontroller" class="d-flex flex-row justify-content-around">
				<button  type="button" class="btn btn-grey" id="authemailbtn">이메일 인증</button>
				<button  type="button" class="btn btn-general" id="registerbtn" disabled>회원가입</button>
			</div>
			<div id="insertAuthKeyArea" class="d-flex flex-row justify-content-center">
				<input type="text" class="input-group form-control" id="insertedKey" value="인증번호 입력">
				<button type="button" class="btn btn-grey" id="checkAuthKey">인증</button>
			</div>
	</div>
	
	
	<div id="interestInfosWrap">
		<div class="d-flex flex-column justify-content-around" id="interestInfos">
		
		
			<!-- 
			
			DB 에서 카테고리를 가져와서 each 문을 사용하여 이 밑의 내용을 출력한다. 
			
			<div class="input-group">
				<label for="interest">
					<img src="${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg">
					<span class="hidden">DB에서 카테고리 타입이 취미인 모든 카테고리를 가져와서 이 span 태그에 그 카테고리의 idx를 넣는다.</span>
					<span> DB에서 카테고리 타입이 취미인 모든 카테고리를 가져와서 이 span 태그에 그 카테고리의 이름을 넣는다</span>
				</label>
				<input type="checkbox" id="interest" name="interest" class="hidden interest" value="DB에서 가져온 카테고리 idx">
				
				
			</div>
			
			-->
		
		</div>
		
		<div class="d-flex flex-row justify-content-around" id="btncontroller">
			<button type="button" class="btn btn-grey" id="skip">건너뛰기</button>
			<button type="button" class="btn btn-general" id="next">다음</button>
		</div>
		
	</div>
	
	
	
	
	
	

</div>


</body>
<script>
	$(document).ready(function(){
		
		getCategoryList();
		
		
		
		$('#btncontroller').on('click','#next',function(){
			if($('#interestInfos input[name=interest]:checked').length==0){
				$('#interestInfos').after('<div id="msgarea"><span>1개 이상의 관심분야를 선택해주세요</span></div>');
			}else{
				getCategoryList();	
			}
			
		})
			
		$('#btncontroller').on('click','#skip',function(){
			showBasicInfosForm();
		})
		
		$('#authemailbtn').on('click',function(){
			
			var infos={
					m_email_prefix: $('input[name=m_email_prefix]').val(),
					m_email_suffix: $('input[name=m_email_suffix]').val()
			}
			
			$.ajax({
				url: "${pageContext.request.contextPath}/sendAuthKey",
				data: infos,
				type: "POST",
				success:function(data){
					console.log(data);					
				},
				error:function(data){
					console.log(data);
				}
				
			})
			
		})
		$('#checkAuthKey').on('click',function(){
			var insertedKey={insertedKey: $('#insertedKey').val()}
			$.ajax({
				url:"${pageContext.request.contextPath}/chkAuthKey",
				type:"POST",
				data:insertedKey,
				success:function(data){
					console.log("통신성공");
					console.log(data);
				},
				error:function(data){
					console.log("통신실패");
					console.log(data);
				}
			})
			
		})
		
		
		$('#interestInfos').on('change','.interest',function(){
			
			var checkbox_img=$(this).siblings('label').children('img');
			
			if($(this).prop('checked')){
				$('#msgarea').remove();
				$(checkbox_img).attr('src','${pageContext.request.contextPath}/resources/files/server/icons/check_on.svg');
				$('#userinterestselect').append($('<input type="checkbox" name="interest" class="interest" value="'+$(this).val()+'">\r\n'));
				
			}else{	
				
				$(checkbox_img).attr('src','${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg');
				$('#userinterestselect input[value='+$(this).val()+']').remove();
				
			}
			
			
		})
		
	
		
		$('#chk_email').on('click',function(){
			
			var infos={
					m_email_prefix: $('input[name=m_email_prefix]').val(),
					m_email_suffix: $('input[name=m_email_suffix]').val()
			}
			console.log(infos);
			
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
	
	function getCategoryList(){
		var interest=$('#interestInfos input[name=interest]:checked');
		console.log(interest);
		$('#interestInfos').after('<img src="${pageContext.request.contextPath}/resources/files/server/icons/loading/loading.svg" id="loading">');
		
		$.ajax({
			url: "${pageContext.request.contextPath}/category/list",
			type:"GET",
			data: interest,
			datatype:"json",
			success: function(data){
				console.log(data.length);
				// 더 이상의 자식 노드가 없다면 기본정보 입력란을 보여준다.(아직 작업중) / 작업완료
				if(data.length==0){
					showBasicInfosForm();
				}else{
				//////////////////////////////////////////
				// 노드가 있다면 추가 선택을 한다.
				var html="";
				$(data).each(function(index, items){
					console.log(items.cat_idx);
					console.log(items.cat_nm);
					
					html+= '<div class="input-group justify-content-center my-4">\r\n';
						html+= '<label for="interest'+items.cat_idx+'">\r\n';
							html+='<img src="${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg">\r\n';
							html+='<span class="hidden">'+items.cat_idx+'</span>\r\n';
							html+='<span>'+items.cat_nm+'</span>\r\n';
						html+='</label>\r\n';
						html+='<input type="checkbox" id="interest'+items.cat_idx+'" name="interest" class="interest hidden" value="'+items.cat_idx+'">\r\n';
					html+='</div>\r\n';
				
				
				
				
				})
				
					$('#interestInfos').html(html);
					$('#loading').remove();
				}
				
			},
			error: function(data){
				console.log(data);
			}
		})
		
	}
	
	function showBasicInfosForm(){
		$('#regGlobalWrap .banner').text('기본정보');
		$('#interestInfosWrap').css('display','none');
		$('#basicInfos').css('display','block');
		
		
	}

</script>
</html>