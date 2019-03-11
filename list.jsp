<%@page import="java.util.List"%>
<%@page import="com.cho.dto.Round10_MemberDTO"%>
<%@page import="com.cho.dao.Round10_MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchCondition = request.getParameter("searchCondition");
	String searchKeyword = request.getParameter("searchKeyword");
	
	Round10_MemberDTO dto = new Round10_MemberDTO();
	Round10_MemberDAO dao = new Round10_MemberDAO();
	if (searchKeyword != null) {
		if (searchCondition.equals("name")) {
			dto.setName(searchKeyword);
		} else if (searchCondition.equals("address")) {
			dto.setAddress(searchKeyword);
		}
	}
	List<Round10_MemberDTO> memberDTOList = dao.selectList(dto);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>목록 페이지</title>
</head>
<body>
<p/>
<hr/>
<form method="post" action="list.jsp">
	<div>
		<select name="searchCondition">
			<option value="name">이름</option>
			<option value="address">주소</option>
		</select>
		<input name="searchKeyword" type="text" />
		<input type="submit" value="조회" />
	</div>
</form>
<hr/>
<table border="1" cellpadding="1" cellspacing="0">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>생일</th>
		<th>주소</th>
	</tr>
	<% for (int i = 0; i < memberDTOList.size(); i++) { %>
	<tr>
		<td><%=memberDTOList.get(i).getNo() %></td>
		<td><%=memberDTOList.get(i).getName() %></td>
		<td><%=memberDTOList.get(i).getBirthday() == null ? "" :  memberDTOList.get(i).getBirthday() %></td>
		<td><%=memberDTOList.get(i).getAddress() %></td>
	</tr>
	<% } %>
</table>
</body>
</html>