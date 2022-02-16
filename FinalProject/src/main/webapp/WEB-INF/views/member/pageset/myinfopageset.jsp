<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>


var interestArr=[];

$(document).ready(function(){
		
		$('#addCat, #editinteresticon').on('click',function(){
			
				
				
				getCategoryList();
			
		})
		
		
		
		$('.modal-footer').on('click','#next',function(){
		
			if($('#interestInfos input[name=interest]:checked').length==0){
				$('#interestInfos').after('<div id="msgarea" class="text-center"><span>1개 이상의 관심분야를 선택해주세요</span></div>');
			}else{
				
				$('#interestInfos input[name=interest]:checked').each(function(index, item){
					
					if($(item).siblings('.childNodesCount').text()==0){
						
						/* var interest={
								m_idx:${principal_idx},
								cat_idx:$(item).val()
						} */
						
						interestArr.push($(item).val());
					}	
					
				})
				console.log('배열요소를 출력합니다. 선택한 카테고리의 자식노드가 없을 때만 추가됩니다.');
				console.log(interestArr);
				
				getCategoryList();	
			}
		
		})
		
		$('.modal-footer').on('click','#close-modal',function(){
			$('#interestInfos').html('');
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
		
		$('#editphoto').on('change',function(e){
			var reader = new FileReader();
			
			reader.readAsDataURL(e.target.files[0]);
			
			
			$(reader).on('load',function(e){
				
				
				
				$('#myprofile').attr('src',e.target.result);
				
				setTimeout(function(){
					if(confirm('프로필 사진을 수정하시겠습니까?')){
						// aJax codes
						var formData=new FormData();
						formData.append('photo',$('#editphoto')[0].files[0]);
						editInfo(formData);
						/////////////
					}else{
							$('#myprofile').attr('src','${pageContext.request.contextPath}/resources/files/member/${info.m_photo}');
							$('#editprofile').val('');
					}
				},200);
				
				
			})
			
			
		})
		
		
		$('#namearea').on('click','#editnameicon',function(){
			var html='';
			html+='<input type="text" class="form-control" placeholder="별명" id="nameinput" value="${info.m_nm}">\r\n';
			html+='<button type="button" class="btn btn-grey ms-1" id="editiconbtn">수정</button>\r\n';
			html+='<button type="button" class="btn btn-danger" id="canceleditnamebtn">취소</button>\r\n';
			$('#namearea').html(html);	
		})
		
		$('#namearea').on('click','#editiconbtn',function(){
			// 별명 수정 ajax 
			
			if(confirm('정말로 수정하시겠습니까?')){
				console.log($('#nameinput').val());
				var formData= new FormData();
				formData.append('m_nm',$('#nameinput').val());
				editInfo(formData);
			}
			
		})
		
		$('#namearea').on('click','#canceleditnamebtn',function(){
			$('#namearea').html('<h3 class="fw-normal fs-4">${info.m_nm}<i class="bi bi-wrench mx-1" id="editnameicon"></i></h3>\r\n');
			
		})
		
		//editpw
		$('#editPwBtn').on('click',function(){
			
			var valid=true;
			
			$('#securityinfos input[type=password]').each(function(index, item){
				
				if($(item).val().indexOf(' ')>=0){
					$(item).next('.warning').text('* 공백은 사용할 수 없습니다').addClass('visible').removeClass('invisible');
					vailed=false;
					return false;
				}else if($(item).val().trim().length==0){
					$(item).next('.warning').text('* 비밀번호를 입력해주세요').addClass('visible').removeClass('invisible');
					vailed=false;
					return false;
				}else if($('#newPw').val() != $('#repw').val()){
					$('#repw').next().text('*비밀번호가 일치하지 않습니다').addClass('visible').removeClass('invisible');
					vailed=false;
				}
			})
			
			if(valid){
				
				if(confirm('비밀번호를 수정하시겠습니까?')){
					
					var formData=new FormData();
					formData.append('m_password',$('#newPw').val());
					editInfo(formData);
				}
				
			}
			
			
			
		})
		
		$('#securityinfos input[type=password]').on('focus',function(){
			$('.warning').removeClass('visible').addClass('invisible');
		})
		
		
		// 회원 정보 (프로필사진, 닉네임, 관심분야) <> 보안 설정(비밀번호) 스위칭 기능
		$('#switchSettings').on('change',function(){
			if($(this).is(':checked')){
				// 보안 설정 옵션 보여줌
				$('#securityinfos').removeClass('d-none');
				$('#infos').addClass('d-none');
				// 텍스트 하이라이팅
				$(this).parent().next().addClass('u_txt_chk');
				$(this).parent().prev().removeClass('u_txt_chk');
				
			}else{
				$('#infos').removeClass('d-none');
				$('#securityinfos').addClass('d-none');
				$(this).parent().prev().addClass('u_txt_chk');
				$(this).parent().next().removeClass('u_txt_chk');
			}
		})
	
		$('#quitlink').on('click',function(){
			location.href='${pageContext.request.contextPath}/member/quit';
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
			// 더 이상의 자식 노드가 없다면 회원의 관심사를 수정한다.
			if(data.length==0){
				
				editCategory(interestArr);
				
				
			}else{
			//////////////////////////////////////////
			// 노드가 있다면 추가 선택을 한다.
			var html="";
			$(data).each(function(index, items){
				
				
				html+= '<div class="input-group justify-content-center my-4">\r\n';
					html+= '<label for="interest'+items.cat_idx+'">\r\n';
						html+='<img src="${pageContext.request.contextPath}/resources/files/server/icons/check_off.svg">\r\n';
						html+='<span class="d-none">'+items.cat_idx+'</span>\r\n';
						html+='<span>'+items.cat_nm+'</span>\r\n';
					html+='</label>\r\n';
					html+='<span class="childNodesCount d-none" style="color:red">'+items.childNodeCount+'</span>\r\n';
					html+='<input type="checkbox" id="interest'+items.cat_idx+'" name="interest" class="interest d-none" value="'+items.cat_idx+'">\r\n';
				html+='</div>\r\n';
			
			
					
			})
			
				$('#interestInfos').html(html);
				
			}
			
		},
		error: function(data){
			console.log(data);
		}
	})
	
}


function editCategory(data){
	console.log(JSON.stringify(data));
	
	$.ajax({
		
		url:"${pageContext.request.contextPath}/member/edit/interest",
		type:'POST',
		data: JSON.stringify(data),
		contentType:'application/json',
		success:function(data){
			console.log('통신완료');
			
			if(data>0){
				alert('등록이 완료되었습니다');
				location.href='${pageContext.request.contextPath}/member/myinfo';
			}
		},
		error:function(data){
			console.log('통신에러');
		}
		
	})
	
}

function editInfo(data){
	
	$.ajax({
		url:'${pageContext.request.contextPath}/member/info/edit',
		type:'POST',
		data:data,
		contentType:false,
		processData:false,
		cash:false,
		enctype:'multipart/form-data',
		success:function(data){
			console.log('통신성공');
			if(data>=1){
				alert('정상적으로 수정되었습니다');
				location.href='${pageContext.request.contextPath}/member/myinfo';		
			}else{
				alert('오류가 발생하였습니다. 잠시 후 다시 시도하세요');
			}

		},
		error:function(data){
			
			console.log('통신실패');
			alert('오류가 발생하였습니다. 잠시 후 다시 시도하세요');
			
		}
	})
	
}

</script>