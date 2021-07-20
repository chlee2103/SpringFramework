
<%@page import="bit.com.a.util.CalendarUtil"%>
<%@page import="bit.com.a.dto.MemberDto"%>
<%@page import="java.util.List"%>


<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String rdate = year + CalendarUtil.two(month + "") + CalendarUtil.two(day + "");
%>

<table id="cal_table" class="list_table" style="width: 85%" id="_lest_table">

</table>


<script type="text/javascript">
$(document).ready(function() {  
	getDayList();
});


function getDayList(){
	$.ajax({
		url:"getDayList.do",
		type:"post",
		data:{
				"id":'<%=mem.getId()%>',
				"rdate":'<%=rdate%>',
				
			 },
		success:function(data){
		//	alert(JSON.stringify(data));
			let str = "";
			if(JSON.stringify(data) == "[]"){
				str += "<tr>";
				str += "<td colspan='4'>";
				str += "등록된 일정이 없습니다.";
				str += "</td>";
				str += "</tr>";
				
				$("#cal_table").html(""); // 초기화
                $("#cal_table").append(str);
			}
			else{
				str = "";
				str += "<tr bgcolor='#09bbaa'>";
				str += "<th>번호</th><th>일정시간</th><th>제목</th><th>삭제</th>";
				str += "</tr>"
				$.each(data, function(index, item) {
					str += "<tr>";
					str += "<td>" + (index+1) + "</td>";
					str += "<td>" + item.rdate.substr(0, 4)+"년 "+ item.rdate.substr(4, 2)+"월 "+ item.rdate.substr(6, 2)+"일 ";
					str += item.rdate.substr(8, 2)+"시 "+item.rdate.substr(10, 2)+"분 "+ "</td>";
					str += "<td><a href='caldetail.do?seq="+item.seq+"'>" + item.title + "</a></td>";
					str += "<td><input type='button' onclick='calDelete("+item.seq+")' value='일정삭제'></td>";
					str += "</tr>";
				});
				$("#cal_table").html(""); // 초기화
                $("#cal_table").append(str);
			}
		},
		error:function(){
			alert("error");
		}
	});
}




function calDelete(seq){
	if(confirm("삭제하시겠습니까 ?") == true){
		 $.ajax({
			url:"calDel.do",
			type:"post",
			data:{"seq":seq},
			success:function(data){
				if(data==true){
					alert("일정이 삭제되었습니다.");
					getDayList();
				}else{
					alert("일정삭제 실패!");
					return;
				}
				getDayList();
			},
			error:function(){
				alert("error");
			}
		 });
	 }else{
		 return;
	 }	 
}


</script>


</body>
</html>











