<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.div_page ul{
			display: flex;
			list-style: none;
		}
	</style>
</head>
<body>
	<table width="500" border="1">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>제목</td>
			<td>날짜</td>
			<td>히트</td>
		</tr>
<!-- 		list : 모델객체에서 보낸 이름 -->
		<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.boardNo}</td>
				<td>${dto.boardName}</td>
<%-- 				<td>${dto.boardTitle}</td> --%>
				<td>
<!-- 			content_view : 컨트롤러단 호출 -->
					<!-- <a href="content_view?boardNo=${dto.boardNo}">${dto.boardTitle}</a> -->
					<a class="move_link" href="${dto.boardNo}">${dto.boardTitle}</a>
				</td>
				<td>${dto.boardDate}</td>
				<td>${dto.boardHit}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5">
<!-- 			write_view : 컨트롤러단 호출 -->
				<a href="write_view">글작성</a>
			</td>
		</tr>
	</table>
	<h3>${pageMaker}</h3>
	<div class="div_page">
		<ul>
			<c:if test="${pageMaker.prev}"> <!--이 조건이 참이면 Previous가 나온다 -->
				<!-- <li>[Previous]</li> -->
				<li class="paginate_button">
					<a href="${pageMaker.startpage -1}">
						[Previous]
					</a>
				</li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startpage}" end="${pageMaker.endpage}">
				<!-- <li>[${num}]</li> 대괄호는 가독성용 -->
				<!-- cri안에 pageNum이 있으므로 cri.pageNum --> 
				<!-- <li ${pageMaker.cri.pageNum == num ? "style='color:red'" : ""}> -->
					<li class="paginate_button" ${pageMaker.cri.pageNum == num ? "style='background-color:yellow'" : ""}>
					<!-- [${num}] -->
						<a href="${num}">
							[${num}]
						</a>
					</li>
			</c:forEach>
			<c:if test="${pageMaker.next}"> <!--이 조건이 참이면 next가 나온다 -->
				<!-- <li>[next]</li> -->
				<li class="paginate_button">
					<a href="${pageMaker.endpage +1}">
						[next]
					</a>
				</li>
			</c:if>
		</ul>
	</div>

	<!-- <form id="actionForm" method="get" action="listWithPaging"> -->
	<form id="actionForm" method="get" action="list">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form>
</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script>
	var actionForm = $("#actionForm");

	//페이지 번호 처리
	// $(".paginate_button").on("click", function (e){
	$(".paginate_button a").on("click", function (e){
		// 기본동작 막음: 페이지 링크를 통해서 이동
		e.preventDefault();
		console.log("click~!!!");
		console.log("@# href==>"+$(this).attr("href"));
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});//end of paginate_button click

	//게시글 처리
	//contentView => 페이지번호(클릭시) => 링크
	//contentView => 페이지번호(클릭시)-> 페이징처리(cri 값들 (pageNum, amount)) => actionForm.submit();
	$(".move_link").on("click", function(e){
		e.preventDefault();

		console.log("@# move_link click~!!!");
		console.log("@# href==>"+$(this).attr("href"));

		var targetBno = $(this).attr("href");
		// "content_view?boardNo=${dto.boardNo}" 를 actionForm 으로 처리
		actionForm.append("<input type='hidden' name='boardNo' value='"+targetBno+"'>");
		// actionForm.submit();
		// 컨트롤러에 content_view로 찾아감
		actionForm.attr("action","content_view").submit();
	});//end of move_link click
</script>











