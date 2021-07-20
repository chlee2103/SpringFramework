package bit.com.a.dto;

import java.io.Serializable;

public class CalendarParam implements Serializable{
	// 매개변수를 타고 들어오는 것
	private int year = -1;
	private int month = -1;
	private int day = -1;
	private int lastday;  	// 28, 29, 30, 31 그 달의 마지막 날짜
	private int dayOfWeek;	// 요일
	
	private int hour = 0;
	private int min = 0;
	
	public CalendarParam(){}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getLastday() {
		return lastday;
	}

	public void setLastday(int lastday) {
		this.lastday = lastday;
	}

	public int getDayOfWeek() {
		return dayOfWeek;
	}

	public void setDayOfWeek(int dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getMin() {
		return min;
	}

	public void setMin(int min) {
		this.min = min;
	}

	@Override
	public String toString() {
		return "CalendarParam [year=" + year + ", month=" + month + ", day=" + day + ", lastday=" + lastday
				+ ", dayOfWeek=" + dayOfWeek + ", hour=" + hour + ", min=" + min + "]";
	}
	
}
