<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Input Forum Answer</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<%
	String answer = request.getParameter("answer");
    String auctionId = request.getParameter("auction_id");
    int aucId = Integer.parseInt(auctionId);
	String question = request.getParameter("question");

	Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    
    if(answer == null || answer.trim().isEmpty()) {
    	out.println("No answer give,");
    	out.println("<a href='ViewAuctions.jsp'>try again</a>");
    } else {
    	String query = "UPDATE item_questions SET answer = '" + answer + "' WHERE auction_id = " + aucId + " and question = '" + question + "'";
    	PreparedStatement pstatement = con.prepareStatement(query);
    	/* pstatement.setString(userid,pwd); */
    	int i = pstatement.executeUpdate();
    	response.sendRedirect("ViewAuctions.jsp");
    }
    ApplicationDB.closeConnection(con);

%>
<br>
<button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Screen</button>
</body>
</html>