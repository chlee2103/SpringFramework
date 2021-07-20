package bit.com.a.service;

import java.util.List;

import bit.com.a.dto.PdsDto;

public interface PdsService {
	List<PdsDto> getPdsList();
	boolean uploadPds(PdsDto pds);
	PdsDto getPds(int seq);
	void readcount(int seq);
	void downcount(int seq);
	public boolean updatePds(PdsDto pds);
	
	
}
