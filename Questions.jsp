<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Questions</title>
</head>
<body>
</body>
<form action = "submitQuestion.jsp" id = "questionform" method = "POST">
	Question: <input type="text" name="question"> <br>
	<input type = "submit">
</form>
<br>
<button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Screen</button>
</html>