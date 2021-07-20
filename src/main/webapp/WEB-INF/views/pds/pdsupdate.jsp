<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form name="frmForm" id="_frmForm" action="pdsupdateAf.do" method="post" enctype="multipart/form-data">
<table class="list_table">
<tr>
	<th>제목</th>
	<td style="text-align: left;">
		<input type="text" name="title" size="50" value="${pds.title}">
		<input type="hidden" name="seq" value="${pds.seq}">
	</td>	
</tr>
<tr>
	<th>현재 파일</th>
	<td style="text-align: left;">
		<input type="text" style="width: 400px" readonly value="${pds.filename}">
		
	</td>
</tr>
<tr>
	<th>파일변경</th>
	<td style="text-align: left;">
		<input type="file" name="fileload" style="width: 400px" value="${pds.filename}">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td style="text-align: left;">
		<textarea rows="10" cols="50" name="content" >${pds.content}</textarea>
	</td>
</tr>
<tr>
	<td colspan="2" style="height: 50px; text-align: center;">
		<input type="button" id="_btnPds" value="수정하기">
		<input type="button" value="수정취소" onclick="location.href='pdslist.do'">
	</td>
</tr>
</table>
</form>
<script>
$("#_btnPds").click(function() {
	// 빈칸 체크
	
	
	$("#_frmForm").submit();
		
});
</script>
