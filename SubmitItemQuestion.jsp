<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>  
        <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Submit Item Question</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
    String question = request.getParameter("question");
	String user = String.valueOf(session.getAttribute("user"));
	String auctionId = request.getParameter("auction_id");
	Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    
    if(question == null || question.trim().isEmpty()) {
    	out.println("No question asked,");
    	out.println("<a href='ViewForum.jsp'>try again</a>");
    } else {
    	String queryStr = "INSERT INTO item_questions(auction_id, question, answer, questioner) VALUES('" + auctionId + "', '"  + question + "', '"  + "NULL" + "', '" + user + "')";
    	PreparedStatement pstatement = con.prepareStatement(queryStr);
    	/* pstatement.setString(userid,pwd); */
    	int i = pstatement.executeUpdate();
    	out.println("Question asked");
    	response.sendRedirect("BrowseAuctions.jsp");
    }
    
    ApplicationDB.closeConnection(con);

%>
</body>
</html>