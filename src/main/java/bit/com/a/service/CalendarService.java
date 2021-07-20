package bit.com.a.service;

import java.util.List;

import bit.com.a.dto.CalendarDto;

public interface CalendarService {
	
	List<CalendarDto> getCalendar(CalendarDto cal);
	boolean addCalendar(CalendarDto cal);
	CalendarDto calDetail(int seq);
	boolean calUpdate(CalendarDto cal);
	boolean calDelete(int seq);
	List<CalendarDto> getDayList(CalendarDto cal);
}
