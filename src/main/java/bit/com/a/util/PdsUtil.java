package bit.com.a.util;

import java.util.Date;

public class PdsUtil {
	
	// String f : 오리지날 filename
	public static String  getNewFileName(String f) {
		String filename = "";
		String fpost = ""; // 포지션
		
		if(f.indexOf('.') >= 0) { // 확장자명이 있을 때(파일네임에 .이 있을때)
			fpost = f.substring(f.indexOf('.')); 	// abc.txt → .txt
			// Date().getTime() : 시스템 타임
			filename = new Date().getTime() + fpost;// 3234552.txt
		}else {					  // 확장자명이 없을 때
			filename = new Date().getTime() + ".back"; // 3234552.back
		}
		return filename;
	}
}
