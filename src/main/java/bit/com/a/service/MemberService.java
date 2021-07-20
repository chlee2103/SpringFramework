package bit.com.a.service;

import bit.com.a.dto.MemberDto;

public interface MemberService {

	int getId(MemberDto mem);
	boolean addmember(MemberDto mem);
	MemberDto login(MemberDto mem);
}
