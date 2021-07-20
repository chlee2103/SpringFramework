package bit.com.a.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import bit.com.a.service.PdsServiceImpl;

public class DownloadView extends AbstractView { // AbstractView : 추상view
	// 그 뷰를 통해 다운로드 화면을 보여준다
	
	@Override
	// Map<String, Object> model의 원래 모양
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("DownloadView renderMergedOutputModel");
		
		// 컨트롤러에서 넘겨받기
		File file = (File)model.get("downloadFile");			// == getAttribute
		System.out.println("downloadview file = "+file.toString());
		
		String originalFile = (String)model.get("originalFile");
		int seq = (Integer)model.get("seq");
		
		response.setContentType(this.getContentType());
		response.setContentLength((int)file.length());
		
		System.out.println("originalFile : " + originalFile);
		
		// 한글파일 에러 방지
		// 이 설정을 안해주면 한글 파일명이 정상으로 나오지 않는다.
		originalFile = URLEncoder.encode(originalFile, "utf-8");

				// 다운로드 창 띄어주는 코드
		response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFile + "\";");
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Content-Length", "" + file.length());
	    response.setHeader("Pragma", "no-cache;"); 
	    response.setHeader("Expires", "-1;");
		
	       
	    OutputStream out = response.getOutputStream();
	    FileInputStream fi = new FileInputStream(file);
	    
	    // 실제 다운로드 되는 것
	    FileCopyUtils.copy(fi, out);
	    
	    if(fi != null) {
	    	fi.close();
	    }
	    
	}
	
}
