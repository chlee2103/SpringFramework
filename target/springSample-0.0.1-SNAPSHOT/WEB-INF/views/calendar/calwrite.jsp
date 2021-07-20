<%@page import="bit.com.a.util.CalendarUtil"%>
<%@page import="bit.com.a.dto.CalendarParam"%>
<%@page import="bit.com.a.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    

<%


String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
%>  
	<script>
	alert("로그인 해 주십시오");
	location.href = "login.do";
	</script>	
<%
}
%>



<%
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
int thour = cal.get(Calendar.HOUR_OF_DAY);
int tmin = cal.get(Calendar.MINUTE);



cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
%>

<div align="center">

<table class="list_table" style="width: 85%" id="_lest_table">
<colgroup>
	<col style="width: 100px">
	<col style="width: auto">
</colgroup> 
<tr>
	<th>글쓴이</th>
	<td style="text-align: left;">
		<%=mem.getId() %>
		<input type="hidden" name="id" value="<%=mem.getId() %>">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" size="120px" id="title" name="title">
	</td>
</tr>
<tr>
	<th>일정</th>
	<td>
		<select name="year" id="year">
		<%
			for(int i = tyear - 5;i <= tyear + 5; i++){
				%>	
				<option <%=year.equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>
				
				<%
			}		
		%>		
		</select>년	
		
		<select name="month" id="month">
		<%
			for(int i = 1;i <= 12; i++){
				%>	
				<option <%=month.equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>
				
				<%
			}		
		%>		
		</select>월
		
		<select name="day" id="day">
		<%
			for(int i = 1;i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
				%>	
				<option <%=day.equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%
			}		
		%>		
		</select>일
		
		<select name="hour" id="hour">
		<%
			for(int i = 1;i < 24; i++){
				%>	
				<option <%=(thour + "").equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%
			}		
		%>		
		</select>시
		
		<select name="min" id="min">
		<%
			for(int i = 0;i < 60; i++){
				%>	
				<option <%=(tmin + "").equals(i + "")?"selected='selected'":"" %> value="<%=i %>">
					<%=i %>
				</option>				
				<%
			}		
		%>		
		</select>분	
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="100" id="content" name="content"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="button" id="btn_calwrite" value="일정추가">
	</td>
</tr>
</table>

</div>

<script type="text/javascript">

$(document).ready(function() {
	
	$("select[name='month']").change( setDay );	
	
	
});

function setDay() {
//	alert('setDay()');
	let year = $("select[name='year']").val();
	let month = $("select[name='month']").val();

	let lastday = (new Date(year, month, 0)).getDate();
//	alert(lastday);

	// 날짜 적용
	let str = '';
	for(i = 1;i <= lastday; i++){
		str += "<option value='" + i + "'>" + i + "</option>";
	}
	
	$("select[name='day']").html(str);
	
	$("select[name='day']").val("<%=day %>");
}


$("#btn_calwrite").click(function() {
	
	if($("#title").val() == ""){
		alert("제목을 입력해주십시오.");
		return;
	}
	
	let rdate = $("#year").val() + two($('#month').val()) + two($('#day').val()) + two($('#hour').val()) + two($('#min').val());
	
	let data = {
				"id":'<%=mem.getId()%>',
				"title": $("#title").val(),
				"content": $("#content").val(),
				"rdate" : rdate
				};
	
	$.ajax({
		url:"calwriteAf.do",
		type:"post",
		data: data,
		success:function(data){
			if(data == true){
				alert("일정이 추가되었습니다");
				location.href="calendarlist.do";
			}else{
				alert("일정이 실패되었습니다");
				return;
			}
		},
		error:function(){
			alert("error");
		}
	});
});

function two( msg ) {
	let str = "";
	if( msg.length < 2 ){
		str += "0" + msg;
		return str;
	}
	
	return msg;
}


</script>



</body>
</html>








