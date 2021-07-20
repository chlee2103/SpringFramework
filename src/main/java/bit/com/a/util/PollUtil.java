package bit.com.a.util;

import java.util.Calendar;
import java.util.Date;

public class PollUtil {
	
	// 달력의 날짜를 20210719 혈식으로 만들기
	public static String StringCal(Calendar dd) {
		String s = "";
		int year = dd.get(Calendar.YEAR);
		int month = dd.get(Calendar.MONTH) + 1;
		int day = dd.get(Calendar.DATE);
		
		s = year + "" + CalendarUtil.two(month + "") + CalendarUtil.two(day+"");
		
		return s;
	}
	
	// 연월일을 비교. 투표가 끝났는지? 오늘 > 종료일 -> 기간만료
	public static boolean isEnd(Date d) {
		// 매개변수로 넘어온 날짜(투표 좋료일)
		Calendar c = Calendar.getInstance(); 
		c.setTime(d); // 현재 우리가 지정해 놓은 날짜넣기
		
		// 오늘 날짜 얻어오기
		Calendar now = Calendar.getInstance();
		
		// 오늘 날짜 > 지정된 날짜(종료일) = true
		boolean flag = Integer.parseInt(StringCal(now)) > Integer.parseInt(StringCal(c));
		
		return flag;
	}
	
	// 투표 종료의 판별
	public static String pollState(Date d) {
		String s1 = "<div style='color:red;'>[투표종료]</div>";
		String s2 = "<div style='color:blue;'>[투표진행중]</div>";
		
		return isEnd(d)?s1:s2;
	}
}
