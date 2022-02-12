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
	    content: "\f177";
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
	.fi-rr-pencil:before {
		cursor: pointer;
	    content: "\f2c3";
	    font-size: 15px;
	    margin-left: 10px;
	}
	#msgarea{
		color:#FFD601;
		font-weight:light;
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
			<span class="mx-2">회원정보</span>
			<div class="form-check form-switch">
				<input class="form-check-input" type="checkbox" role="switch" id="autoLogin" name="remember-me">		  
			</div>
			<span class="mx-2">보안설정</span>
	</div>
	
	
	<div class="d-flex flex-column justify-content-center" id="infosarea">
			
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
								<h3 class="fw-normal fs-4">${info.m_nm}<i class="fi fi-rr-pencil" id="editnameicon"></i></h3>
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
									<i class="fi fi-rr-pencil"  data-bs-toggle="modal" data-bs-target="#modal-cat"></i>
								</div>
							</div>
						</c:if>	
					</div>		
			
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
				$('#namearea').html('<h3 class="fw-normal fs-4">${info.m_nm}<i class="fi fi-rr-pencil" id="editnameicon"></i></h3>\r\n');
				
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
				
			},
			error:function(data){
				
				console.log('통신실패');
				
			}
		})
		
	}
	
	
	
	
	
</script>

</body>
</html>