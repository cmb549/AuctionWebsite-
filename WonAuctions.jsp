<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Won Auctions</title>
</head>
<body>
<h1>Auctions you have won : </h1>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection();//DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String username = String.valueOf(session.getAttribute("user"));
	String str2 = "SELECT * FROM auction WHERE winner = '" + username + "'";
	ResultSet result2 = stmt.executeQuery(str2);
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
	out.print("<th>");
	out.print("Closing Date");
	out.print("</th>");
	out.print("<th>");
	out.print("Reserve");
	out.print("</th>");
	out.print("<th>");
	out.print("Max Bid");
	out.print("</th>");
	out.print("<th>");
	out.print("Winner");
	out.print("</th>");
	out.print("</tr>");
	while(result2.next()) {
		String auction_id = result2.getString("auction_id");
		String item = result2.getString("item_type");
		String model = result2.getString("model");
		String brand = result2.getString("brand");
		String color = result2.getString("color");
		String reserve = result2.getString("reserve");
		java.sql.Timestamp dateObj = result2.getTimestamp("closing_date");
		String date = dateObj.toString();
		String maxBid = result2.getString("max_bid");
		String winner = result2.getString("winner");
		if(winner.equals("NULL")) {
			winner = "";
		} 
		
		out.print("<tr>");
		out.print("<td>");
		out.print(item);
		out.print("</td>");
		out.print("<td>");
		out.print(brand);
		out.print("</td>");
		out.print("<td>");
		out.print(model);
		out.print("</td>");
		out.print("<td>");
		out.print(color);
		out.print("</td>");
		out.print("<td>");
		out.print(date);
		out.print("</td>");
		out.print("<td>");
		out.print(reserve);
		out.print("</td>");
		out.print("<td>");
		out.print(maxBid);
		out.print("</td>");
		out.print("<td>");
		out.print(winner);
		out.print("</td>");
		out.print("</tr>");
			
		
	}
	out.print("</table >");
} catch(Exception e){
	System.out.println(" Exception occured in view won auctions " + e.getMessage());
}finally{
    ApplicationDB.closeConnection(con);

}
%> <button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Page</button></body>
<%
%>
</body>
</html>