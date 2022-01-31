<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout/header.css">
<%@ include file="/WEB-INF/views/layout/pageset/headerpageset.jsp" %>



<div id="headerwrap">
	<ul class="container d-flex">
	      
	      <li id="first" class="mr-auto p-2 d-flex flex-wrap">
	        <img src="${pageContext.request.contextPath}/resources/files/server/icons/icon_sidemenu.svg" data-bs-toggle="offcanvas" data-bs-target="#sidemenu"
	        aria-controls="sidemenu" class="sub"> 
	        <a id="logo"><img src="${pageContext.request.contextPath}/resources/files/server/bannerimg/logo.svg"></a>
	        
	        <!--이 아이콘을 누르면 searchbar 로 focusing 되게 하세요-->
	        <img src="${pageContext.request.contextPath}/resources/files/server/icons/img_searchicon.svg" class="sub" id="searchfocusbtn">
	        
	
	        <div class="input-group inner" id="search">
	          <div class="input-group-prepend">
	            <img class="input-group-text" style="height: 100%" src="${pageContext.request.contextPath}/resources/files/server/icons/img_searchicon.svg">
	          </div>
	          <input id="searchbar" style="border-left: 0;" type="text" class="form-control" aria-label="Amount (to the nearest dollar)"
	            placeholder="어떤 서비스가 필요하세요?">
	        </div>
	
	      </li>
	
	
		  
	      <li id="subnav" class="ml-auto p-2 d-flex">
		        <span class="inner list">멘토찾기</span>
		        <sec:authorize access="isAnonymous()"> 
		        	<span class="inner list">로그인</span>
		        	<span class="inner" id="register">회원가입</span>
		        </sec:authorize>
		        <sec:authorize access="isAuthenticated()">
		        	<span class="inner" id="logoutbtn">로그아웃</span>
		        </sec:authorize>
	      </li>
	      
    </ul>
	    
</div>

    <!--offcanvas area-->
    <div class="offcanvas offcanvas-start" tabindex="-1" id="sidemenu" aria-labelledby="offcanvasExampleLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasExampleLabel">당신의 멘토를 찾아보세요!</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <ul>
          <li><h4 class="fs-5">회원가입</h4></li>
          <li>
            <h4 class="fs-5">로그인</h4>
          </li>
          <li>
            <h4 class="fs-5">알려드림은 어떤 서비스인가요?</h4>
          </li>
          <li>
            <h4 class="fs-5">이용안내</h4>
            
          </li>
          <li></li>
        </ul>
        
      </div>
    </div>
    
    
    <!-- end of offcanvas area -->
    