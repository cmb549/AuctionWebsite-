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
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
    	String name = rs.getString("name");
        session.setAttribute("user", userid); // the username will be stored in the session
        session.setAttribute("name", name);
        //out.println("welcome " + userid);
       //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("UserFolder/UserMainScreen.jsp");
    } else {
        out.println("Invalid password");
        out.println("<a href='login.jsp'>try again</a>");
    }
    ApplicationDB.closeConnection(con);

%>
</body>
</html>