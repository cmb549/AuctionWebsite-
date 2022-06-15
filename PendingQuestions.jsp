<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.io.*,java.util.*,java.sql.*"%>
     <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Pending Questions</title>
</head>
<body>
<h1>Pending Questions</h1>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String username = String.valueOf(session.getAttribute("user"));
	String str = "SELECT * FROM questions WHERE answer = 'NULL' and username = '" + username + "'";
	ResultSet result = stmt.executeQuery(str);
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("Pending Questions");
	out.print("</th>");
	out.print("</tr>");
	while(result.next()) {
		String question = result.getString("question");
		out.print("<tr>");
		out.print("<td>");
		out.print(question);
		out.print("</td>");
		out.print("</tr>");
	}
} catch(Exception e){
} finally{
    ApplicationDB.closeConnection(con);

}
%>
<button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Page</button></body>
</body>
</html>