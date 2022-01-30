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
#infoswrap{
	
}

</style>
</head>
<body>
<%@ include file="/WEB-INF/views/defaultpageset.jsp" %>

<!-- Header -->
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	
	
<!-- Register body area -->
<div id="regGlobalWrap" class="container">	

    <div class="d-flex flex-column" id="infoswrap">

        <div class="input-group my-4">
            <input type="text" name="m_email" class="form-control" placeholder="아이디" aria-label="Username">
            <span class="input-group-text">@</span>
            <input type="text" name="?????" class="form-control" placeholder=".com" aria-label="Server">
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
	
	
	<div id="interestInfosWrap">
		<div class="d-flex flex-column" id="interestInfos">
		
		
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
		<div id="btncontroller">
			<input type="button" value="건너뛰기" id="skip">
			<input type="button" value="다음" id="next">
		</div>	
	</div>
	
	
	
	
	
	

</div>


</body>
<script>
	$(document).ready(function(){
		
		getCategoryList();
		
		
		
		$('#btncontroller').on('click','#next',function(){
			getCategoryList();
		})
		
		
		$('#interestInfos').on('change','.interest',function(){
			
			var checkbox_img=$(this).siblings('label').children('img');
			
			if($(this).prop('checked')){
			
				$(checkbox_img).attr('src','${pageContext.request.contextPath}/resources/files/server/icons/check_on.svg');
				$('#userinterestselect').append($('<input type="checkbox" name="interest" class="interest" value="'+$(this).val()+'">\r\n'));
				
			}else{	
				
				$(checkbox_img).attr('src','${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg');
				$('#userinterestselect input[value='+$(this).val()+']').remove();
				
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
	
	function getCategoryList(){
		var interest=$('#interestInfos input[name=interest]:checked');
		console.log(interest);
		$.ajax({
			url: "${pageContext.request.contextPath}/category/list",
			type:"GET",
			data: interest,
			datatype:"json",
			success: function(data){
				console.log(data.length);
				// 더 이상의 자식 노드가 없다면 기본정보 입력란을 보여준다.(아직 작업중)
				//if(data.length==0){
				//	showBasicInfosForm();
				//}
				//////////////////////////////////////////
				// 노드가 있다면 추가 선택을 한다.
				var html="";
				$(data).each(function(index, items){
					console.log(items.cat_idx);
					console.log(items.cat_nm);
					
					html+= '<div class="input-group">\r\n';
					html+= '<label for="interest'+items.cat_idx+'">\r\n';
						html+='<img src="${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg">\r\n';
						html+='<span class="hidden">'+items.cat_idx+'</span>\r\n';
						html+='<span>'+items.cat_nm+'</span>\r\n';
					html+='</label>\r\n';
					html+='<input type="checkbox" id="interest'+items.cat_idx+'" name="interest" class="interest" value="'+items.cat_idx+'">\r\n';
				html+='</div>\r\n';
				
				
				
				
				})
				
				$('#interestInfos').html(html);
				
				
				
			},
			error: function(data){
				console.log(data);
			}
		})
		
	}
	
	function showBasicInfosForm(){
		
		
	}

</script>
</html>