<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			
			
			//if($('input[name=m_email_prefix]').val().trim().length==0 || $('input[name=m_email_suffix]').val().trim().length==0){
			if(!fullWriteEmail($('input[name=m_email_prefix]'),$('input[name=m_email_suffix]'))){
				//$('#w_email').text('이메일을 입력해주세요').css('visibility','visible');
				showWarningMsg($(this),'이메일을 입력해주세요');
				$('input[name=m_email_prefix], input[name=m_email_suffix]').val("");
			}else if($('#w_email').text()!='이미 등록된 이메일입니다'){
				
				var infos={
						m_email_prefix: $('input[name=m_email_prefix]').val(),
						m_email_suffix: $('input[name=m_email_suffix]').val()
				}
				
				$.ajax({
					url: "${pageContext.request.contextPath}/sendAuthKey",
					data: infos,
					type: "POST",
					beforeSend:function(){
						loading($('#emailarea'));
						$('#w_email').css({'visibility':'hidden','color':'red'})
					
					},
					success:function(data){
						console.log(data);
						$('#autharea').css('display','flex').html('<input type="text" id="insertedKey" class="form-control" placeholder="인증번호" aria-label="인증번호" aria-describedby="button-addon2"><button class="btn btn-grey" type="button" id="checkAuthKey">인증</button>')
						
					},
					error:function(data){
						console.log(data);
					
					},
					complete:function(){
						completeLoad();
						
					}
					
				})
			}
			
			
			
		})
		
		$('#pw, #repw').on('focusout',function(){
			console.log($(this).val().indexOf(" "));
			if(haveWhiteSpaceIn($(this))){
				showWarningMsg($(this),'공백은 포함할 수 없습니다');
				removeInserted(this);
			}else if(emptyValue($(this))){
				showWarningMsg($(this),'필수 입력사항입니다');
				removeInserted(this);
			}
			
		})
		
		
		$('input[name=m_email_prefix], input[name=m_email_suffix]').on('focusout',function(){
			if(emptyValue($(this))){
				showWarningMsg($(this),'필수 입력사항입니다');
			}else{
				if(fullWriteEmail($('input[name=m_email_prefix]'),$('input[name=m_email_suffix]'))){
					
					var infos={
							m_email_prefix: $('input[name=m_email_prefix]').val(),
							m_email_suffix: $('input[name=m_email_suffix]').val()
					}
					
										
						
					/////////////////////	
					 	$.ajax({
							url:"${pageContext.request.contextPath}/chk_email",
							data : infos,
							type: 'POST',
							
							success: function(data){
								
								if(data!='ABLEREGISTER'){
									showWarningMsg($('input[name=m_email_prefix]'),data);
								}else{
									
									$('#w_email').css('color','blue');
									showWarningMsg($('input[name=m_email_prefix]'),'사용가능한 이메일입니다');
									
								}	
								
							},
							error: function(data){
								alert(data);
							},
							
							
						}) 
					////////////////////
					}
					
				}
			})
		
		
		$('#basicInfos').on('focus','input',function(){
			hideWarningMsg($(this));
			
		})
		
		$('#infoswrap').on('click','#checkAuthKey',function(){
			var insertedKey={insertedKey: $('#insertedKey').val()}
			$.ajax({
				url:"${pageContext.request.contextPath}/chkAuthKey",
				type:"POST",
				data:insertedKey,
				beforeSend:function(){
					loading($('#autharea'));
				},
				success:function(data){
					console.log("통신성공");
					console.log(data);
					if(data=='matched'){
						
						alert('인증되었습니다');
						$('#autharea').css('display','none');
						$('#registerbtn').prop('disabled',false);
					}else{
						alert(data);
					}
					
				},
				error:function(data){
					console.log("통신실패");
					console.log(data);
				},
				complete:function(){
					completeLoad();
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
		
	
		
		// PROFILE SCRIPT
		////////////////////////////////////////
		
		// 새 프로필 사진 등록시
		$('#myprofile').on('change',function(e){
			
			
			console.log(e);
			// File 의 속성 = name, size, type...
			// type 이 image/png, image/jpg.. 의 형식임
			// 따라서 type 이 image/* 형식이 아니면 경고문구 출력
			var selectedFile=e.target.files[0];
			
			
			if(!(selectedFile.type.match("image/*"))){
				alert('이미지만 등록하실 수 있습니다.');
				$('#myprofile').val("");
				$('#preview').attr('src','${pageContext.request.contextPath}/resources/files/member/defaultprofile.png');
				
				 
				
			}else{
				// FileReader() 객체를 생성한다.
				var reader=new FileReader();
				// 사용자가 선택한 파일을 URL 타입으로 읽어들인다.
				reader.readAsDataURL(selectedFile);
				
					$(reader).on('load',function(e){
						// 읽기가 완료되면 미리보기 사진 태그의 src 속성을 그 url로 바꾼다. >> 사진 경로가 Filereader 가 읽기 완료시 URL 타입으로 저장한 경로
						 $('#preview').attr('src',e.target.result);
					})
			}
			// size 의 값을 지정해서 특정 크기 이하의 파일들만 등록하게 할 수도 있을 것이다.
			
		})
		
		// 기본 프로필 사용 클릭시
		$('#usedefault').on('click',function(){
			
			// form 안의 input 요소를 초기화하는 reset(); 메소드를 사용한다.
			// wrap() 을 사용하여 강제로 해당 input =file 태그 요소를 form 으로 감싸고
			// 그 form 태그 내의 요소 중 0번지 (input=file) 요소를 reset 한다
			$('#myprofile').val("");
			//$('#myprofile').wrap('<form>').parent('form').get(0).reset();
			$('#preview').attr('src','${pageContext.request.contextPath}/resources/files/member/defaultprofile.png');
			
			
		})
		$('#filetest').on('click',function(){
			console.log($('#myprofile')[0].files);
			$('#userinterestselect input[name=interest]').each(function(index,item){
				console.log(item.defaultValue);	
			})
			
			if($('#myprofile').val()){
				// 프로필을 사진을 등록했다면 어떠한 임의 문자열에 대한 boolean 값은 true 가 나올 것이다.
				console.log('파일이 있습니다');
				// 회원 가입 버튼을 누를 시에 이 조건문을 기준으로 FormData 객체에 추가하면 될 것이다.
			}
		})
		
		
		//REGISTER SCRIPT
		/////////////////////////////////
		$('#registerbtn').on('click',function(){
			if(!passwordMatches()){
				showWarningMsg($('#repw'),'비밀번호가 일치하지 않습니다');
			}else if(!fullWriteEmail($('input[name=m_email_prefix]'),$('input[name=m_email_suffix]'))){
				showWarningMsg($('input[name=m_email_prefix]'),'이메일을 입력하세요');
			}else{
				
				var formData =new FormData();
				formData.append('m_email_prefix',$('input[name=m_email_prefix]').val());
				formData.append('m_email_suffix',$('input[name=m_email_suffix]').val());
				formData.append('m_password',$('#pw').val());
				formData.append('m_nm',$('#m_nm').val().trim());
				formData.append('m_adyn','${adyn}')
				$('#userinterestselect input[name=interest]').each(function(index, item){
					formData.append('interest',item.defaultValue);	
				})
				
				//formData.append('interest',$('#userinterestselect input[name=interest]'));
				if($('#myprofile').val()){
					formData.append('photo',$('#myprofile')[0].files[0]);
				}
				console.log(formData);
				
				$.ajax({
					url:"${pageContext.request.contextPath}/register",
					type:"POST",
					processData:false,
					contentType:false,
					cash:false,
					enctype:'multipart/form-data',
					data:formData,
					success:function(data){
						console.log("회원가입성공!");
						alert('회원가입이 완료되었습니다!');
						location.href='${pageContext.request.contextPath}/'
					},
					error:function(data){
						console.log("회원가입실패!");
					}
				})
				
			}
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
	
	function passwordMatches(){
		return $('#pw').val()==$('#repw').val();
	}
	function removeInserted(dom){
		$(dom).val("");
	}
	function haveWhiteSpaceIn(dom){
		return $(dom).val().indexOf(" ")>=0;
	}
	function emptyValue(dom){
		return $(dom).val().trim().length==0;
	}
	function fullWriteEmail(prefix,suffix){
		
		console.log($(prefix).val().trim().length!=0 && $(suffix).val().trim().length!=0);
		return $(prefix).val().trim().length!=0 && $(suffix).val().trim().length!=0;
	}
	function showWarningMsg(dom, message){
		$(dom).parent().siblings('.warningmsg').text(message).css('visibility','visible');
	}
	function hideWarningMsg(dom){
		$(dom).parent().siblings('.warningmsg').css({"visibility":"hidden","color":"red"});
	}
	function loading(dom){
		$(dom).after('<img src="${pageContext.request.contextPath}/resources/files/server/icons/loading/loading.svg" id="loading">');
	}
	function completeLoad(){
		$('#loading').remove();
	}

</script>