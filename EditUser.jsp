<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Edit User</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<% 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement st = con.createStatement();
	String userid = request.getParameter("username");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
    ApplicationDB.closeConnection(con);

	%>
	<form action="UpdateUserInfo.jsp" method="POST">
	  <input type="hidden" name=original_username value="<%=userid%>">
      Username: <input type="text" value = <%=userid%> name="username"/> <br/> <br>
      Password:<input type="text" value = <%=password%> name="password"/> <br/> <br>
      Name:<input type="text" value = <%=name%> name="name"/> <br/> <br>
      Phone:<input type="text" value = <%=phone%> name="phone"/> <br/> <br>
      Email:<input type="text" value = <%=email%> name="email"/> <br/> <br>     
      <input type="submit" value="Confirm Changes"/>
     </form>
     
</body>
</html>