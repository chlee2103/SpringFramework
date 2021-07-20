
<%@page import="bit.com.a.dto.CalendarDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>calupdate</title>
</head>
<body>

<%!
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	
	String s = mdate.substring(0, 4) + "-" 	// yyyy
			+ mdate.substring(4, 6) + "-"	// MM
			+ mdate.substring(6, 8) + " " 	// dd
			+ mdate.substring(8, 10) + ":"	// hh
			+ mdate.substring(10, 12) + ":00"; 
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);	
}

public String toOne(String msg){	// 08 -> 8
	return msg.charAt(0)=='0'?msg.charAt(1) + "": msg.trim();
}

%>

<%
Calendar cals = Calendar.getInstance();
int tyear = cals.get(Calendar.YEAR);


CalendarDto cal = (CalendarDto)request.getAttribute("caldetail");
if(cal.getContent() == null){
	cal.setContent("");
}

String year = cal.getRdate().substring(0, 4);
String month = toOne(cal.getRdate().substring(4, 6));
String day = toOne(cal.getRdate().substring(6, 8));
String hour = toOne(cal.getRdate().substring(8, 10));
String min = toOne(cal.getRdate().substring(10, 12));

%>


<h1>일정 수정</h1>
<hr>

<div align="center">




<table class="list_table" style="width: 85%" id="_lest_table">
<colgroup>
	<col style="width: 100px">
	<col style="width: auto">
</colgroup> 

<tr>
	<th>아이디<input type="hidden" name="seq" id="seq" value="<%=cal.getSeq() %>">
	</th>
	<td>
		<input type="text" name="id" value="<%=cal.getId() %>" readonly="readonly">
	</td>
</tr> 

<tr>
	<th>제목</th>
	<td>
		<input type="text" size="60" id="title" name="title" value="<%=cal.getTitle() %>">
	</td>
</tr>

<tr>
	<th>일정</th>
	<td>
	
	<select id="year" name="year">
	<%
	for(int i = tyear - 5;i < tyear + 6; i++){
		%>
		<option <%=year.equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>년	
	
	<select id="month" name="month">
	<%
	for(int i = 1;i <= 12; i++){
		%>
		<option <%=month.equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>월
	
	<select id="day" name="day">
	<%
	for(int i = 1;i <= cals.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
		%>
		<option <%=day.equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>일
	
	<select id="hour" name="hour">
	<%
	for(int i = 0;i < 24; i++){
		%>
		<option <%=(hour + "").equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>시
	
	<select id="min" name="min">
	<%
	for(int i = 0;i < 60; i++){
		%>
		<option <%=(min + "").equals(i + "")?"selected='selected'":"" %> 
			value="<%=i %>"><%=i %></option>		
		<%	
	}	
	%>	
	</select>분
	
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="60" id="content" name="content"><%=cal.getContent() %> </textarea>
	</td>
</tr>

<tr>
	<td colspan="2">
		<input type="button" value="수정" id="btnCalUpdate">
	</td>
</tr>


</table>


</div>

<script type="text/javascript">
$("#btnCalUpdate").click(function() {
//	alert("click");
	let rdate = $("#year").val() + two($("#month").val()) + two($("#day").val()) + two($("#hour").val()) + two($("#min").val());
//	alert(rdate);
	let datas = {
				"seq":$("#seq").val(),
				"title":$("#title").val(),
				"content":$("#content").val(),
				"rdate":rdate
				}
	alert(JSON.stringify(datas));
	$.ajax({
		url:"calUpdateAf.do",
		type:"post",
		data:datas,
		success:function(data){
			if(data == true){
				alert("일정이 수정되었습니다");
				location.href="calendarlist.do";
			}else{
				alert("일정이 수정실패되었습니다");
				return;
			}
		},
		error:function(){
			alert("error");
		}
	});
});

function two(msg) {
	let str = "";
	if(msg.length <2){
		str = "0"+msg;
		return str;
	}
	return msg;
}

</script>

<%
String url = String.format("%s?year=%s&month=%s", 
						"calendarlist.do", year, month);
%>

<a href="<%=url %>">일정보기</a>

</body>
</html>





