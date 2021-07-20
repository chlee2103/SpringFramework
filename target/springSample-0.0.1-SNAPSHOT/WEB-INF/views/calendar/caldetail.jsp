
<%@page import="bit.com.a.dto.CalendarDto"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>caldetail.jsp</title>


</head>
<body>

<%!

// 날짜를 보기 좋게 출력하는 함수
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
CalendarDto cal = (CalendarDto)request.getAttribute("caldetail");
if(cal.getContent() == null){
	cal.setContent("");
}
%>




<table class="list_table" style="width: 85%" id="_lest_table">
<colgroup>
	<col style="width: 100px">
	<col style="width: auto">
</colgroup> 

<tr>
	<th>아이디</th>
	<td><%=cal.getId() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=cal.getTitle() %></td>
</tr>

<tr>
	<th>일정</th>
	<td><%=toDates(cal.getRdate()) %></td>	
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="100" readonly="readonly"><%=cal.getContent() %>
		</textarea>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="button" value="목록" onclick="location.href='calendarlist.do'">
		<input type="button" value="수정" onclick="location.href='calupdate.do?seq=<%=cal.getSeq() %>'">
		<input type="button" value="삭제"  id="btnCalDel">
	</td>
</tr>
</table>

<script type="text/javascript">
$("#btnCalDel").click(function() {
	
	$.ajax({
		url:"calDel.do",
		type:"post",
		data:{"seq":<%=cal.getSeq()%>},
		success:function(data){
			if(data == true){
				alert("일정이 삭제되었습니다");
				location.href="calendarlist.do";
			}else{
				alert("일정이 삭제실패되었습니다");
				return;
			}
		},
		error:function(){
			alert("error");
		}
	})
});
</script>


</body>
</html>



