<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	

	$(document).ready(function(){
		
		
		$('#plus_icon').on('click',function(){
			
			location.href="${pageContext.request.contextPath}/member/profile/register"
		})       
		
		$('#delProfile').on('click',function(){
			if(confirm('정말로 내 프로필을 삭제하시겠습니까?')){
				// 프로필 삭제 ${profile.profile_idx}에 해당하는 프로필 데이터의 profile_deldate 를 DB 시간으로 update
				var profile_idx={profile_idx:${profile.profile_idx}}
				
				$.ajax({
					
					url: 'delete',
					type: 'POST',
					data: profile_idx,
					success: function(data){
						if(data==1){
							alert('정상적으로 삭제되었습니다');
							location.href="${pageContext.request.contextPath}/member/profile/main";
						}
					},
					error: function(data){
						console.log('에러발생');
						console.log(data);
					}
					
				})
				
			}
			
		})
		
		$('#close-modal').on('click',function(){
			$('.modal-title').text('');
			$('.modal-body').text('');
			$('.modal-footer .editbtn').removeAttr('id');
			
		})
		
		$('#editline').on('click',function(){
			
			$('.modal-title').text('한줄 소개');
			
			var html='';
			html+='<div class="descript mb-5">\r\n';
			html+='멘티들에게 자신을 한 줄로 소개해보세요!\r\n';
			html+='</div>\r\n';
			html+='<input type="text" class="form-control my-5 mx-auto" placeholder="경력  5년의 첼로리스트 !!" name="line" id="editline">';
			$('.modal-body').html(html);
			$('.modal-body input[name=line]').val($('#originline').text());
			$('.modal-footer .editbtn').attr('id','editlinebtn');		
		})
		
		$('.modal-footer').on('click','#editlinebtn',function(){
			if(confirm('정말로 수정하시겠습니까?')){
			
				// 1. ajax 로 통신하여 한줄소개를 수정한다.
				var data={line:$('.modal-body #editline').val()}
				var url='${pageContext.request.contextPath}/member/profile/edit/line'
				editProfile(data,url);
				
				
				
				
				
			}
		
			
		})
		
		$('#editcalltime').on('click',function(){
			
			$('.modal-title').text('연락 가능 시간');
			var html='';
			html+='<div class="descript mb-5">\r\n';
			html+='연락 가능 시간대를 선택하세요\r\n';
			html+='</div>\r\n';
			html+='<div class="d-flex flex-wrap p-2 justify-content-around" id="timezone">\r\n';
			html+='<input  type="text" class="form-control timepicker"  name="calltime_prefix" id="calltime">\r\n';
			html+='<span style="font-size:20px">~</span>\r\n';
			html+='<input type="text" class="form-control timepicker"  name="calltime_suffix" id="calltime">\r\n';
			html+='</div>\r\n';
			html+='<div style="color:red;font-size:13px;font-weight:bold;text-align:center" id="w_ct"></div>'
			$('.modal-body').html(html);
			$('.modal-footer .editbtn').attr('id','editcalltimebtn');
			$('.timepicker').timepicker({
			    timeFormat: 'HH:mm p',
			    interval: 60,
			    minTime: '01',
			    maxTime: '23:00pm',
			    defaultTime: '00',
			    startTime: '00',
			    dynamic: false,
			    dropdown: true,
			    scrollbar: true
			});
			
		})
		
		$('.modal-footer').on('click','#editcalltimebtn',function(){
			if($('.modal-body input[name=calltime_prefix]').val().trim().length==0 || $('.modal-body input[name=calltime_suffix]').val().trim().length==0){
				
				$('.modal-body #w_ct').text('* 연락가능 시간대를 선택해주세요');
				
			}else if(confirm('정말로 연락가능 시간대를 수정하시겠습니까?')){
			
				var data={calltime:$('.modal-body input[name=calltime_prefix]').val()+" ~ "+$('.modal-body input[name=calltime_suffix]').val()}
				var url='${pageContext.request.contextPath}/member/profile/edit/calltime'
				editProfile(data, url);
				
			}
		
			
		})
// 2022 02 07 20:40 까지 작업 완료
// 내일 할것 career ,qna 첨부파일 수정 작업
		
		$('#editcareer').on('click',function(){
			
			$('.modal-title').text('경력');
			var html='';
			html+='<div class="d-flex flex-column mb-5">\r\n';
				
				html+='<div id="editcareerarea">\r\n';
					html+='${profile.career}\r\n';
				html+='</div>\r\n';
			html+='</div>\r\n';
			$('.modal-body').html(html);
			$('#editcareerarea').summernote({
				toolbar: [
				    // [groupName, [list of button]]
				    ['style', ['bold', 'italic', 'underline', 'clear']],
				    ['font', ['strikethrough', 'superscript', 'subscript']],
				    ['fontsize', ['fontsize']],
				    /* ['color', ['color']], */
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['insert', ['link', 'picture', 'video']],
				  ],
				 height: 600,
				 width: 600,
		         codemirror: {
		        	 theme: 'monokai'
		         },
		         lang: 'ko-KR',
		         placeholder: '화려한 나의 경력을 작성해주세요'		
			})
			
			$('.modal-footer .editbtn').attr('id','editcareerbtn');			
			
		})
		
		$('.modal-footer').on('click','#editcareerbtn',function(){
			if(confirm('정말로 경력을 수정하시겠습니까?')){
			
				// 1. ajax 로 통신하여 한줄소개를 수정한다.
				
				// 정상적으로 수정할 시 close 버튼 클릭 이벤트를 강제실행한다.
				
				$('#close-modal').trigger('click');
			}
		
			
		})
		
		
		$('#editqna').on('click',function(){
			
			$('.modal-title').text('QNA');
			var html='';
			html+='<div class="descript mb-5">';
			html+='멘티들에게 자주받는 질문이 있나요? 여기에 등록해보세요';
			html+='</div>';
			html+='<div id="editqnaarea">';
			html+='${profile.qna}'
			html+='</div>';
			$('.modal-body').html(html);
			$('#editqnaarea').summernote({
				toolbar: [
				    // [groupName, [list of button]]
				    ['style', ['bold', 'italic', 'underline', 'clear']],
				    ['font', ['strikethrough', 'superscript', 'subscript']],
				    ['fontsize', ['fontsize']],
				    /* ['color', ['color']], */
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['insert', ['link', 'picture', 'video']],
				  ],
				 height: 600,
				 width: 600,
		         codemirror: {
		        	 theme: 'monokai'
		         },
		         lang: 'ko-KR',
		         placeholder: '화려한 나의 경력을 작성해주세요'		
			})
			$('.modal-footer .editbtn').attr('id','editqnabtn');	
	
		})
		
		$('.modal-footer').on('click','#editqnabtn',function(){
			if(confirm('정말로 QNA 내용을 수정하겠습니까?')){
			
				// 1. ajax 로 통신하여 한줄소개를 수정한다.
				
				// 정상적으로 수정할 시 close 버튼 클릭 이벤트를 강제실행한다.
				
				$('#close-modal').trigger('click');
			}
		
			
		})
		
		
		
	})
	
	
	function editProfile(data, url){
		
		$.ajax({
			
			url: url,
			type:'POST',
			data: data,
			success:function(data){
				if(data==1){
					console.log(data);
					alert('수정되었습니다');
					// 정상적으로 수정할 시 close 버튼 클릭 이벤트를 강제실행한다.
					$('#close-modal').trigger('click');	
				}else{
					alert('일시적인 오류가 발생하였습니다. 잠시 후 다시 시도하세요');
				}
				
			},
			error:function(data){
				console.log(data);
			}
			
			
		})
		
	}
	
	
	function editAttachFile(data url){
		
	}
</script>