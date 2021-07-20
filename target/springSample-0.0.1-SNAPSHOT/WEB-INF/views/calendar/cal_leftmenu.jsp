<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Calendar cal = Calendar.getInstance(); 
int year = cal.get(Calendar.YEAR); 
int month = cal.get(Calendar.MONTH)+1; 
int day = cal.get(Calendar.DATE);
%>

<div class="menu_table">
	<ul style="width: 100%"> 
		<li class="title">일정관리</li>
		<li class="subtitle">일정</li>
		<li class="menu_item">
			<a href="calendarlist.do" title="일정목록">일정목록</a>
		</li>
		<li class="menu_item">
			<a href="calwrite.do?year=<%=year%>&month=<%=month%>&day=<%=day%>" title="일정추가">일정추가</a>
		</li>		
	</ul>
</div>