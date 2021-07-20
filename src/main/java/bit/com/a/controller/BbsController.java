package bit.com.a.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.cj.Session;

import bit.com.a.dto.BbsDto;
import bit.com.a.dto.BbsParam;
import bit.com.a.service.BbsService;

@Controller
public class BbsController {

	
	@Autowired
	BbsService service;
	
	@RequestMapping(value = "bbslist.do", method = RequestMethod.GET)
	public String bbslist(Model model, BbsParam param) {
		model.addAttribute("doc_title", "글목록");
		
		int sn = param.getPageNumber();	// 0 1 2 3 4
		int start = 1 + sn * 10;	// 1  11
		int end = (sn + 1) * 10;	// 10 20 
		
		
		param.setStart(start);
		param.setEnd(end);
		
		List<BbsDto> list = service.getBbslist(param);
		model.addAttribute("bbslist", list);
		
		int totalNum = service.getBbsCount(param);
		System.out.println("글의 총수 : " + totalNum);
		model.addAttribute("totalCount", totalNum);		
		
		model.addAttribute("pageNumber", param.getPageNumber()+1);
		
		// 검색시 필요하다. 검색 페이지 넘길때 오류발생을 없애기 위해서
		model.addAttribute("search", param.getSearch());	
		model.addAttribute("choice", param.getChoice());	
		System.out.println("search : " + param.getSearch() + " choice : "+ param.getChoice());
		
		return "bbslist.tiles";
	}
	
	@RequestMapping(value = "bbswrite.do", method = RequestMethod.GET)
	public String bbswrite() {
		return "bbswrite.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "bbsWriteAf.do", method = RequestMethod.POST)
	public boolean bbsWriteAf(BbsDto bbs) {
		boolean flag = service.bbsWrite(bbs);
		
		return flag;
	}
	
	@RequestMapping(value = "bbsdetail.do", method = RequestMethod.GET)
	public String bbsdetail(Model model, int seq) {
		service.readcount(seq); // 조회수
		BbsDto bbs = service.bbsDetail(seq);
		model.addAttribute("bbsdateil", bbs);
		return "bbsdetail.tiles";
	}
	
	@RequestMapping(value = "bbsupdate.do", method = RequestMethod.GET)
	public String bbsupdate(Model model, int seq) {
		BbsDto bbs = service.bbsDetail(seq);
		model.addAttribute("bbsupdate", bbs);
		
		return "bbsupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "bbsUpdateAf.do", method = RequestMethod.POST)
	public boolean bbsUpdateAf(BbsDto bbs) {
		return service.bbsUpdate(bbs);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "bbsDelete.do", method = RequestMethod.GET)
	public boolean bbsDelete(int seq) {
		return service.bbsDelete(seq);
	}
	
	@RequestMapping(value = "bbsanswer.do", method = RequestMethod.GET)
	public String bbsAnswer(Model model, int seq) {
		BbsDto bbs = service.bbsDetail(seq);
		model.addAttribute("bbsAnswer", bbs);
		
		return "bbsanswer.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "bbsAnswerAf.do", method = RequestMethod.POST)
	public boolean bbsAnswerAf(BbsDto bbs) {
		service.updateAnswer(bbs.getSeq());
		boolean flag = service.writeAnswer(bbs);
		
		return flag;
	}
	

	
	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logout (HttpSession session) {
		session.invalidate();
		return "redirect:/login.do";
	}
	
}






