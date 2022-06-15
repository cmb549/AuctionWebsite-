<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Account Management</title>
</head>
<body>
<%
Connection con = null;
try {

	//Get the database connection
    con = ApplicationDB.getConnection();//DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	//Get the combobox from the index.jsp
	String str = "SELECT * FROM users";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	
	//Make an HTML table to show the results in:
	out.print("<table >");
	//make a row
	out.print("<tr>");
	//make a column
	out.print("<th>");
	//print out column header
	out.print("Username");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Password");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Name");
	out.print("</th>");
	out.print("<th>");
	out.print("Phone Number");
	out.print("</th>");
	out.print("<th>");
	out.print("Email");
	out.print("</th>");
	out.print("</tr>");
	while (result.next()) {
		//make a row
		String username = result.getString("username");
		String password = result.getString("password");
		String name = result.getString("name");
		String phone = result.getString("phone");
		String email = result.getString("email");
		out.print("<tr>");
		//make a column
		out.print("<td>");
		out.print(username);
		out.print("</td>");
		out.print("<td>");
		out.print(password);
		out.print("</td>");
		out.print("<td>");
		out.print(name);
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(phone);
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(email);
		out.print("</td>");
		out.print("<td>");
		%>
    	<form action="EditUser.jsp">
    		<input type="hidden" name=username value="<%=username%>">
    		<input type="hidden" name=password value="<%=password%>">
    		<input type="hidden" name=name value="<%=name%>">
    		<input type="hidden" name=phone value="<%=phone%>">
    		<input type="hidden" name=email value="<%=email%>">
	    	<input type="submit" name="button_clicked" value="Edit User">	    	
    	</form>
	<%
		out.print("</td>");
		out.print("<td>");
		%>
    	<form action="DeleteUser.jsp">
    		<input type="hidden" name=username value="<%=username%>">
	    	<input type="submit" name="button_clicked" value="Delete User">	    	
    	</form>
	<%
		out.print("</td>");
		out.print("</tr>");
		

	}
	out.print("</table>");
	con.close();
} catch (Exception e) {
}finally{
    ApplicationDB.closeConnection(con);

}
%>
<button onclick = "location.href = 'CRMainPage.jsp'">Return to Home Page</button> <br>
</body>
</html>