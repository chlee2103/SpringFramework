<%@page import="bit.com.a.dto.MemberDto"%>
<%@page import="bit.com.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BbsDto bbs = (BbsDto)request.getAttribute("bbsdateil");
MemberDto mem =(MemberDto)session.getAttribute("login");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<br>
<div class="container">
<table style="width: 95%;">
<tr>
	<td align="right">
		<button type="button" id="bbsanswer" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>답글</button>
		<button type="button" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick='location.href="bbslist.do"'>글목록</button>
		<% if(mem != null && (mem.getAuth()==1 || ( mem.getId().equals(bbs.getId() )))){ %>
		<button type="button" id="bbsupdate" class="btn btn-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;' onclick="updateBbs(<%=bbs.getSeq() %>)">수정</button>
		<button type="button" id="bbsdelete" class="btn btn-outline-secondary" style='width:70px; font-size: 13px; padding: 3px 3px 3px 3px;'>삭제</button>
	    <% } %>
	</td>
</tr>
</table>
<br><br>
</div>

<table class="list_table" style="width: 85%;" id="_lest_table">
<tr>
	<td style="text-align: left;">
	<p style="font-size: 25px"><%=bbs.getTitle()%></p>
	<p style="font-size: 15px; color: #808080;"></p><%=bbs.getId()%><br>
	<p style="font-size: 12px; color: #808080;"><%=bbs.getWdate()%>　　조회&nbsp; <%=bbs.getReadcount()%></p>
   </td>
</tr>
<tr height="500px">
   <td  align="left"  style="padding: 10px 10px 10px 10px; text-align: left;vertical-align: top;"><%=bbs.getContent() %></td>
</tr>   
</table>

<script type="text/javascript">
$("#bbsanswer").click(function() {
	location.href="bbsanswer.do?seq="+<%=bbs.getSeq() %>;
});

$("#bbsupdate").click(function() {
	location.href="bbsupdate.do?seq="+<%=bbs.getSeq() %>;
});

$("#bbsdelete").click(function() {
		$.ajax({
			url:"bbsDelete.do",
			type:"get",
			data:{"seq":<%=bbs.getSeq()%>},
			success:function(data){
				if(data == true){
					alert("게시물이 삭제되었습니다");
					location.href = "bbslist.do";
				}
			},
			error:function(){
				alert("삐용삐용");
				return;
			}
		});
	});

</script>


</body>
</html>