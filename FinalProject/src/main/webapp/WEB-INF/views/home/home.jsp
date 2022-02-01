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

   

  
  <!-- end of globalwrap div -->

		

    </div>
    
    
    <h1><sec:authorize access="hasRole('ROLE_ADMIN')">ROLE_ADMIN 관리자입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="hasRole('ADMIN')">ADMIN관리자입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="isAnonymous()">비회원입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="hasRole('GENERAL')">회원입니다.</sec:authorize>	 </h1>
		<h1><sec:authorize access="isAuthenticated()">인증은 되었습니다.</sec:authorize> </h1>
    
   
</body>
</html>