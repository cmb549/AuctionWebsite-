<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Item Alerts</title>
</head>
<body>
<h1>Item Alerts</h1>
<%
Connection con = ApplicationDB.getConnection();
try {
	 //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from item_alerts where username = '" + session.getAttribute("user") + "' AND alert_status = 'alert';");
	
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("Item-Type");
	out.print("</th>");
	out.print("<th>");
	out.print("Brand");
	out.print("</th>");
	out.print("<th>");
	out.print("Model");
	out.print("</th>");
	out.print("<th>");
	out.print("Color");
	out.print("</th>");
	out.print("</tr>");
	
	
	while(rs.next()) {
		int auctionId = rs.getInt("auction_id");
		int alertId = rs.getInt("alert_id");
		String item = rs.getString("item_type");
		String model = rs.getString("model");
		String brand = rs.getString("brand");
		String color = rs.getString("color");

		
		out.print("<tr>");
		out.print("<td>");
		out.print(item);
		out.print("</td>");
		out.print("<td>");
		out.print(model);
		out.print("</td>");
		out.print("<td>");
		out.print(brand);
		out.print("</td>");
		out.print("<td>");
		out.print(color);
		out.print("</td>");
		out.print("<td>");
		out.print(color);
		out.print("</td>");
		out.print("<td>");
		
		%>
    	<form action="ViewForum.jsp">
    		<input type="hidden" name=auction_id value="<%=auctionId%>">
	    	<input type="submit" name="button_clicked" value="View Item Details">	    	
    	</form>
		<%
		out.print("</td>");
		
		out.print("<td>");
		%>
    	<form action="MarkAsRead.jsp">
    		<input type="hidden" name=alert_id value="<%=alertId%>">
	    	<input type="submit" name="button_clicked" value="Mark Alert As Read">	    	
    	</form>
		<%
		out.print("</td>");
	}
	
	
} catch (Exception e){
	
} finally {
	ApplicationDB.closeConnection(con);
}


%>
</body>
<button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Page</button></body>
</html>