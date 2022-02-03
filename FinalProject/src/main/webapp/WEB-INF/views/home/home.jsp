<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  
  <!-- 기본 소스들 include : JQuery, Bootstrap... -->
  <%@ include file="/WEB-INF/views/defaultpageset.jsp" %>
  
  <!-- 자신이 만든 보조 커스텀 소스들 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/home.css">
  <%@ include file="/WEB-INF/views/home/pageset/homepageset.jsp"%>
  
  <title>HOME</title>
</head>

<body>
	
  
  	<!-- Header -->
    <%@include file="/WEB-INF/views/layout/header.jsp" %>


	<!-- Home body area -->
	<div id="globalwrap">

	    <!-- banner area -->
	    
	     <div class="d-flex flex-row" id="bannerarea" >
	    	  
		      <img src="${pageContext.request.contextPath}/resources/files/server/bannerimg/banner1.png">
		      <img src="${pageContext.request.contextPath}/resources/files/server/bannerimg/banner2.png">
		      <img src="${pageContext.request.contextPath}/resources/files/server/bannerimg/banner3.png">
		      <img src="${pageContext.request.contextPath}/resources/files/server/bannerimg/banner4.png">
	
	     </div>
	     
	     <sec:authorize access="isAuthenticated()">
	     <%-- 	<c:set value="type">
	     		<sec:authentication property="m_type"/>
	     	</c:set>
		      --%>
		     <div class="d-flex flex-column justify-content-around" id="mnmbtn">
		     	<button id="postbtn" class="btn btn-general my-2">요청서 작성</button>
		     	<c:if test="${type eq 'mentor'}">
		     		<button id="findmentorbtn" class="btn btn-general my-2">멘티찾기</button>
		     	</c:if>
		     	<c:if test="${type eq 'mentee'}">
		     		<button id="findmenteebtn" class="btn btn-general my-2">멘토찾기</button>
		     	</c:if>
		     </div>
	     </sec:authorize>
	     
	     
	     <!-- test area -->
		<h1><sec:authorize access="hasRole('ROLE_ADMIN')">ROLE_ADMIN 관리자입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="hasRole('ADMIN')">ADMIN관리자입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="isAnonymous()">비회원입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="hasRole('GENERAL')">회원입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="isAuthenticated()">인증은 되었습니다.</sec:authorize> </h1>
		<%-- <h1>멘토/멘티 상태 : <sec:authentication property="m_type"/></h1> --%>
		
		
		
		
    <!-- end of global wrap div -->
    </div>
    
    <!--  test area -->
    <div class="container" style="border: 1px solid black">
    
    	<!--  인증된 유저 = 로그인에 성공한 유저만 이 메뉴를 볼 수 있다 -->
    	<sec:authorize access="isAuthenticated()">
    	
	    	<!-- 허가증의 m_type 변수명을 type 으로 설정 -->
	    	<!-- jstl 표현식에서 type 을 사용하여 간편히 처리하기 위함 -->
	    	<c:set var="type">
	    		<sec:authentication property="principal.m_type"/>
	    	</c:set>
	    	
	    		<h4>현재 회원님의 상태는 ${type} 입니다</h4>
	    	
	    		<c:if test="${type eq 'mentee'}">
	    			<span class="changeType">멘토로전환</span>
		    	</c:if>
		    	
		    	<c:if test="${type eq 'mentor'}">
		    		<span class="changeType">멘티로전환</span>
		    	</c:if>
    	
    	</sec:authorize>
    	
    	
    	
    </div>
    <!-- end of test area -->
    
    
    <!-- footer -->
		<%@include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    
		
		
	
    
   
</body>

</html>