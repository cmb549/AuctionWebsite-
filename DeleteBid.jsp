<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Delete Bid</title>
</head>
<body>
<%@ page import ="java.sql.*" %>

<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<%
	
	//Class.forName("com.mysql.jdbc.Driver");
	Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement st = con.createStatement();
	String bidId = request.getParameter("bid_id");
	int x = st.executeUpdate("DELETE FROM bids WHERE bid_id = '" + bidId + "'");
	/* pstatement.setString(userid,pwd); */
	ApplicationDB.closeConnection(con);

%>
<h1>Bid deleted</h1>
<button onclick = "location.href = 'ManageAuctions.jsp'">Return to Auction List</button> <br>
</body>
</html>