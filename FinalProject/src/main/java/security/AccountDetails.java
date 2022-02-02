package security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

@SuppressWarnings("serial")
public class AccountDetails extends User{
	
	
	private String photo;
	private String name;
	private String m_type;

	public AccountDetails(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities, String photo, String name, String m_type) {
		
		
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		this.photo = photo;
		this.name=name;
		this.m_type=m_type;
		
	}
	
	public AccountDetails(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities, String photo, String name) {
		
		
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		this.photo = photo;
		this.name=name;
	}
	
	

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	

	public String getM_type() {
		return m_type;
	}

	public void setM_type(String m_type) {
		this.m_type = m_type;
	}

	@Override
	public String toString() {
		
		return "이메일>>"+getUsername()+"\n사진명>>"+getPhoto()+"\n이름>>"+getName()+"\n사진명>>"+getPhoto()+"\n권한"+getAuthorities();
	}
	
	
	
	
	

}
