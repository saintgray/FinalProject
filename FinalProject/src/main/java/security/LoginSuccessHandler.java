package security;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	
	// AuthenticationSuccessHandler 인터페이스를 구현한 LoginSuccessHandler 클래스
	// 로그인에 성공시 성공한 허가증에 있는 GrantedAuthority 콜렉션에 ROLE_ADMIN 이라는 권한이 있다면
	// 바로 관리자 페이지로 이동하며, 그렇지 않다면 알려드림 서비스의 메인 페이지로 이동한다.
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		AccountDetails logininfo= (AccountDetails)	authentication.getPrincipal();
		
		Iterator<GrantedAuthority> itr= logininfo.getAuthorities().iterator();
		String redirectUrl="/";
		
		while(itr.hasNext()) {
			if(itr.next().getAuthority().equals("ROLE_ADMIN")) {
				redirectUrl="/admin/manage";
				break;
			}
		}
		
		
		response.sendRedirect(request.getContextPath().concat(redirectUrl));
		
	}
	
	
	

}
