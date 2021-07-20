package bit.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.com.a.dao.BbsDao;
import bit.com.a.dto.BbsDto;
import bit.com.a.dto.BbsParam;

@Service
public class BbsServiceImpl implements BbsService {

	@Autowired
	BbsDao dao;

	@Override
	public List<BbsDto> getBbslist(BbsParam param) {		
		return dao.getBbslist(param);
	}

	@Override
	public int getBbsCount(BbsParam param) {
		return dao.getBbsCount(param);
	}
	
	@Override
	public boolean bbsWrite(BbsDto bbs) {
		return dao.bbsWrite(bbs);
	}

	@Override
	public BbsDto bbsDetail(int seq) {
		return dao.bbsDetail(seq);
	}

	@Override
	public void readcount(int seq) {
		dao.readcount(seq);
	}

	@Override
	public boolean bbsUpdate(BbsDto bbs) {
		return dao.bbsUpdate(bbs);
	}

	@Override
	public boolean bbsDelete(int seq) {
		return dao.bbsDelete(seq);
	}

	@Override
	public void updateAnswer(int seq) {
		dao.updateAnswer(seq);
		
	}

	@Override
	public boolean writeAnswer(BbsDto bbs) {
		return dao.writeAnswer(bbs);
	}
	
}




