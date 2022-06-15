<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="InputAccount.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/> <br/>
       Password:<input type="password" name="password"/> <br/> <br/>
       Confirm Password:<input type = "password" name = "confirm_pass"/> <br/> <br/>
       Name:<input type="text" name = "name"/> <br/> <br/>
       Phone Number:<input type="text" name = "phone"/> <br/> <br/>
       Email:<input type="text" name = "email"/> <br/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <button onclick = "location.href = 'login.jsp'">Return to Login</button>
</body>
</html>