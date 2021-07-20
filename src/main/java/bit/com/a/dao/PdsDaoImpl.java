package bit.com.a.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bit.com.a.dto.PdsDto;

@Repository
public class PdsDaoImpl implements PdsDao {

	@Autowired
	SqlSession session;
	
	String ns="Pds.";

	@Override
	public List<PdsDto> getPdsList() {
		return session.selectList(ns+"getPdsList");
	}

	@Override
	public boolean uploadPds(PdsDto pds) {
		int count = session.insert(ns+"uploadPds", pds);
		return count>0;
	}

	@Override
	public PdsDto getPds(int seq) {
		return session.selectOne(ns+"getPds", seq);
	}

	@Override
	public void readcount(int seq) {
		session.update(ns+"readcount", seq);
	}

	@Override
	public void downcount(int seq) {
		session.update(ns+"downcount", seq);		
	}

	@Override
	public boolean updatePds(PdsDto pds) {
		int result = session.update(ns + "updatePds", pds);
		return result > 0 ;
	}

}
