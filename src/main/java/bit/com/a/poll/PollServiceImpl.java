package bit.com.a.poll;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PollServiceImpl implements PollService{

	@Autowired
	PollDao dao;

	@Override
	public List<PollDto> getPollAllList(String id) {
		
		// 모든(전체) 투표 목록을 갖고 온다
		List<PollDto> list = dao.getPollAllList();
		
		// 편집을 통해서 투표가 가능한지 설정해서 넘겨줄 목록
		List<PollDto> plist = new ArrayList<PollDto>();
		
		for(PollDto poll : list) {
			int pollid = poll.getPollid();	// 투표 번호를 꺼낸다
			
			// 1:투표했음 0:투표안했음
			int count = dao.isVote(new Voter(pollid, -1, id));
			if(count == 1) {
				poll.setVote(true);				
			}else {
				poll.setVote(false);
			}
			plist.add(poll);
		}	
		
		return plist;
	}

	@Override
	public void makePoll(PollBean pbean) {
		System.out.println("sdate : " + pbean.getSdate() + "edate : " + pbean.getEdate());
		// 투표 주제
		PollDto poll = new PollDto(	pbean.getId(), 
									pbean.getQuestion(), 
									pbean.getSdate(), 
									pbean.getEdate(), 
									pbean.getItemcount(), 
									0);
		dao.makePoll(poll);
		
		// 투표 보기들
		String answer[] = pbean.getPollnum(); // 항목들의 값들이 다 넘어온다.
		
		for (int i = 0; i < answer.length; i++) {
			System.out.println("answer["+i+"] = " + answer[i]);
		}
		
		
		for (int i = 0; i < pbean.getItemcount(); i++) {
			PollSubDto pollsub = new PollSubDto();
			pollsub.setAnswer(answer[i]);
			
			dao.makePollSub(pollsub);			
		}	
	}

	@Override
	public PollDto getPoll(PollDto poll) {
		return dao.getPoll(poll);
	}

	@Override
	public List<PollSubDto> getPollSubList(PollDto poll) {
		return dao.getPollSubList(poll);
	}

	@Override
	public void polling(Voter voter) {
		dao.pollingPoll(voter);
		dao.pollingSub(voter);
		dao.pollingVoter(voter);
		
	}
	
	
	
	
}








