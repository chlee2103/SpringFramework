package bit.com.a.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bit.com.a.dto.BbsDto;
import bit.com.a.dto.BbsParam;

@Repository
public class BbsDaoImpl implements BbsDao {

	@Autowired
	SqlSessionTemplate session;
	
	String ns = "Bbs.";

	@Override
	public List<BbsDto> getBbslist(BbsParam param) {		
		return session.selectList(ns + "bbslist", param);
	}

	@Override
	public int getBbsCount(BbsParam param) {
		return session.selectOne(ns+"getBbsCount", param);
	}
	
	@Override
	public boolean bbsWrite(BbsDto bbs) {
		int count = session.insert(ns+"bbsWrite", bbs);
		return count>0 ;
	}

	@Override
	public BbsDto bbsDetail(int seq) {
		BbsDto bbs = session.selectOne(ns+"bbsDetail", seq);
		return bbs;
	}

	@Override
	public void readcount(int seq) {
		session.update(ns+"readcount", seq);
	}

	@Override
	public boolean bbsUpdate(BbsDto bbs) {
		int count = session.update(ns+"bbsUpdate", bbs);
		return count>0;
	}

	@Override
	public boolean bbsDelete(int seq) {
		int count =  session.update(ns+"bbsDelete", seq);
		return count>0;
		
	}

	@Override
	public void updateAnswer(int seq) {
		session.update(ns+"updateAnswer", seq);
		
	}

	@Override
	public boolean writeAnswer(BbsDto bbs) {
		int count = session.insert(ns+"writeAnswer", bbs);
		return count>0 ;
	}

	
	
}





