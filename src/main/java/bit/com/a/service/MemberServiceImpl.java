package bit.com.a.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.com.a.dao.MemberDao;
import bit.com.a.dto.MemberDto;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDao dao;

	@Override
	public int getId(MemberDto mem) {		
		return dao.getId(mem);
	}

	@Override
	public boolean addmember(MemberDto mem) {		
		return dao.addmember(mem);
	}

	@Override
	public MemberDto login(MemberDto mem) {		
		return dao.login(mem);
	}	
}




