<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
																	<!-- multipart : byte와 문자가 함께 넘거가기 때문에 -->
<form name="frmForm" id="_frmForm" action="pdsupload.do" method="post" enctype="multipart/form-data">
											  <!-- 파일 업로드시 : "post" -->
						
						
<table class="list_table">
<tr>
	<th>아이디</th>
	<td style="text-align: left;">
		<input type="text" name="id" readonly value="${login.id}"> <!-- login.id:세션에 있는 id값 불러오기 -->
	</td>	
</tr>
<tr>
	<th>제목</th>
	<td style="text-align: left;">
		<input type="text" name="title" size="50" >
	</td>	
</tr>
<tr>
	<th>파일 업로드</th>
	<td style="text-align: left;">
		<input type="file" name="fileload" style="width: 400px">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td style="text-align: left;">	<!-- textarea 대신 사용가능 : 썸머노트, 스마트에디터(사진도 같이 올릴 수 있음) -->
		<textarea rows="10" cols="50" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" style="height: 50px; text-align: center;">
		<a href="#none" id="_btnPds" title="자료올리기">
			<img alt="" src="image/bwrite.png">
		</a>
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