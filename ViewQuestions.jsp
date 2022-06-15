<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.io.*,java.util.*,java.sql.*"%>
     <%@ page import ="com.cs336.pkg.ApplicationDB" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Answered Questions</title>
</head>
<body>
<h1>Answered Questions</h1>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String str2 = "SELECT * FROM questions WHERE answer <> 'NULL'";
	ResultSet result2 = stmt.executeQuery(str2);
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("User");
	out.print("</th>");
	out.print("<th>");
	out.print("Questions");
	out.print("</th>");
	out.print("<th>");
	out.print("Answers");
	out.print("</th>");
	out.print("</tr>");
	while(result2.next()) {
		String question = result2.getString("question");
		String user = result2.getString("username");
		String answer = result2.getString("answer");
		out.print("<tr>");
		out.print("<td>");
		out.print(user);
		out.print("</td>");
		out.print("<td>");
		out.print(question);
		out.print("</td>");
		out.print("<td>");
		out.print(answer);
		out.print("</td>");
		out.print("</tr>");
	}
} catch(Exception e){
}finally{
    ApplicationDB.closeConnection(con);

}
%> <button onclick = "location.href = 'CRMainPage.jsp'">Return to Main Page</button></body>
<%
%>
</body>
</html>