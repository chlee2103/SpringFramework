<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<table class="list_table" style="85%">
<col width="200px"><col width="500px">
<tr>
	<th>대화명</th>
	<td style="text-align: left;">
		<input type="text" id="name">
		<input type="button" id="enterBtn" value="입장" onclick="connect()">
		<input type="button" id="exitBtn" value="나가기" onclick="disconnect()">
	</td>
</tr>
<tr>
	<th>아이디</th>
	<td style="text-align: left;">
		<input type="text" id="id" value="${login.id}">
	</td>
</tr>
<tr>
	<td colspan="2">
		<textarea rows="10" cols="70" id="MessageArea"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="text" id="message" size="50" onKeyDown="pressEnter()" > 
		<input type="button" id="sendBtn" value="전송" onclick="send()">
	</td>
</tr>

</table>

<script>
var wsocket;

function connect() {
	if(wsocket != undefined && wsocket.readyState != WebSocket.CLOSED){
		alert('이미 입장하셨습니다');
		return;
	}
	
	// web socket 생성
//	if($("#name").val() == "aaa"){ // 첫번째 대화명은 aaa로 해야한다.
		// ip주소로 바로 접속하려면 서버만 start하고 url복사 후 직접 켜야 한다.
	//	wsocket = new WebSocket("ws://192.168.0.8:8090/springSample_cho/echo.do");
//		wsocket = new WebSocket("ws://localhost:8090/springSample_cho/echo.do");
//	}else{
		wsocket = new WebSocket("ws://localhost:8090/springSample_cho/echo.do");
//	}
	wsocket.onopen = onOpen;
	wsocket.onmessage = onMessage;
	wsocket.close = onClose;
	
}

function disconnect() {
	wsocket.close();
	location.href = "chating.do";
}

function onOpen(evt) {	// websocket에 연결되었을 때
	appendMessage('서버에 연결되었습니다.');
}

function onMessage(evt) {// recv(수신)이 되었을 때
	let data = evt.data;
	if( data.substring(0, 4) == "msg:"){
		appendMessage(data.substring(4));
	}
}

function onClose(evt) { // websocket에 연결이 끊겼을 때
	appendMessage('서버에 연결이 끊겼습니다.');
}

function send() {
	let id = $("#name").val(); // 대화명
	let msg = $("#message").val(); // 메세지
	
	wsocket.send("msg:" + id + ":" + msg); // msg:아이디:내용 
	$("#message").val("");
}

//textarea에 문자열 추가 함수
function appendMessage(msg) { 
	$("#MessageArea").append(msg +"\n");
	
	// 스크롤을 위로 이동시킨다.
	const top = $("#MessageArea").prop("scrollHeight");
	$("#MessageArea").scrollTop(top);
}

function pressEnter(){
    if(event.keyCode == 13){ // 13번 엔터
    	send();
    }
}
</script>