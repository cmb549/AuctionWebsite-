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
<%@ page import ="java.sql.*" %>
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    String pwdCheck = request.getParameter("confirm_pass");
    String name = request.getParameter("name");
    String phoneNum = request.getParameter("phone");
    String email = request.getParameter("email");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + userid + "'");
    if (rs.next()) {
    	out.println("Username already taken,");
    	out.println("<a href='CreateAccount.jsp'>try again</a>");
    } else if(!(pwd.equals(pwdCheck))) {
    	out.println("Passwords don't match, ");
    	out.println("<a href='CreateAccount.jsp'>try again</a>");
    } else if(userid.trim().isEmpty() || pwd.trim().isEmpty() || name.trim().isEmpty() || phoneNum.trim().isEmpty() || email.trim().isEmpty()) {
    	out.println("Missing information, ");
    	out.println("<a href='CreateAccount.jsp'>try again</a>");
    } else {
    	//out.println("insert into BuyMe values('" + userid + "', '"  + pwd + "');");
    	String queryStr = "INSERT INTO users(username, password, name, phone, email) VALUES('" + userid + "', '"  + pwd + "', '"  + name + "', '"  + phoneNum + "', '"  + email + "')";
    	PreparedStatement pstatement = con.prepareStatement(queryStr);
    	/* pstatement.setString(userid,pwd); */
    	int i = pstatement.executeUpdate();
    	session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("UserFolder/UserMainScreen.jsp");
    }
    ApplicationDB.closeConnection(con);
%>
</body>
</html>