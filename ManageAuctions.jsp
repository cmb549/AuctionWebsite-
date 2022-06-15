<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Auction Management</title>
</head>
<body>
<h1>Auction Management</h1>
<%
Connection con = null;
try {

	//Get the database connection
    con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	//Get the combobox from the index.jsp
	String str = "SELECT * FROM auction";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	
	//Make an HTML table to show the results in:
	out.print("<table >");
	//make a row
	out.print("<tr>");
	//make a column
	out.print("<th>");
	//print out column header
	out.print("Seller");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Item Type");
	out.print("</th>");
	//make a column
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
	while (result.next()) {
		//make a row
		String seller = result.getString("seller");
		String item = result.getString("item_type");
		String model = result.getString("model");
		String brand = result.getString("brand");
		String color = result.getString("color");
		String reserve = result.getString("reserve");
		java.sql.Date dateObj = result.getDate("closing_date");
		String date = dateObj.toString();
		String maxBid = result.getString("max_bid");
		String winner;
		if(result.getString("winner").equals("NULL")) {
			winner = "";
		} else {
			winner = result.getString("winner");
		}
		out.print("<tr>");
		//make a column
		out.print("<td>");
		out.print(seller);
		out.print("</td>");
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
		out.print("<td>");
		int auctionId = result.getInt("auction_id");
		%>
    	<form action="DeleteAuction.jsp">
    		<input type="hidden" name=auction_id value="<%=auctionId%>">
	    	<input type="submit" name="button_clicked" value="Delete Auction">	    	
    	</form>
	<%
	%>
	<form action="ViewBids.jsp">
		<input type="hidden" name=auction_id value="<%=auctionId%>">
    	<input type="submit" name="button_clicked" value="View Bids">	    	
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