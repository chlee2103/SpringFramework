package bit.com.a.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import bit.com.a.dto.CalendarDto;
import bit.com.a.dto.CalendarParam;
import bit.com.a.dto.MemberDto;
import bit.com.a.service.CalendarService;
import bit.com.a.util.CalendarUtil;

@Controller
public class CalendarController {

	@Autowired
	CalendarService service;
	
	@RequestMapping(value = "calendarlist.do", method = RequestMethod.GET)
	// HttpSession 파라미터로 추가하면 자동적으로 session이 들어온다.
	public String calendarlist(Model model, CalendarParam param, HttpSession session) {
		model.addAttribute("doc_title", "일정목록");
		
		Calendar cal = Calendar.getInstance(); // 오늘 날짜 얻어오기
		
		int year = param.getYear();
		int month = param.getMonth();
		int day = param.getDay();
		
		if(month == 0) {
			year--;
			month = 12;
		}else if(month == 13) {
			year++;
			month = 1;
		}else if(month<0) {	// 처음 들어온 경우 현재 날짜 셋팅
			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH)+1;
			if(day<0) {
				day = cal.get(Calendar.DATE);
			}
		}
		
		// view에서 년도와 월은 같고 1일부터 뿌리기 위해 day는 1로 설정
		cal.set(year, month-1, 1);
		
		// 요일
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

		// 마지막 날짜
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		param.setYear(year);
		param.setMonth(month);
		param.setDay(day);
		param.setDayOfWeek(dayOfWeek);
		param.setLastday(lastDay);
		
		// 로그인 정보
		String id = ((MemberDto)session.getAttribute("login")).getId();
		
		// 날짜 취득
		String yyyymm = CalendarUtil.yyyymm(param.getYear(), param.getMonth());
		
		// DB로부터 그 달의 정보를 취득
		CalendarDto fcal = new CalendarDto();
		fcal.setId(id);
		fcal.setRdate(yyyymm);
		
		List<CalendarDto> list = service.getCalendar(fcal);
		
		model.addAttribute("flist", list);	// 일정목록
		model.addAttribute("cal", param); 	// 날짜
		
		return "calendarlist.tiles";
		
	}
	
	@RequestMapping(value = "calwrite.do", method = RequestMethod.GET)
	public String calendarwrite(Model model) {
		model.addAttribute("doc_title", "일정추가");
				
		return "calwrite.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "calwriteAf.do", method = RequestMethod.POST)
	public boolean calwriteAf(CalendarDto cal) {
		boolean flag = service.addCalendar(cal);
		return flag;
		
	}
	
	@RequestMapping(value = "caldetail.do", method = RequestMethod.GET)
	public String caldetail(int seq, Model model) {
		System.out.println("seq : " + seq);
		CalendarDto cal = service.calDetail(seq);
		model.addAttribute("caldetail", cal);
		
		return "caldetail.tiles";
	}
	
	
	@RequestMapping(value = "calupdate.do", method = RequestMethod.GET)
	public String calupdate(int seq, Model model) {
		
		CalendarDto cal = service.calDetail(seq);
		model.addAttribute("caldetail", cal);
		return "calupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "calUpdateAf.do", method = RequestMethod.POST)
	public boolean calUpdateAf(CalendarDto cal) {
		System.out.println(cal.getTitle() + " " + cal.getContent() + " " + cal.getRdate());
		boolean flag = service.calUpdate(cal);
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "calDel.do", method = RequestMethod.POST)
	public boolean calDelete(int seq) {
		boolean flag = service.calDelete(seq);
		return flag;
	}

	@RequestMapping(value = "callist.do", method = RequestMethod.GET)
	public String callist(String year, String month, String day, Model model) {
		String days = year+"년 "+month+"월 "+day+"일";
		model.addAttribute("doc_title", days);
		return "callist.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "getDayList.do", method = RequestMethod.POST)
	public List<CalendarDto> getDayList(CalendarDto cal){
		return service.getDayList(cal);
	}
	
}
