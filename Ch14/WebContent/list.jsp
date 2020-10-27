<%@page import="member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
	// DB 정보
		String host = "jdbc:mysql://192.168.44.46:3306/kkm";
		String user = "kkm";
		String pass = "1234";
		
	// 1단계
		Class.forName("com.mysql.jdbc.Driver");
	
	// 2단계
		Connection conn = DriverManager.getConnection(host, user, pass);
	
	// 3단계
		Statement stmt = conn.createStatement();
	
	// 4단계
		String sql = "SELECT * FROM `MEMBER`ORDER BY `rdate` ASC";
		ResultSet rs = stmt.executeQuery(sql);
	
	// 5단계
		List<MemberBean> memberList = new ArrayList<>();
		
		while(rs.next()){
			
			MemberBean mb = new MemberBean();
			
			/* 정석 표기
			String uid = rs.getString(1);
			String name = rs.getString(2);
			String hp = rs.getString(3);
			String pos = rs.getString(4);
			int    dep = rs.getInt(5);
			String rdate = rs.getString(6);
			
			mb.setUid(uid);
			mb.setName(name);
			mb.setHp(hp);
			mb.setPos(pos);
			mb.setDep(dep);
			mb.setRdate(rdate); 
			*/
			
			// 요약
			mb.setUid(rs.getString(1));
			mb.setName(rs.getString(2));
			mb.setHp(rs.getString(3));
			mb.setPos(rs.getString(4));
			mb.setDep(rs.getInt(5));
			mb.setRdate(rs.getString(6));
			
			memberList.add(mb);
		}
	
	// 6단계
		rs.close();
		stmt.close();
		conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>

<script>
	function onDelete() {
		
		var result = confirm("정말 삭제하시겠습니까?");
		return result;
	}
</script>

</head>
<body>
	<h3>직원목록</h3>
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>직급</th>
			<th>부서</th>
			<th>입사일</th>
			<th>기타</th>
		</tr>
		
	<%-- 			
		<% for(int i=0; i<memberList.size(); i++) { 
			MemberBean mb = memberList.get(i);
		%>
		<tr>
			<td><%= mb.getUid() %></td>
			<td><%= mb.getName() %></td>
			<td><%= mb.getHp() %></td>
			<td><%= mb.getPos() %></td>
			<td><%= mb.getDep() %></td>
			<td><%= mb.getRdate().substring(0, 10) %></td>
			<td>
				<a href="#">삭제</a>
				<a href="#">수정</a>
			</td>
		</tr>
		<% } %>  		
	--%>

	<%-- 
		<% for(int i=0; i<memberList.size(); i++) { %>
		<tr>
			<td><%= memberList.get(i).getUid() %></td>
			<td><%= memberList.get(i).getName() %></td>
			<td><%= memberList.get(i).getHp() %></td>
			<td><%= memberList.get(i).getPos() %></td>
			<td><%= memberList.get(i).getDep() %></td>
			<td><%= memberList.get(i).getRdate().substring(0, 10) %></td>
			<td>
				<a href="#">삭제</a>
				<a href="./modifyForm.jsp?uid=정약용id">수정</a>
			</td>
		</tr>
		<% } %> 
	--%>
		
		<% for(MemberBean mb : memberList) { %>
		<tr>
			<td><%= mb.getUid() %></td>
			<td><%= mb.getName() %></td>
			<td><%= mb.getHp() %></td>
			<td><%= mb.getPos() %></td>
			<td><%= mb.getDep() %></td>
			<td><%= mb.getRdate().substring(0, 10) %></td>
			<td>
				<a href="./delete.jsp" onclick="return onDelete()">삭제</a>
				<a href="./modifyForm.jsp?uid=<%= mb.getUid() %>">수정</a>
			</td>
		</tr>
		<% } %>
	</table>	
	
	<a href="./regForm.jsp">직원 등록하기</a>
	
</body>
</html>