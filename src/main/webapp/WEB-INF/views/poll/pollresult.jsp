<%@page import="bit.com.a.poll.PollSubDto"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<%
	List<PollSubDto> list = (List)request.getAttribute("pollsublist");

	String labelsd = "[";
	
	for(PollSubDto p : list){
		labelsd += "'"+p.getAnswer() + "',";
	}
	labelsd = labelsd.substring(0, labelsd.lastIndexOf(","));
	labelsd += "]";
	System.out.println(labelsd);
	
	String text = "[";

	for(PollSubDto p : list){
		text += p.getAcount() + ", ";
	}
	text = text.substring(0, text.lastIndexOf(","));
	text += "]";
	System.out.println(text);
%>

<table class="list_table" style="95%">
<col width="200px"><col width="500px">
<tr>
	<th>투표번호</th>
	<td style="text-align: left;">
		<input type="text" value="${poll.pollid}" size="50" readonly>
	</td>
</tr>
<tr>
	<th>아이디</th>
	<td style="text-align: left;">
		<input type="text" value="${poll.id}" size="50" readonly>
	</td>
</tr>
<tr>
	<th>투표기한</th>
	<td style="text-align: left;">
		<input type="text" value="${poll.sdate} ~ ${poll.edate}" size="50" readonly>
	</td>
</tr>
<tr>
	<th>투표내용</th>
	<td style="text-align: left;">
		<input type="text" value="${poll.question}" size="50" readonly>
	</td>
</tr>
<tr>
	<th>통계</th>
	<td>
		<div style="width: 400px; height: 400px;" >
		<canvas id="pie-chart"></canvas>
		</div>
	</td>
</tr>

</table>

<script>
new Chart(document.getElementById("pie-chart"), {
    type: 'pie',
    data: {
      labels: <%=labelsd%>, /* [1, 2, 3, 4,] */
      datasets: [{
        label: "Population (millions)",
        backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
        data: <%=text%>
      }]
    },
    options: {
      title: {
        display: true,
        text: '${poll.question}' /* [1, 2, 3, 4,] */
      }
    }
});
</script>