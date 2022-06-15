<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>  
        <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Similar Items</title>
</head>
<body>
<h1>Similar Items</h1>
<%
 Connection con = null;
try {
	con = ApplicationDB.getConnection();
	Statement stmt = con.createStatement();
	String auctionId = request.getParameter("auction_id");
	String str = "SELECT * FROM auction WHERE auction_id = '" + auctionId + "'";
	ResultSet result = stmt.executeQuery(str);
	String item = "";
	String brand = "";
	String model = "";
	while(result.next()) {
		item = result.getString("item_type");
		brand = result.getString("brand");
		model = result.getString("model");
	}
    java.util.Date monthPrior = new java.util.Date().from(LocalDate.now().minusMonths(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
    java.util.Date currDate = new java.util.Date();
    //get all auction items after the month prior date
    Statement stmt1 = con.createStatement();
    String str1 = "SELECT * FROM auction WHERE auction_id <> '" + auctionId + "' AND item_type = '" + item + "' AND brand = '" + brand + "' AND model = '" + model + "';";
	ResultSet result1 = stmt1.executeQuery(str1);
	
	//go through each result
	//check if the date is greater than the monthprior
	//if so --> print out the information
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("Seller");
	out.print("</th>");
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
	out.print("Current Max Bid");
	out.print("</th>");
	out.print("</tr>");
	
	while(result1.next()) {
		java.sql.Timestamp dateObj = result1.getTimestamp("closing_date");
		String date = dateObj.toString();
		java.util.Date closeDate = new java.util.Date(dateObj.getTime());
		//closing date should be greater than month prior but less than current date
		if((closeDate.compareTo(monthPrior) >= 0) && (closeDate.compareTo(currDate) <= 0)) {
			String seller = result1.getString("seller");
			String item1 = result1.getString("item_type");
			String model1 = result1.getString("model");
			String brand1 = result1.getString("brand");
			String color = result1.getString("color");
			String maxBid = result1.getString("max_bid");
		
			out.print("<tr>");
			out.print("<td>");
			out.print(seller);
			out.print("</td>");
			out.print("<td>");
			out.print(item1);
			out.print("</td>");
			out.print("<td>");
			out.print(brand1);
			out.print("</td>");
			out.print("<td>");
			out.print(model1);
			out.print("</td>");
			out.print("<td>");
			out.print(color);
			out.print("</td>");
			out.print("<td>");
			out.print(date);
			out.print("</td>");
			out.print("<td>");
			out.print(maxBid);
			out.print("</td>");
			out.print("</tr>");
		}
		
	}
	out.print("</table >");
    
} catch(Exception e) {
	System.out.println("Exception occured in View Similar Items "+e.getMessage());
} finally {
	ApplicationDB.closeConnection(con);
}
%>
<button onclick = "location.href = 'BrowseAuctions.jsp'">Return to Auction List</button></body>
</body>
</html>