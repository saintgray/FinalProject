<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/defaultpageset.jsp" %>
<style>

	#controlbtn{
		margin-top: 20px;
		margin-bottom:20px;
	}

	#profileshotarea{
		position: relative;
	}
	#myprofile{
		width:200px;
		height:200px;
		border-radius: 15px;
    	border: 2px solid rgba(59,59,59,0.1);
	}
	#infosarea{
		margin-top: 250px;
		min-width: 520px;
	}
	
	#cameraicon{
	    position: absolute;
	    right: 20px;
	    bottom: 5px;
	    cursor: pointer;
	}
	
	.fi-rr-camera:before {
	    content: "\f178";
	    font-size: 25px;
	    background-color: white;
	    padding: 7px;
	    border-radius: 15px 0 15px 0;
	    border: 2px solid rgba(59,59,59,0.1);
	}
	#interestarea{
		min-height: 100px;
		background-color: rgb(197,197,197);
		border-radius: 15px;
		max-width: 600px;
		
	}
	#addCat{
		width:50px;
		height:50px;
		cursor: pointer;
	}
	.bi-wrench{
		font-size: 14px;
		cursor:pointer;
	}
	#msgarea{
		color:#FFD601;
		font-weight:light;
	}
	#securityinfos input{
		width:400px;
	}
	#editPwBtn{
		width:135px;
	}
	.warning{
		color: red;
		font-size: 13px;
	}
	.u_txt_chk{
	
		text-decoration: underline;
		color:#FCA106;
		
	}
	#quitguide{
	    font-size: 13px;
	    margin-bottom: 10px;
	    padding-left: 10px;
	}
	#quitlink{
		color:#FCA106;
		cursor: pointer;
	}
</style>
<title>내 정보</title>
</head>
<body>
<c:set var="principal_idx">
	<sec:authentication property="principal.m_idx"/>
</c:set>



<div class="gw">

	<%@include file="/WEB-INF/views/layout/header.jsp" %>
	
	
	<div id="controlbtn" class="d-flex justify-content-center">
			<span class="mx-2 u_txt_chk">회원정보</span>
			<div class="form-check form-switch">
				<input class="form-check-input" type="checkbox" role="switch" id="switchSettings">		  
			</div>
			<span class="mx-2">보안설정</span>
	</div>
	
	
	<div class="d-flex flex-column justify-content-center" id="infosarea">
			
			
			<!--  회원 정보 란 -->
			<div class="my-auto" id="infos">
				
				
				<div class="d-flex flex-row justify-content-center container">
					
					<div id="profileshotarea">
						<img class="mx-3" src="${pageContext.request.contextPath}/resources/files/member/${info.m_photo}" id="myprofile">
						<!-- 수정 카메라 이미지가 위치/ 위치는 absolute  <img....>-->
						<label for="editphoto">
							<i id="cameraicon" class="fi fi-rr-camera"></i>
						</label>
						<input type="file" id="editphoto" style="display:none">
					</div>
					
			
					<div class="mx-3 d-flex flex-column justify-content-around">
						<div>
							<h3 class="fw-light fs-4">${info.m_email}</h3>
							
							<div id="namearea" class="d-flex flex-wrap input-group mb-3">
								<%-- <h3 class="fw-normal fs-4">${info.m_nm}<i class="fi fi-rr-pencil" id="editnameicon"></i></h3> --%>
								<h3 class="fw-normal fs-4">${info.m_nm}<i class="bi bi-wrench mx-1" id="editnameicon"></i></h3>
							</div>
							
							<h3 class="fw-normal fs-6 text-end" style="color:rgb(195,195,195)">가입일 : ${info.m_regdate}</h3>
						</div>
					</div>
					
					
				</div>
				
				
				<div class="my-4 d-flex flex-wrap flex-column justify-content-center container"  id="interestarea">
					
					<div>
						<!--  test -->
						<c:if test="${empty info.list}">
							<h3 class="text-center fw-normal fs-3 pt-2">관심분야가 없습니다</h3>
							<div class="text-center"><img class="my-2" src="${pageContext.request.contextPath}/resources/files/server/icons/icon_plus.png" id="addCat" data-bs-toggle="modal" data-bs-target="#modal-cat"/></div>
							
						</c:if>
						<c:if test="${not empty info.list}">
							<div class="d-flex flex-wrap flex-wrap">
								<div class="d-flex flex-wrap flex-grow-1">
									
									<c:forEach var="item" items="${info.list}">
										<span class="cidx fs-6 mx-2 d-none">${item.cat_idx}</span>
										<span class="cnm fs-6 mx-2">${item.cat_nm}</span>										
									
									</c:forEach>
								</div>
								<div id="editinteresticon" class="pe-2">
									<i class="bi bi-wrench mx-1" data-bs-toggle="modal" data-bs-target="#modal-cat"></i>
								</div>
							</div>
						</c:if>	
					</div>		
			
				</div>
				
			</div>
			
			<!--  보안정보 란 -->
			<div class="my-auto text-center d-none" id="securityinfos">
			
				<div class="d-flex flex-column justify-content-center">
					
						
					
					<input type="password" class="form-control my-1 mx-auto" placeholder="새 비밀번호" id="newPw">
					<div id="w_pw" class="warning fw-normal text-center invisible">\r\n
					</div>
					
					
					<input type="password" id="repw" class="form-control my-1 mx-auto" placeholder="비밀번호 확인">
					<div id="w_repw" class="warning fw-normal text-center invisible mb-5">\r\n
					</div>
					
					
					<button type="button" class="btn btn-general mx-auto my-2 input-group" id="editPwBtn">비밀번호 수정</button>
					
				</div>
			
			</div>
			
			
		
	</div>	
		
	
</div>



	
			<div class="modal fade" id="modal-cat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">관심분야를 선택하세요</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      
				      	<div id="interestInfosWrap">
							<div class="d-flex flex-column justify-content-around" id="interestInfos">
								<!-- DB에서 가져온 카테고리 내용이 들어갑니다. -->	
							</div>
							<div>
							</div>
						</div>
				       		
				      </div>
				      <div class="modal-footer d-flex flex-wrap justify-content-around">
				        <button type="button" class="btn btn-grey" data-bs-dismiss="modal" id="close-modal">취소</button>
				        <button type="button" class="btn btn-general" id="next">다음</button>
				      </div>
				    </div>
				</div>	
			</div>
			
<div id="quitguide"><span>더 이상 알려드림 서비스를 사용하지 않는다면? >> </span><span id="quitlink" class="fw-bold">회원탈퇴</span></div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>



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
								$('#myprofile').attr('src','${pageContext.request.contextPath}/resources/files/member/defaultprofile.png');
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
				
				var vailed=true;
				
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
				
				if(vailed=true){
					
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

</body>
</html>