package bit.com.a.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import bit.com.a.dto.PdsDto;
import bit.com.a.service.PdsService;
import bit.com.a.util.PdsUtil;

@Controller
public class PdsControllor {
	
	@Autowired
	PdsService service;
	
	@RequestMapping(value = "pdslist.do", method = RequestMethod.GET)
	public String pdslist(Model model) {
		model.addAttribute("doc_title", "자료실 목록");
		
		List<PdsDto> list = service.getPdsList();
		model.addAttribute("pdslist", list);
		
		return "pdslist.tiles";
	}
	
	@RequestMapping(value = "pdswrite.do", method = RequestMethod.GET)
	public String pdswrite(Model model) {
		model.addAttribute("doc_title", "자료올리기");
		
		return "pdswrite.tiles";
	}
	
	@RequestMapping(value = "pdsupload.do", method = RequestMethod.POST)
	public String pdsupload(PdsDto pds, 
							@RequestParam(value="fileload", required = false) MultipartFile fileload, // 파일 받는 부분
							HttpServletRequest req)	{
		
		// filename(원본) 취득
		String filename = fileload.getOriginalFilename();
		pds.setFilename(filename);	// DB에 저장하기 위해서 원파일명을 넣어준다.
		
		// newfilename
		String newfilename = PdsUtil.getNewFileName(pds.getFilename());
		pds.setNewfilename(newfilename);
		
		
		// upload 경로 설정
		// server에 파일 저장
		String fupload = req.getServletContext().getRealPath("/upload");
		
		// 폴더에 저장
	//	String fupload = "d:\\tmp";
		
		System.out.println("fupload : "+fupload);
		
		File file = new File(fupload + "/" + newfilename); // 파일 경로안에 new파일네임을 넣어라
		
		try {
			// 실제 업로드 
			FileUtils.writeByteArrayToFile(file, fileload.getBytes()); // 파일을 byte단위로 넣어라.
			
			// DB에 저장
			service.uploadPds(pds);
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		return "redirect:/pdslist.do";
	}
	
	// 다운로드를 받을 수 있는 부분으로 보내기
	@RequestMapping(value = "fileDownload.do", method = RequestMethod.GET)
	public String fileDownload(String newfilename, String filename, int seq, HttpServletRequest req, Model model) {
		
		// 경로
		// server
		String fupload = req.getServletContext().getRealPath("/upload");
		
		// 폴더에 저장
	//	String fupload = "d:\\tmp";
		service.downcount(seq);
		File downladFile = new File(fupload + "/" + newfilename);
		model.addAttribute("downloadFile", downladFile);
		model.addAttribute("originalFile", filename);
		model.addAttribute("seq", seq); // DB에서 다운로드 횟수 증가를 위해 
		
		return "downloadView"; // 추상 view를 보여줘야 한다.
	}
	
	@RequestMapping(value = "pdsdetail.do", method = RequestMethod.GET)
	public String pdsdetail(Model model, int seq) {
		model.addAttribute("doc_title", "상세 글보기");
		service.readcount(seq);
		PdsDto pds = service.getPds(seq);
		model.addAttribute("pds", pds);
		return "pdsdatail.tiles";
	}
	
	@RequestMapping(value = "pdsupdate.do", method = RequestMethod.GET)
	public String pdsupdate(Model model, int seq) {
		model.addAttribute("doc_title", "글 수정");
		PdsDto pds = service.getPds(seq);
		model.addAttribute("pds", pds);
		return "pdsupdate.tiles";
	}
	
	@RequestMapping(value = "pdsupdateAf.do", method = RequestMethod.POST)
	public String pdsupdateAf(PdsDto pds, 
							@RequestParam(value="fileload", required = false) MultipartFile fileload, // 파일 받는 부분
							HttpServletRequest req)	{

		
		// filename(원본) 취득
		String filename = fileload.getOriginalFilename();
		pds.setFilename(filename);	// DB에 저장하기 위해서 원파일명을 넣어준다.
		
		// newfilename
		String newfilename = PdsUtil.getNewFileName(pds.getFilename());
		pds.setNewfilename(newfilename);
		
		System.out.println("filename = " + filename);
		System.out.println("newfilename = " + newfilename);
		System.out.println(pds.toString());
		// upload 경로 설정
		// server에 파일 저장
		String fupload = req.getServletContext().getRealPath("/upload");
		
		// 폴더에 저장
	//	String fupload = "d:\\tmp";
		
		System.out.println("fupload : "+fupload);
		File file = new File(fupload + "/" + newfilename); // 파일 경로안에 new파일네임을 넣어라
		try {
			// 실제 업로드 
			FileUtils.writeByteArrayToFile(file, fileload.getBytes()); // 파일을 byte단위로 넣어라.
			
			// DB에 저장
			service.updatePds(pds);
			

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/pdslist.do";
	}
	
}
