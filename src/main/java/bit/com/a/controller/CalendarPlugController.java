package bit.com.a.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import bit.com.a.dto.CalendarPlugDto;
import bit.com.a.dto.MemberDto;
import bit.com.a.service.CalendarPlugService;

@Controller
public class CalendarPlugController {

	@Autowired
	CalendarPlugService service;
	
	@RequestMapping(value = "calendarpluglist.do", method = RequestMethod.GET)
	public String calendarpluglist(Model model, HttpSession session ) {
		model.addAttribute("doc_title", "일정목록 plug");
		
		MemberDto mem = (MemberDto)session.getAttribute("login");
		
		CalendarPlugDto calp = new CalendarPlugDto();
		calp.setId(mem.getId());
		
		List<CalendarPlugDto> list = service.getCalendarPulgList(calp);
		model.addAttribute("callist", list);
		
		return "calendarpluglist.tiles";
	}
}
