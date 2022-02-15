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
  	
  			$.ajax({
  				
  				url:'${pageContext.request.contextPath}/home/infos',
  				type:'POST',
  				contentType:'json',
  				success:function(data){
  					//console.log(data);
  					//console.log(data.memberCount);
  					
  					html='';
  					html+='<tr>\r\n';
  					html+='<td class="mx-3"><h1 class="count">'+data.memberCount+'</h1></td>\r\n';
  					html+='<td class="mx-3"><h1 class="count">'+data.postCount+'</h1></td>\r\n';
  					html+='<td class="mx-3"><h1 class="count">'+data.matchingCount+'</h1></td>\r\n'
  					html+='</tr>\r\n';
  					$('#maininfo').prepend(html);
  
  				}
  			})
  			
  			
  			$.ajax({
				url:"${pageContext.request.contextPath}/loc/list",
				type:"POST",
				dataType:"json",
				success:function(data){
					$(data).each(function(index, item){
						var html='<div class="mx-3 my-2">\r\n';
							html+='<span>'+item.loc_idx+'<span>\r\n';
							html+='<a href="" class="loclink">'+item.loc_nm+'</a>\r\n';
							html+='</div>\r\n';
						
						
						$('#locsearcharea').append(html);
						
		 
					})
					
					
					
				},
				error:function(data){
					console.log('통신실패');
					console.log(data);
				}
			})
  	
  	
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
  	        	  location.href="${pageContext.request.contextPath}/post/write";  
  	          })
  	         
  	          
  	          
  	         
    })
    
	  

    
    </script>