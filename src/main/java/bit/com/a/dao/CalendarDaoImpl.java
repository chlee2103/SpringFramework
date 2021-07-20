package bit.com.a.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bit.com.a.dto.CalendarDto;

@Repository
public class CalendarDaoImpl implements CalendarDao {

	@Autowired
	SqlSession session;
	
	String ns = "Cal.";

	@Override
	public List<CalendarDto> getCalendar(CalendarDto cal) {
		
		return session.selectList(ns+"getCalendar", cal);
	}

	@Override
	public boolean addCalendar(CalendarDto cal) {
		int count = session.insert(ns+"addCalendar", cal);
		return count>0;
	}

	@Override
	public CalendarDto calDetail(int seq) {
		CalendarDto cal = session.selectOne(ns+"calDetail", seq);
		return cal;
	}

	@Override
	public boolean calUpdate(CalendarDto cal) {
		int count = session.update(ns+"calUpdate", cal);
		return count>0;
	}

	@Override
	public boolean calDelete(int seq) {
		int count = session.delete(ns+"calDelete", seq);
		return count>0;
	}

	@Override
	public List<CalendarDto> getDayList(CalendarDto cal) {
		return session.selectList(ns+"getDayList", cal);
	}
}
