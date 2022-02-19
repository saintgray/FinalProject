package scheduler;

import java.io.File;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.alj.dream.file_profile.dao.ProfileFilesDao;

@Component
@EnableScheduling
public class SchedulerService{
	
	
	
	private SqlSessionTemplate sst;
	private ServerPath serverPath;
	
	
	public SchedulerService() {

	}
	
	
	
	@Autowired
	public SchedulerService(SqlSessionTemplate sst, ServerPath serverPath) {
		this.sst = sst;
		this.serverPath = serverPath;
	}




	// 매일 새벽 2시에 실행되는 메소드
	@Scheduled(cron = "0 0 2 * * *")
	public void deleteInvalidFiles() {
		
		
		// DB에는 삭제일이 업데이트 되었으나 파일을 삭제하는 과정에서 오류가 발생하여 미처 삭제되지 않은 파일을 일괄 삭제한다.
		
		// 1. file_profile 테이블에서 file_deldate 가 null 이 아닌 파일(삭제된 파일 데이터)을 모두 가져온다.
		List<String> list=sst.getMapper(ProfileFilesDao.class).getDeletedFiles();
		System.out.println(list);
		
		// filenm=PK
		for(String filenm : list) {
			File file=new File(serverPath.profileFilesPath,filenm);
			System.out.println(file.exists());
			// 삭제처리
			
			///////////////////////////////
			
		}
		
		// 2. 컨텍스트경로/resources/files/member/profile_attachfiles 경로 내에 해당 파일이 있으면
		// 	  = 삭제된 파일인데 서버에 존재한다면 >> 삭제한다.
		
		
	}
	
	
	// 2) tempcode 만료 설정
}
