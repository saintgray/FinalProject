<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

// DB 에서 해당 회원의 평점을 계산해서 5점 만점에 평균 x점이 나왔다고 가정하자.
// 별 5개 이미지 길이만큼의 x에 대한 백분율 만큼 #bg_template 길이를 결정해 주면 될것이다.
// 예를 들어 3.3점이라 하자.

var avgRank=${profile.avgStars};
// 일의 자리수 추출
var fullStars=Math.floor(avgRank);
// 소수점 자리수 추출
var remainStarSize=(avgRank%1).toFixed(2); 
var width=$('.star').width();
var border=$('.star').css('border-right-width').replace("px","");
console.log('fullStars>>>'+fullStars);
console.log('remainStarSize>>'+remainStarSize);
console.log('imgWidth'+width);
console.log('border>>'+border);

// 노랑색 바의 길이 = fullStar의 갯수*(star이미지의 width + star 이미지의 border-right 두께) + 소숫점첫째자리*star 이미지의 넓이
barLength=fullStars*(width+parseInt(border))+($('.star').width())*remainStarSize;
console.log(barLength);
$('#bg_template').css('background-size',barLength+'px '+width+'px');



// 별 랭킹의 전체 크기를 조정할 경우 css의 .star 스타일의 width 속성값을 조절한다.
// avgRank 는 해당 튜터의 평균 랭킹을 DB에서 계산한 다음 반환된 값이어야 한다.
// 랭킹이 들어간 레이아웃은 white 배경이어야 한다. >> 아닐 경우 새 별 이미지 작업 필요함
// background 의 url 이미지 경로와 별모양 이미지는 서버 경로의 정적파일(resources) 에 있는 서버용 이미지들 경로로 잡는다.

</script>