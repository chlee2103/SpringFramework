package bit.com.a.poll;

import java.util.List;

public interface PollService {

	List<PollDto> getPollAllList(String id);
	
	void makePoll(PollBean pbean);
	
	PollDto getPoll(PollDto poll);
	List<PollSubDto> getPollSubList(PollDto poll);
	
	/*
	매개변수가 같기 때문에 모아줄 수 있다.
	void pollingVoter(Voter voter);
	void pollingPoll(Voter voter);
	void pollingSub(Voter voter); */
	
	void polling(Voter voter);
}
