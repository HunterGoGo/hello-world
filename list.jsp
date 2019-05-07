<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cho.dto.Round10_MemberDTO"%>
<%@ page import="com.cho.dao.Round10_MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchCondition = request.getParameter("searchCondition");
	String searchKeyword = request.getParameter("searchKeyword");
	
	int totalRecord = 0; // 전체 레코드 수
	int numPerPage = 15; // 페이지 당 레코드 수
	int pagePerBlock = 10; // 블럭 당 페이지 수
	
	if (request.getParameter("numPerPage") != null && !request.getParameter("numPerPage").isEmpty()) {
		numPerPage = Integer.parseInt(request.getParameter("numPerPage"));		
	}

	int totalPage = 0; // 전체 페이지 수
	int totalBlock = 0; // 전체 블록 수

	int nowPage = 1; // 현재 페이지
	int nowBlock = 1; // 현재 블럭

	int start = 0; // DB의 select 시작번호
	int end = 15; // 시작번호로 부터 가져올 select 개수
	
	int listSize = 0; // 현재 읽어온 게시물의 수
	
	Round10_MemberDTO dto = new Round10_MemberDTO();
	Round10_MemberDAO dao = new Round10_MemberDAO();
	if (searchCondition == null || searchCondition.isEmpty()) {
		searchCondition = "all";
		searchKeyword = "";
	}
	if (searchKeyword != null && !searchKeyword.isEmpty()) {
		if (searchCondition.equals("name")) {
			dto.setName(searchKeyword);
		} else if (searchCondition.equals("address")) {
			dto.setAddress(searchKeyword);
		} else if (searchCondition.equals("all")) {
			searchKeyword = "";
		}
	}
	
	if (request.getParameter("nowPage") != null && !request.getParameter("nowPage").isEmpty()) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	end = start + numPerPage;
	totalRecord = dao.getTotalCount(dto);
	
	dto.setStart(start);
	dto.setEnd(end);
	List<Round10_MemberDTO> memberDTOList = dao.selectList(dto);
	
	listSize = memberDTOList.size();
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);	// 전체 페이지 수
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);	// 현재블럭 계산
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);// 전채블럭계산
%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>목록 페이지</title>
<style type="text/css">
	a {text-decoration: none; color: black;}
	a:hover {color: grey; font-weight: bold;}
</style>
<script type="text/javascript">
	function paging(page) {
		document.getElementById("nowPage").value = page;
		document.getElementById("listForm").submit();
	}
	
	function block(value) {
		document.getElementById("nowPage").value = <%=pagePerBlock %> * (value - 1) + 1;
		document.getElementById("listForm").submit();
	}
</script>
</head>
<body>
<p></p>
<hr/>
<form method="post" name="listForm" id="listForm" action="list.jsp">
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>"/>
	<div>
		<select name="searchCondition">
			<option value="all" <%=searchCondition.equals("all") ? "selected" : "" %>>전체</option>
			<option value="name" <%=searchCondition.equals("name") ? "selected" : "" %>>이름</option>
			<option value="address" <%=searchCondition.equals("address") ? "selected" : "" %>>주소</option>
		</select>
		<input name="searchKeyword" type="text" value="<%=searchKeyword%>"/>
		<input type="submit" value="조회" />
		<span style="text-align: right;">
			Total : <%=totalRecord %> Articles(<font color="red"><%=nowPage %>/<%=totalPage %>Pages</font>)
		</span>
		표시글수 : 
		<select name="numPerPage" onchange="this.form.submit();">
			<option value="15" <%=numPerPage == 15 ? "selected" : "" %>>15개</option>
			<option value="30" <%=numPerPage == 30 ? "selected" : "" %>>30개</option>
			<option value="50" <%=numPerPage == 50 ? "selected" : "" %>>50개</option>
		</select>
	</div>
</form>
<hr/>
<table border="1" cellpadding="1" cellspacing="0" width="30%">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>생일</th>
		<th>주소</th>
		<th>파일다운</th>
		<th>다운로드</th>
	</tr>
	<%	for (int i = 0; i < numPerPage; i++) {
	   		if (i == listSize) break;
	   		Round10_MemberDTO memberDTO = memberDTOList.get(i); %>
	<tr>
		<td><%=totalRecord - ((nowPage - 1) * numPerPage) - i %></td>
		<td><%=memberDTO.getName() %></td>
		<td><%=memberDTO.getBirthday() == null ? "" :  memberDTO.getBirthday() %></td>
		<td><%=memberDTO.getAddress() %></td>
		<td>
			<input type="button" value="파일생성" 
				onclick="location='down.jsp?fileName=<%=URLEncoder.encode(memberDTO.getName(), "UTF-8") %>'">
		</td>
		<td>
			<input type="button" value="파일다운로드" 
				onclick="location='download.jsp?fileName=<%=URLEncoder.encode(memberDTO.getName(), "UTF-8") %>'">
		</td>
	</tr>
	<% 	} %>
	<tr>
		<td colspan="6" align="center">
		<!-- 페이징 및 블럭 처리 Start -->
	<%	int pageStart = (nowBlock - 1) * pagePerBlock + 1;  // 하단 페이지 시작 번호
		int pageEnd = ((pageStart + pagePerBlock) < totalPage) ? (pageStart + pagePerBlock) : totalPage + 1;  // 하단 페이지 끝 번호
		// int pageEnd = ((pageStart + pagePerBlock) < totalPage) ? pagePerBlock : totalPage;  // 하단 페이지 끝 번호
		if (totalPage != 0) {
			if (nowBlock > 1) { %>
			<&nbsp;<a href="javascript:block('<%=nowBlock - 1 %>');">이전</a>		
	<%		} %>&nbsp;
	<%		for ( ; pageStart < pageEnd; pageStart++) { %>
			<a href="javascript:paging(<%=pageStart %>);">
	<%			if (pageStart == nowPage) { %><font color="blue" style="font-weight: bold;"><% } %>
			[<%=pageStart %>]
	<%			if (pageStart == nowPage) { %></font><% } %>			
			</a>
	<%		} // for %>&nbsp;
	<%		if (totalBlock > nowBlock) { %>
			<a href="javascript:block('<%=nowBlock + 1 %>');">다음</a>&nbsp;>
	<%		} %>&nbsp;
	<%	} %>
		<!-- 페이징 및 블럭 처리 End -->
		</td>
	</tr>
</table>
</body>
</html>