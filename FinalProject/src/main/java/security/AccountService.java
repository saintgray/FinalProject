package security;

import java.util.LinkedList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class AccountService implements UserDetailsService {

		
		private SqlSessionTemplate stp;

// 계정 잠금, 만료와 관련된 User 클래스의 파라미터들.
// 생성자의 파라미터 기본값은 true 이며, 회원 테이블의 role 컬럼을 만든 것처럼 아래 4개의 컬럼을 회원의 컬럼에 추가하여 
// 조건에 따라 다른 값을 넣어 줄 수 도 있다.
//		boolean enabled =true;
//		boolean accountNonExpired=true;
//		boolean credentialsNonExpired=true;
//		boolean accountNonLocked=true;
		
		
		public AccountService() {
			
		}
		
		@Autowired
		public AccountService(SqlSessionTemplate stp) {
			
			this.stp = stp;
		}
		
		
		
		private static List<GrantedAuthority> getRoleList(String roles){
			List<GrantedAuthority> roleList =new LinkedList<GrantedAuthority>();
			for(String role : roles.split(",")) {
				roleList.add(new SimpleGrantedAuthority(role));
			}
			
			System.out.println(roleList);
			return roleList;
		}


		@Override
		public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
			
			System.out.println("username = "+username);
			
			AccountDetails userDetails=null;
			try {
			if(username.substring(username.indexOf("@")).equalsIgnoreCase("@aljdream.com")) {
				AdminVO vo=stp.selectOne("selectbyadminname", username);
				if(vo==null) {
					throw new UsernameNotFoundException("회원 정보가 없습니다.");
				}
				userDetails =new AccountDetails(vo.getAdmin_email(), vo.getAdmin_password(), true, true, true, true, getRoleList(vo.getRole()), vo.getPhoto(), vo.getAdmin_nm());
				
				
			}else {
				MemberVO vo= stp.selectOne("selectbyusername", username);
				if(vo==null) {
					throw new UsernameNotFoundException("회원 정보가 없습니다.");
				}
				userDetails=new AccountDetails(vo.getM_email(), vo.getM_password(),true, true,true,true,getRoleList(vo.getRole()),vo.getM_photo(), vo.getM_nm(),"mentee");
			}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
			// 사용자가 아이디를 실수로 잘못입력했다면 User의 builder 메소드를 통해 객체를 생성해 줄 수 없기 때문에
			// 먼저 vo가 null 인지 아닌지 체크한다.
			
			
//			return User.builder()
//					.username(vo.getEmail())
//					.password("{noop}"+vo.getPassword())
//					.roles(vo.getRole().split(","))
//					.build();
			System.out.println("반환하는 AccountDetails 객체의 정보입니다.");
			System.out.println(userDetails);
			System.out.println(userDetails.getPassword());
			return userDetails;
			
		}
		

		
		
		
		
		
}
