<%@page import="bit.com.a.util.CalendarUtil"%>
<%@page import="bit.com.a.dto.CalendarParam"%>
<%@page import="bit.com.a.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
table {
    border-collapse: collapse;    
}

table, td, th {
    border: 1px solid #707070;
    font-weight: bold;
    font-size: 20px;
}
.sunday{
   color: red; 
   text-align: left;
   vertical-align: top;
   background-color: #ccccff;
}
.satday{
   color: blue; 
   text-align: left;
   vertical-align: top;
   background-color: #ccccff;
   font-weight: bolder;
}
.otherday{
   color: black; 
   text-align: left;
   vertical-align: top;      
}
.days2{
   font-size:20px;
   color: #4D6BB3; 
   text-align: center;
   vertical-align: middle;
}
.days3{
   font-size:16px;
   color: #4D6BB3;
   text-align: center;
   vertical-align: middle;
   background-color:#4D6BB3; color:#FFFFFF; line-height:1.7em; font-weight:normal;
}
.innerTable {
    border: 0px ;
}

.nodays{
   background-color: #d7d7d7;
}
</style>


<%
List<CalendarDto> list = (List)request.getAttribute("flist");
CalendarParam cal = (CalendarParam)request.getAttribute("cal");

/* Calendar를 뿌리기 위한 준비 */
int year = cal.getYear();
int month = cal.getMonth();
int dayOfWeek = cal.getDayOfWeek();
int lastDayOfMonth = cal.getLastday();

//<< year--
String pp = String.format("<a href='%s?year=%d&month=%d'><img src='image/left.gif'></a>", 
                         "calendarlist.do", year-1, month);

// < month-- 
String p = String.format("<a href='%s?year=%d&month=%d'><img src='image/prec.gif'></a>", 
                         "calendarlist.do", year, month-1);

// > month++
String n = String.format("<a href='%s?year=%d&month=%d'><img src='image/next.gif'></a>", 
                         "calendarlist.do", year, month+1);

// >> year++
String nn = String.format("<a href='%s?year=%d&month=%d'><img src='image/last.gif'></a>", 
                         "calendarlist.do", year+1, month);

%>

<div class="box_border" style="margin-top: 5px; margin-bottom: 10px;">
<table style="width: 80%; margin-left: auto;margin-right: auto;">
<col width="100px">
<col width="100px">
<col width="100px">
<col width="100px">
<col width="100px">
<col width="100px">
<col width="100px">

<thead>
	<tr height="100px">
		<td class="days2" colspan="7">
			<%=pp %><%=p %>&nbsp;
			<font color="#707070" style="font-size: 42px; font-weight: bold; ">
				<%=String.format("%d년&nbsp;%d월", year, month) %>
			</font>
			<%=n %><%=nn %>
		</td>	
	</tr>

	<tr height="50px">
		<th class="days3">일</th>
		<th class="days3">월</th>
		<th class="days3">화</th>
		<th class="days3">수</th>
		<th class="days3">목</th>
		<th class="days3">금</th>
		<th class="days3">토</th>
	</tr>	
</thead>

<tbody>
	<tr height="100px">
	<%
	for(int i = 1; i< dayOfWeek; i++){ // dayOfWeek보다 작은 날짜 회색배경 처리
		out.println("<td class='nodays'>&nbsp;</td>");
	}
	
	for(int i = 1; i<=lastDayOfMonth; i++){ // 1부터 마지막 날까지 for문
		if((i + dayOfWeek -1)%7 == 1){  // 일요일
			%>
			<td class="sunday"><%=CalendarUtil.callist(year, month, i)%> &nbsp;<%=CalendarUtil.showPen(year, month, i) %>
				<%=CalendarUtil.makeTable(year, month, i, list)%>
			     </td>   
         <% 
      }else{   //평일
         %>

			
			<td class="otherday"><%=CalendarUtil.callist(year, month, i)%> &nbsp;<%=CalendarUtil.showPen(year, month, i) %>
				<%=CalendarUtil.makeTable(year, month, i, list)%>
			</td>
			
			
			<%
		}
		
		if((i + dayOfWeek -1) % 7 == 0 && i != lastDayOfMonth){ // 토요일이면 tr 한주씩 끊어주기 && 마지막날이 토요일이 아닐때
			%>
				</tr><tr height="100px">
			<%
		}
	}
	 for(int i = 0; i <( 7 - (dayOfWeek + lastDayOfMonth -1)% 7)% 7 ; i++){ // 남은요일 회색날짜 처리
	out.println("<td class='nodays'>&nbsp;</td>");
}
	
	%>
	</tr>
</tbody>



</table>


</div>











