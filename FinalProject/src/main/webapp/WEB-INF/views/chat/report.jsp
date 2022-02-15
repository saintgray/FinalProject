<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리포트테스트 창</title>
 <!--  <%@ include file="/WEB-INF/views/defaultpageset.jsp" %>-->
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- Header -->
	<%@ include file="/WEB-INF/views/layout/header.jsp" %>


	<!-- report body area -->
	
	<!-- 리포트 테스트 공간입니다.  -->
	
	<div class="container">
	  <h2>신고접수 테스트공간</h2>
	  <!-- 신고하기 폼(모달창) 나오도록 하는 버튼 -->
	  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reportForm">신고하기</button>
	
	
	
	
	  <!-- 신고하기폼(모달) -->
	  <div class="modal" id="reportForm">
	    <div class="modal-dialog">
	      <div class="modal-content">
	      
	        <!-- 신고하기폼(모달) Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">신고하기</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- 신고하기폼(모달) body -->
	        <div class="modal-body">
	        	<div>신고하기 사유 확인이 불가할 경우 해당 신고건은 미조치됩니다.</div>
				<div class="form-check">
	              <label class="form-check-label">
	                <input type="radio" class="form-check-input" name="input-type" value="add">서비스와 관련없는 광고/홍보
	              </label>
	            </div>
	            <div class="form-check">
	              <label class="form-check-label">
	                <input type="radio" class="form-check-input" name="input-type" value="assert">부적절한 언어(욕설/성희롱 등) 사용
	              </label>
	            </div>
	            <div>서비스 진행중 문제가 생겼다면 증빙자료(대화내역, 문자메세지, 녹취, 사진 등)과 함께 숨고 이메일 admin1@aljdream.com으로 접수해주세요. 신고 결과는 별도안내되지 않습니다.</div>
	        </div>
	        
	        <!-- 신고하기폼(모달) footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#confirm">신고접수</button>
	          <button type="button" class="btn btn-danger" data-dismiss="modal">삭제</button>
	        </div>
	        
	      </div>
	    </div>
	  </div>
	  
	  <!-- 확인창(컨펌)모달창 -->
	  <div class="modal fade" id="confirm">
	    <div class="modal-dialog modal-sm">
	      <div class="modal-content">
	      
	        <!-- 확인창(컨펌)모달창 Header -->
	        <div class="modal-header">
	          <h4 class="modal-title"></h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- 확인창(컨펌)모달창 body -->
	        <div class="modal-body">
	      	한번 접수한 신고내용은 수정이나 삭제가 불가합니다. 이 신고내용을 접수하시겠습니까?
	        </div>
	        
	        <!-- 확인창(컨펌)모달창 footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-outline-primary" data-dismiss="modal" data-target="#reportForm" id="sendReport">네, 확인했습니다</button>
	          <button type="button" class="btn btn-danger" data-dismiss="modal">한번 더 확인하겠습니다</button>
	        </div>
	        
	      </div>
	    </div>
	  </div>
	  
	</div>





	
<script>
$(document).ready(function(){

	
	/*ajax처리*/
	// 신고 폼의 신고접수를 눌렀을 시

		$("#sendReport").click(function(){

			// 전송할 데이터 : 신고자/신고받는사람/채팅idx/신고내용
			console.log(${matchidx});
			console.log($('.form-check-input:checked').val());
			console.log(${reporter});
			console.log(${reported});
			var content = $('.form-check-input:checked').val();
			
			$.ajax({
				url : '${pageContext.request.contextPath}/chat/sendreport',
				type : 'POST',
				data : {
						match_idx : ${matchidx},
						report_content : content,
						m_report : ${reporter},
						m_reported : ${reported}
						},
						
				success : function(data){
					// 전송에 성공하면 실행될 코드
					if(data=='1'){	
						alert('신고접수가 완료되었습니다.');
					} else {
						alert('전송오류');
					}
				}
		})
	});
});

</script>



<%@include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>