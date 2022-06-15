<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>User Info Updated</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
	String originalUID = request.getParameter("original_username");
    String userid = request.getParameter("username");   
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from users where username='" + userid + "'");

    if(userid.trim().isEmpty() || password.trim().isEmpty() || name.trim().isEmpty() || phone.trim().isEmpty() || email.trim().isEmpty()) {
    	out.println("Missing information, ");
    	out.println("<a href='EditDeleteAcc.jsp'>try again</a>");
    } else if(!originalUID.equals(userid) && rs.next()) {
        out.println("Username already taken,");
        out.println("<a href='EditDeleteAcc.jsp'>try again</a>");       
    } else {
    	//String query = "UPDATE users SET username = '" + userid + "' WHERE username = '" + originalUID + "'";
    	String query = "UPDATE users SET username = '" + userid + "', password = '" + password + "', name = '" + name + "', phone = '" + phone + "', email = '" + email + "' WHERE username = '" + originalUID + "'";
    	st.executeUpdate(query);
    	out.println("Success,");
    	out.println("<a href='EditDeleteAcc.jsp'>return to users</a>");
    }
    ApplicationDB.closeConnection(con);

%>
	
</body>
</html>