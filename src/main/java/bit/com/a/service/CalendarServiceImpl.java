package bit.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.com.a.dao.CalendarDao;
import bit.com.a.dto.CalendarDto;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	CalendarDao dao;

	@Override
	public List<CalendarDto> getCalendar(CalendarDto cal) {
		
		return dao.getCalendar(cal);
	}

	@Override
	public boolean addCalendar(CalendarDto cal) {
		return dao.addCalendar(cal);
	}

	@Override
	public CalendarDto calDetail(int seq) {
		return dao.calDetail(seq);
	}

	@Override
	public boolean calUpdate(CalendarDto cal) {
		return dao.calUpdate(cal);
	}

	@Override
	public boolean calDelete(int seq) {
		return dao.calDelete(seq);
	}

	@Override
	public List<CalendarDto> getDayList(CalendarDto cal) {
		return dao.getDayList(cal);
	}
	
	
}
