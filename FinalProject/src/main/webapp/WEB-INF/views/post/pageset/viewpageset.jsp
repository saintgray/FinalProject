<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
function deletePost(idx){
	
	if(confirm('글이 삭제됩니다. 계속 진행하시겠습니까?')){
		
		$.ajax({
			url: '${pageContext.request.contextPath}/post/delete',
			type: 'post',
			data: {post_idx : idx},
			success: function(data){
				if(data==1){
					alert('게시글이 삭제되었습니다.');
					location.href="${pageContext.request.contextPath}/post/list";
				} else {
					console.log('삭제 실패');
				}
			},
			error: function(){
				console.log('비동기 통신 오류');
			}
		});
		
	}
	
}

function showImage(fileName){
	console.log(fileName);
	$('#imageWrapper').css("display", "flex").show();
	$('#bigImage').html('<img src="${pageContext.request.contextPath}/post/display?fileName='+fileName+'" class="img-thumbnail">');
}

$(document).ready(function(){
	
	$('#matchBtn').on('click', function(){
		
		var postidx=$('#postidx').val();
		var wanted=$('#wanted').val();
		var midx=$('#midx').val();
		var myidx=$('#myidx').val();
		
		console.log('postidx:', postidx);
		console.log('wanted:', wanted);
		console.log('midx:', midx);
		console.log('myidx:', myidx);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/post/matchchk",
			type: "post",
			data: {
				postidx : postidx,
				midx : midx,
				myidx : myidx,
				wanted: wanted
			},
			success : function(data){
				alert('매칭 생성');
				location.href="${pageContext.request.contextPath}/post/view?idx="+postidx;
				// 전송에 성공하면 실행될 코드
				if(data==0){	// 테이블이 이미 있다는 뜻 = 문의를 했던 글이라는 뜻
					alert('이미 문의한 게시글입니다. 내 채팅목록을 확인해주세요!');
				} else {
					setMatchidx(data);
					console.log(matchidx);
					//채팅테이블 생성할 함수실행
					alert(${member.m_idx}'님에게 보낼 멋진 첫 한마디를 작성해주세요!');
				}
			},
			error: function(data){
				console.log('통신 오류');
				console.log(data);
			}
		});
		
	})
	
	$('#attachedfiles').on("click", "li", function(event){
		
		var liObj = $(this);
		console.log(liObj);
		
		var file_nm = $(this).data('file_nm');
		var exet = $(this).data('exet');
		
		console.log("file_nm", file_nm);
		console.log("exet", exet);
		var fileName = file_nm+"."+exet;
		var path = "${pageContext.request.contextPath}/resources/files/post/attachfiles/"+fileName;
		
		// pdf 파일의 경우 다운로드
 		if(exet == "pdf"){
 		
 			self.location="${pageContext.request.contextPath}/post/download?fileName="+fileName;

 		} else {
 		// 이미지의 경우 원본 출력
 			showImage(fileName);
 			
		}

	})
	
	// 원본 이미지를 클릭하면 div를 숨긴다.
	$('#imageWrapper').on("click", function(e){
		$('#imageWrapper').hide();
	});
	
});
</script>