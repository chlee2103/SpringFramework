<%@page import="bit.com.a.dto.PdsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
PdsDto pds = (PdsDto)request.getAttribute("pds");
%>

<table class="list_table" style="width: 85%">
<colgroup>
	<col style="width: 100px">
	<col style="width: auto">
</colgroup> 
<tr>
	<th>게시자</th>
	<td style="text-align: left;">${pds.id}</td>	
</tr>
<tr>
	<th>제목</th>
	<td style="text-align: left;">${pds.title}</td>
</tr>
<tr>
	<th>다운로드</th>
	<td style="text-align: left;">
		<input type="button" value="파일다운" onclick="location.href='fileDownload.do?newfilename=${pds.newfilename}&seq=${pds.seq}&filename=${pds.filename}'">  
	</td>
</tr>
<tr>
	<th>조회수</th>
	<td style="text-align: left;">${pds.readcount }</td>
</tr>

<tr>
	<th>다운수</th>
	<td style="text-align: left;">${pds.downcount}</td>
</tr>

<tr>
	<th>파일명</th>
	<td style="text-align: left;">${pds.filename}</td>
</tr>
<tr>
	<th>등록일</th>
	<td style="text-align: left;">${pds.regdate}</td>
</tr>
<tr>
	<th>내용</th>
	<td style="text-align: left;">
		<img src="upload\'${pds.newfilename}'"><br>
		<img src="upload\&#36;{pds.newfilename}"><br>
		<img alt="사진형식만 보여집니다." src="upload\<%=pds.getNewfilename()%>"><br>
		<textarea rows="20" cols="50" readonly="readonly">
		${pds.content}</textarea>
	</td>
</tr>
</table>

<br>
<input type="button" value="글목록" onclick="location.href='pdslist.do'" >
<c:if test="${login.id eq pds.id}">
<input type="button" value="수정" onclick="location.href='pdsupdate.do?seq=${pds.seq}'" >
<input type="button" name="btnDel" value="삭제" onclick="location.href='pdsdel.do?pdsseq=${pds.seq}&pdsid=${pds.id}'"/>
</c:if>
<script type="text/javascript">
/* function fileDown(newfilename, seq, filename){
//	alert(filename +", "+ seq +", "+newfilename );
	$.ajax({
		url:"fileDownload.do",
		type:"get",
		data:{
		      "newfilename":newfilename,
     		  "seq":seq,
			  "filename":filename 
		},
		success:function(data){
		//	alert(seq);
			 location.href ='pdsdetail.do?seq='+seq;
		},
		error:function(){
			alert('error');
		}
	});
}	 */

</script>




