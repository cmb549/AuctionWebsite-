<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Question Submitted</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
    String question = request.getParameter("question");
	String user = String.valueOf(session.getAttribute("user"));
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    
    if(question == null || question.trim().isEmpty()) {
    	out.println("No question asked,");
    	out.println("<a href='Questions.jsp'>try again</a>");
    } else {
    	String queryStr = "INSERT INTO questions(username, question, answer) VALUES('" + user + "', '"  + question + "', '"  + "NULL" +  "')";
    	PreparedStatement pstatement = con.prepareStatement(queryStr);
    	/* pstatement.setString(userid,pwd); */
    	int i = pstatement.executeUpdate();
    	out.println("Question asked");
    	response.sendRedirect("UserMainScreen.jsp");
    }
    
    ApplicationDB.closeConnection(con);

%>
</body>
</html>