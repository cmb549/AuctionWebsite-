<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Answer Question</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<%
    String answer = request.getParameter("answer");
	String username = request.getParameter("username");
	String question = request.getParameter("question");

	Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    
    if(answer == null || answer.trim().isEmpty()) {
    	out.println("No answer give,");
    	out.println("<a href='AnswerQuestions.jsp'>try again</a>");
    } else {
    	String query = "UPDATE questions SET answer = '" + answer + "' WHERE username = '" + username + "' and question = '" + question + "'";
    	PreparedStatement pstatement = con.prepareStatement(query);
    	/* pstatement.setString(userid,pwd); */
    	int i = pstatement.executeUpdate();
    	response.sendRedirect("AnswerQuestions.jsp");
    }
    ApplicationDB.closeConnection(con);

%>
<br>
<button onclick = "location.href = 'AnswerQuestions.jsp'">Return to Main Screen</button>
</body>
</html>