<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Customer Representative</title>
</head>
<body>
<h1>Welcome, <%=session.getAttribute("user")%></h1>
<button onclick = "location.href = 'EditDeleteAcc.jsp'">Account Management</button> <br> <br>
<button onclick = "location.href = 'AnswerQuestions.jsp'">Pending Questions</button> 
<button onclick = "location.href = 'ViewQuestions.jsp'">Answered Questions</button> <br> <br>
<button onclick = "location.href = 'ManageAuctions.jsp'">Auction Management</button> <br> <br>
<button onclick = "location.href = '../logout.jsp'">Log Out</button> <br>
</body>
</html>