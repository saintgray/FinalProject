<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
    <!--  메인 페이지에서 사용할 css와 script  -->
    
    
    <!--  예시
     
    <script src="~~~"></script>
    
    <link rel="stylesheet" href="~~~~"/>
    
    -->
    
    
    
    <script>
    
    $(document).ready(function(){
    	
    	  setInterval(() => {
  	    	
  	        rolling();
  	
  	
  	               setTimeout(function () {
  	            	  $('#bannerarea img').css('left', '0px');
  	                  $('#bannerarea img').first().clone().appendTo('#bannerarea');
  	                  $('#bannerarea img').first().remove();
  	                  
  	              }, 700) 
  	
  	
  	
  	         }, 5000);
  	
  	
  	
  	
  	          var rolling = function (bannerarea_width) {
  	        	  var bannerarea_width=$('#bannerarea').first('img').width();
  	          	console.log(bannerarea_width);
  	              $('#bannerarea img').animate({ left: -bannerarea_width });
  	            
  	              
  	
  	          }  
    	
  	          
  	          
  	          $('#findmentorbtn, #findmenteebtn').on('click',function(){
  	        	 console.log('검색!'); 
  	        	 // 검색기능 만드신 분은 여기에 Controller 가 받는 요청 입력해주세요~
  	        	 //location.href="${pageContext.request.contextPath}/요청url"
  	          })
  	          
  	          
  	          $('#writepostbtn').on('click',function(){
  	        	  
  	        	  var type=$('input[name=type]').val();
  	        	  var idx=$('input[name=idx]').val();
  	        	  
  	        	  console.log(type);
  	        	  console.log(idx);
  	        	  
  	        	  $.ajax({
  	        		url: "${pageContext.request.contextPath}/post/checkProfile",
  	        		type: 'post',
					data: {
						type : type,
						idx : idx
					},
					success: function(data){
						console.log(data);
						
						if(type=='mentor' && data==""){
							alert('멘티구함 글을 쓰기 위해서는 프로필을 작성해야 합니다.');
							location.href="${pageContext.request.contextPath}/member/profile/register";
							return;
						}
						
						location.href="${pageContext.request.contextPath}/post/write"
					},
					error: function(data){
						console.log('통신오류');
						console.log(data);
					}
  	        	  });
  	        	  
  	          })
  	         
  	          
  	          
  	         
    })
    
	  

    
    </script>