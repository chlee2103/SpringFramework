package bit.com.a.dao;

import java.util.List;

import bit.com.a.dto.BbsDto;
import bit.com.a.dto.BbsParam;

public interface BbsDao {

	List<BbsDto> getBbslist(BbsParam param);
	int getBbsCount(BbsParam param);
	void readcount(int seq);
	boolean bbsWrite(BbsDto bbs);
	BbsDto bbsDetail(int seq);
	boolean bbsUpdate(BbsDto bbs);
	boolean bbsDelete(int seq);
	void updateAnswer(int seq);
	boolean writeAnswer(BbsDto bbs);
	
}
