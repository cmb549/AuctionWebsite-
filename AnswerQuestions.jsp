<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
 
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Customer Question Management</title>
</head>
<body>
<h1>Pending Questions</h1>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String str = "SELECT * FROM questions WHERE answer = 'NULL'";
	ResultSet result = stmt.executeQuery(str);
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("User");
	out.print("</th>");
	out.print("<th>");
	out.print("Unanswered Questions");
	out.print("</th>");
	out.print("<th>");
	out.print("</th>");
	out.print("</tr>");
	while(result.next()) {
		String question = result.getString("question");
		String user = result.getString("username");
		out.print("<tr>");
		out.print("<td>");
		out.print(user);
		out.print("</td>");
		out.print("<td>");
		out.print(question);
		out.print("</td>");
		out.print("<td>");
		%>
    	<form action="InputAnswer.jsp">
    		Answer: <input type="text" name="answer"> <br>
    		<input type="hidden" name=username value="<%=user%>">
    		<input type="hidden" name=question value="<%=question%>">
	    	<input type="submit" name="button_clicked" value="Answer Question">	    	
    	</form>
		<%
		out.print("</td>");
		out.print("</tr>");
	}
	
	%> <br> <%
	
	
} catch(Exception e){
}finally{
    ApplicationDB.closeConnection(con);

}
%>
<button onclick = "location.href = 'CRMainPage.jsp'">Return to Main Page</button></body>
</html>