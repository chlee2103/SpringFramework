<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH)+1;
int tday = cal.get(Calendar.DATE);
%>

<form action="pollmakeAf.do" method="post">
<table class="list_table" style="width: 85%">
<col width="100px"><col width="500px">

<tr>
	<th>아이디</th>
	<td style="text-align: left;">
		${login.id}<input type="hidden" name="id" value="${login.id}">
	</td>
</tr>
<tr>
	<th>투표기간</th>
	<td style="text-align: left;">
		<select name="syear">
			<% // 시작년도
			for(int i=tyear; i<tyear+6; i++){
			%> <!-- 젤처음 셀렉트 되는것이 현재년도 -->
			<option <%=(tyear+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i %></option>
			<%
			}
			%>
		</select>년&nbsp;
		<select name="smonth">
			<% 
			for(int i=1; i<=12; i++){
			%> 
			<option <%=(tmonth+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i %></option>
			<%
			}
			%>
		</select>월&nbsp;
		<select name="sday">
			<% 
			for(int i=1; i<= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
			%> 
			<option <%=(tday+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i %></option>
			<%
			}
			%>
		</select>일&nbsp;~&nbsp;
		<select name="eyear">
			<% 
			for(int i=tyear; i<tyear+6; i++){
			%> 
			<option <%=(tyear+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i %></option>
			<%
			}
			%>
		</select>년&nbsp;
		<select name="emonth">
			<%
			for(int i=1; i<=12; i++){
			%> 
			<option <%=(tmonth+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i %></option>
			<%
			}
			%>
		</select>월&nbsp;
		<select name="eday">
			<%
			for(int i=1; i<= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
			%>
			<option <%=(tday+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i %></option>
			<%
			}
			%>
		</select>일
</tr>

<tr>
	<th>투표내용</th>
	<td style="text-align: left;">
		<textarea rows="10" cols="100" name="question"></textarea>
	</td>
</tr>

<tr>
	<th>투표 문항수</th>
	<td style="text-align: left;">
		<!-- this를 하면 이태그(객체)의 전체가 넘어온다 -->
		<select name="itemcount" onchange="pollchange(this)">
		<%
		for(int i=2; i<=10; i++){
		%>	<!-- 문항수 4개로 기본 설정 -->
			<option <%=(4+"").equals(i+"")?"selected='selected'":""%> value="<%=i%>"><%=i%></option>
		<%
		}
		%>
		</select>
	</td>
</tr>

<tr>
	<th>투표 상세 문항</th>
	<td style="text-align: left;">
		<%
		for(int i=1; i<=10; i++){
		%>
			<div id="poll<%=i%>">
				<%=(i + "") %>번:<input type="text" name="poll<%=i %>" size="60">
			</div>
		<%
		}
		%>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="투표만들기">
	</td>
</tr>

</table>
</form>

<script>
$(document).ready(function() {
	
	// 보기 항목을 초기화
	for(i=5; i<=10; i++){
		$("#poll"+i).hide();
	}
});

function pollchange(sel) {
	let val = sel.options[sel.selectedIndex].value; // 옵션에서 선택한 값 저장
//	alert(val);
	
	// 초기화 (다 감추었다가 보여주기)
	// 초기화 해주는 이유는 갯수가 많아졌다가 작아지면 줄어들지 않기 때문에
	for(i=1; i<=10; i++){
		$("#poll"+i).val("");
		$("#poll"+i).hide();
	}
	
	// 설정한 값만큼 보여준다
	for(i=1; i<=val; i++){
		$("#poll"+i).show();
	}
}
</script>