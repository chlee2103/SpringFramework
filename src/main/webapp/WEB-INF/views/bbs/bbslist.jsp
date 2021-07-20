<%@page import="bit.com.a.util.BbsArrow"%>
<%@page import="bit.com.a.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<jsp:useBean id="uc" class="bit.com.a.util.BbsArrow"/>
<%-- UtilClass uc = new UtilClas(); --%>


<script type="text/javascript">
/* 문자면 ""도 붙여야 한다. 숫자는 필요 x */
var search = "${search}";

var choice = "${choice}";
$(document).ready(function() {
	if(search != ""){
		$("#_choice").val(choice); // 제이쿼리
		document.getElementById("_search").value = search; // 자바스크립트
	}
});
</script>

<!-- 검색 -->
<div class="box_border" style="margin-top: 5px;margin-bottom: 10px">

<table style="margin-left: auto;margin-right: auto; margin-top: 3px; margin-bottom: 3px">
<tr>
	<td>검색</td>
	<td style="padding-left: 5px">
		<select id="_choice" name="choice">
			<option value="" selected="selected">선택</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>	
	</td>
	<td style="padding-left: 5px">
		<input type="text" id="_search" name="search">
	</td>
	<td style="padding-left: 5px">
		<span class="button blue">
			<button type="button" id="btnSearch">검색</button>
		</span>
	</td>
</tr>
</table>
</div>

<table class="list_table" style="width: 85%" id="_list_table">
<colgroup>
	<col style="width: 70px">
	<col style="width: auto;">
	<col style="width: 80px">
	<col style="width: 100px">
</colgroup>

<tr>
	<th>번호</th><th>제목</th><th>조회수</th><th>작성자</th>
</tr>

<c:if test="${empty bbslist}">
<tr>
	<td colspan="3">작성된 글이 없습니다</td>
</tr>
</c:if>

<c:forEach items="${bbslist}" var="bbs" varStatus="i">

<jsp:setProperty property="depth" name="uc" value="${bbs.depth}"/>

<tr>
	<td>${i.count}</td>
	<td style="text-align: left;">
		
		<c:if test="${bbs.del == 1}">
		게시글이 삭제되었습니다.
		</c:if>
		
		<c:if test="${bbs.del == 0}">
		<jsp:getProperty property="arrow" name="uc"/>	<!-- arrow이미지 -->		
		<a href="bbsdetail.do?seq=${bbs.seq}">
			${bbs.title}
		</a>
		</c:if>
	</td>
	<td>${bbs.readcount}</td>
	<td>${bbs.id}</td>
</tr>
</c:forEach>

</table>
<br>
<!-- 실제 페이지가 뿌려지는 부분 -->
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center;" ></ul>
    </nav>
</div>
<br>

<script type="text/javascript">
let totalCount = ${totalCount}; // 글의 총수
let pageSize = 10;   // 페이지의 크기 1~10 [1]~[10]
let nowPage = ${pageNumber};  // 현재 페이지(첫페이지)

let _totalPages = totalCount / pageSize;
if(totalCount % pageSize > 0){
	_totalPages++;
}

$("#pagination").twbsPagination({
	startPage : nowPage,						// 시작페이지
	totalPages : _totalPages,					// 총 페이지 번호 수
	visiblePages : 10,							// 하단에 한번에 보여지는 페이지 번호 수
	first:'<span sris-hidden="true">«</span>',	// 첫 버튼에 쓰여있는 텍스트
	prev:"이전",									// 이전 페이지 버튼에 쓰여지는 텍스트
	next:"다음",									// 다음 페이지 버튼에 쓰여지는 텍스트
	last:'<span sris-hidden="true">»</span>',	// 마지막 버튼에 쓰여있는 텍스트
	initiateStartPageClick:false,				// 무한루트 방지
	onPageClick:function(event, page){
		location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&pageNumber=" + (page-1);
	}
});

$("#btnSearch").click(function () {
	location.href = "bbslist.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val();	
});
</script>




