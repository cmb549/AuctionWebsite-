<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta charset="UTF-8">
<title>Customer Representative Login</title>
</head>
<body>
<form action="CRLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/> <br>
       Password:<input type="password" name="password"/> <br/> <br>
       <input type="submit" value="Log In"/>
     </form>
     <button onclick = "location.href = 'login.jsp'">Return to Main Login</button>
</body>
</html>