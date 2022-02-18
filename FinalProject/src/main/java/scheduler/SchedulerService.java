package scheduler;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
public class SchedulerService{
	
	
	@Scheduled(cron = "0 0 0 * * *")
	public void testMethod() {
		System.out.println("스케줄러테스트");
	}
}
