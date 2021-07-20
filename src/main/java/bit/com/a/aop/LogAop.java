package bit.com.a.aop;

import java.util.Date;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class LogAop {
	
	// 패키지명 안에 있는 어떤 클래스든 호출될 때 무조건 들어와서 실행된다.
	// controller 감시
	@Around("within(bit.com.a.controller.*)")
	public Object loggerAop(ProceedingJoinPoint joinpoint) throws Throwable{
		// 신호과 왔을때
		String signatureStr = joinpoint.getSignature().toShortString();
		
	//	System.out.println(signatureStr + " 시작");
		
		try {
			Object obj = joinpoint.proceed();  // 실행시 (클래스가 호출 된 시점)
			
			System.out.println("loggerAOP의 " + signatureStr + " 메소드가 실행 " + new Date());
			
			return obj;
			
		} finally {
			// System.currentTimeMillis() : 밀리세컨 단위의 시간
		//	System.out.println("실행 후 : " + System.currentTimeMillis());
		//	System.out.println(signatureStr + " 종료");
		}	
	}
}
