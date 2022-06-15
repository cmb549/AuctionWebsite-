<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>  
        <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Browse Items</title>
</head>
<body>
<h1>Sort Results</h1>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection();
	Statement stmt = con.createStatement();
	String itemType = request.getParameter("electronics");
	String sortingByPrice = request.getParameter("price");
	String max_bidding = request.getParameter("max_price");
	float maxBidding = 0;
	String user = request.getParameter("user");
	
	if(itemType.equals("empty") && sortingByPrice.equals("empty") && (max_bidding == null || max_bidding.trim().isEmpty())) {
		response.sendRedirect("BrowseAuctions.jsp");
	}
	
	if(!max_bidding.trim().equals("")) {
		try {
			maxBidding = Float.parseFloat(max_bidding);
		} catch (NumberFormatException e){
			response.sendRedirect("BrowseAuctions.jsp");
		}
	}
	
	String sqlItemStatement = "select * from auction where seller <> '" + user + "' and auction_id in";
	String sqlMaxPriceStatement = "(select auction_id from auction)";
	String sqlSorting = ";";
	        		
	//items:
		if(!itemType.equals("empty")) {
			sqlItemStatement = "select * from auction where seller <> '" + user + "' and item_type = '" + itemType + "' and auction_id in ";
		}
	
		if(maxBidding > 0) {
			sqlMaxPriceStatement = "(select auction_id from auction where max_bid < maxBidding)";
		}
		
		if(!sortingByPrice.equals("empty")) {
			if(sortingByPrice.equals("Low to High")) {
				sqlSorting = " order by max_bid asc;";
			} else {
				sqlSorting = " order by max_bid desc;";
			}
		}
		
	String str = sqlItemStatement + sqlMaxPriceStatement + sqlSorting;
	ResultSet result = stmt.executeQuery(str);
	
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
	while(result.next()) {
		String seller = result.getString("seller");
		String item = result.getString("item_type");
		String model = result.getString("model");
		String brand = result.getString("brand");
		String color = result.getString("color");
		java.sql.Date dateObj = result.getDate("closing_date");
		String date = dateObj.toString();
		String maxBid = result.getString("max_bid");
	
		out.print("<tr>");
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
		out.print(maxBid);
		out.print("</td>");
		out.print("<td>");
		int auctionId = result.getInt("auction_id");
		float incrementVal = result.getFloat("increment_val");
		%>
		
		
    	<form action="ViewForum.jsp">
    		<input type="hidden" name=auction_id value="<%=auctionId%>">
	    	<input type="submit" name="button_clicked" value="View Item Details">	    	
    	</form>
	<%
		out.print("</td>");
		out.print("<td>");
		%>
    	<form action="PlaceBid.jsp">
    		<input type="hidden" name=auction_id value="<%=auctionId%>">
    		<input type="hidden" name=increment_val value="<%=incrementVal%>">
	    	<input type="submit" name="button_clicked" value="Place Bid">	    	
    	</form>
	<%
		out.print("</td>");
		out.print("<td>");
			%> <form action = "ListOfParticipatedAuctions.jsp" id = "participated" method = "GET">
			<input type="submit" name="view" value = "View Other Auctions Bidder Has Participated In">
			<input type="hidden" name=user value="<%=seller%>">
		</form><%
		out.print("</td>");
		out.print("</tr>");
	}
	
	
} catch(Exception e) {
	System.out.println(" Exception occured in Sort Items "+e.getMessage());
} finally {
	ApplicationDB.closeConnection(con);
}
%>
<button onclick = "location.href = 'BrowseAuctions.jsp'">Return to Auction List</button></body>
</body>
</html>