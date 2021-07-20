package bit.com.a.dao;

import bit.com.a.dto.MemberDto;

public interface MemberDao {

	int getId(MemberDto mem);	
	boolean addmember(MemberDto mem);	
	MemberDto login(MemberDto mem);
}
