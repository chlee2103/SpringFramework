package bit.com.a.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bit.com.a.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession session;	
	String ns = "Member.";
	
	@Override
	public int getId(MemberDto mem) {		
		return session.selectOne(ns + "getId", mem);		
	}

	@Override
	public boolean addmember(MemberDto mem) {
		int n = session.insert(ns + "addmember", mem);
		return n>0?true:false;
	}

	@Override
	public MemberDto login(MemberDto mem) {		
		return session.selectOne(ns + "login", mem);
	}
	
	
	
}








