package bit.com.a.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WebsocketController {

	// db가 필요한 경우도 있다 (방만들기 할 경우)
	@RequestMapping(value = "chating.do", method = RequestMethod.GET)
	public String chating(Model model) {
		model.addAttribute("doc_title", "채팅");
		return "chating.tiles";
	}
}
