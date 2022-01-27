package securityTest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class AccountService implements UserDetailsService {

		
		private SqlSessionTemplate stp;
		
		public AccountService() {
			
		}
		
		@Autowired
		public AccountService(SqlSessionTemplate stp) {
			
			this.stp = stp;
		}


		@Override
		public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
			System.out.println("stp가 null 입니까?>>>>>>>>>>>>>>>>>");
			System.out.println(stp==null);
			System.out.println("username = "+username);
			
			AccountVO vo=null;
			if(username.equals("종현관리자")) {
				vo=stp.selectOne("selectbyadminname", username);
			}else {
				vo= stp.selectOne("selectbyusername", username);
			}
			
			
			// 사용자가 아이디를 실수로 잘못입력했다면 User의 builder 메소드를 통해 객체를 생성해 줄 수 없기 때문에
			// 먼저 vo가 null 인지 아닌지 체크한다.
			if(vo==null) {
				throw new UsernameNotFoundException("없는 사용자 이름입니다.");
			}
			
			return User.builder()
					.username(vo.getEmail())
					.password("{noop}"+vo.getPassword())
					.roles(vo.getRole().split(","))
					.build();
			
		}
		
		
		
}
