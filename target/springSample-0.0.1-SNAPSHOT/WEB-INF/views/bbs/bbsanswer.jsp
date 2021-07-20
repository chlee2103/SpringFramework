<%@page import="bit.com.a.dto.MemberDto"%>
<%@page import="bit.com.a.dto.BbsDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%


BbsDto bbs = (BbsDto)request.getAttribute("bbsAnswer");

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>
<body>

<br>
<div align="left" style="padding-left: 80px">
<h4>원본글</h4>
</div>

<br>
<div align="center">
<table class="list_table" style="width: 85%;" id="_lest_table">
<tr>
	<td style="text-align: left;">
	<p style="font-size: 25px"><%=bbs.getTitle() %></p>
	 <p style="font-size: 15px; color: #808080;"></p><%=bbs.getId() %><br>
   <p style="font-size: 12px; color: #808080;"><%=bbs.getWdate() %>　　조회&nbsp; <%=bbs.getReadcount()%></p>
   </td>
</tr>
<tr height="200px">
   <td  align="left"  style="padding: 10px 10px 10px 10px; text-align: left;vertical-align: top;"><%=bbs.getContent() %></td>
</tr>   
</table>
</div><br><br><hr>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<div align="left" style="padding-left: 80px">
<h4>답글</h4>
</div>

<div align="left" class="container" style="width: 850px" >
	<hr>
	<textarea rows="1" cols="70" id="title" name="title" style=" margin: 0px; border-color: white; font-size: 25px" placeholder="제목을 입력하세요."></textarea><hr>
    <textarea rows="10" cols="85" id="content" name="content"style=" margin: 0px; border-color: white; font-size: 20px" placeholder="내용을 입력하세요."></textarea><hr>
</div>	
<div align="center" class="container" style="width: 850px" >	
	<input  type="button" id="answer" class="btn btn-secondary" value="글쓰기">
</div>
<br>


<script type="text/javascript">
$("#answer").click(function() {
	$.ajax({
		url:"bbsAnswerAf.do",
		type:"post",
		data:{"id":'<%=mem.getId()%>', "title":$("#title").val(), "content":$("#content").val(), "seq":<%=bbs.getSeq()%>},
		success:function(data){
			if(data == true){
				alert('답글 작성이 완료되었습니다');
				location.href='bbslist.do';
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