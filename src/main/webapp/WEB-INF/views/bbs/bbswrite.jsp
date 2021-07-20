<%@page import="bit.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table class="list_table" style="width: 85%" id="_lest_table">
<colgroup>
	<col style="width: 100px">
	<col style="width: auto">
</colgroup> 
<tr>
	<th>글쓴이</th>
	<td style="text-align: left;"><%=mem.getId() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><input type="text" id="title" size="120px"></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="20" cols="100" id="content"></textarea></td>
</tr>	
<tr>
	<td colspan="2" align="center">
		<input type="button" id="_btnWrite" value="작성하기">
	</td>

</tr>
</table>
<script type="text/javascript">
$("#_btnWrite").click(function() {
	if($("#title").val() == ''){
		alert('제목을 작성해주세요.');
		return;
	}
	else if($("#content").val() == ''){
		alert('내용을 작성해주세요.');
		return;
	}
	
	$.ajax({
		url:"bbsWriteAf.do",
		type:"post",
		data:{"id":'<%=mem.getId()%>', "title":$("#title").val(), "content":$("#content").val()},
		success:function(data){
			if(data == true){
				alert('글작성이 완료되었습니다.');
				location.href='bbslist.do';
			}else{
				alert('글작성이 실패되었습니다.');
				return;
			}
		},
		error:function(){
			alert('error');
		}	
	});
});

</script>

</body>
</html>