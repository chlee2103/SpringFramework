<%@page import="bit.com.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BbsDto bbs = (BbsDto)request.getAttribute("bbsupdate");
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
<div class="title">
<h1>수정하기</h1>
</div><br>
<div align="center">
<form action="bbsUpdateAf.jsp" method="post">
<table border="1" rules="rows" cellpadding="5" >
<col width="60"><col width="400">
<tr>
	<th>아이디</th>
	<td><input type="text" id="id" value="<%=bbs.getId()%>" size="101" readonly="readonly"></td>
</tr>
<tr>
	<th>제목</th>
	<td><input type="text" id="title" value="<%=bbs.getTitle() %>"  size="101"></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="30" cols="103" id="content"><%=bbs.getContent() %></textarea></td>
</tr>

<tr>
	<th colspan="2" align="center" width="30">
	
	<input type="button" id="bbsUpdate" class="col text-center" value="수정하기">
	<input type="hidden" name="seq" value="<%=bbs.getSeq()%>">
	</th>
</tr>
</table><br><br>
</form>

<script type="text/javascript">
$(document).ready(function() {
	$("#bbsUpdate").click(function() {
		if($("#title").val() == '' ){
			alert("제목을 입력해 주십시오.");
		}else if($("#content").val() == '' ){ 
			alert("내용을 입력해 주십시오.");
		}else{
			$.ajax({
				url:"bbsUpdateAf.do?seq="+<%=bbs.getSeq() %>,
				type:"post",
				data:{"id":$("#id").val(),"title":$("#title").val(), "content":$("#content").val() },
				success:function(data){
					if(data == true){
						alert("게시글이 수정되었습니다.");
						location.href="bbsdetail.do?seq="+<%=bbs.getSeq() %>;
					}
				},
				error:function(){
					alert("삐용삐용");
					return;
				}
			});
		}
	});
});

</script>



</div>
</body>
</html>