<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>  
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Browse Auctions</title>
</head>
<h1>Browse Auctions</h1>
<body>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String username = String.valueOf(session.getAttribute("user"));
	
	String str2 = "SELECT * FROM auction WHERE seller <> '" + username + "' AND winner = 'NULL' AND closing_date > NOW() " ;  //all auctions that are not current sellers.
	ResultSet result2 = stmt.executeQuery(str2);
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
	out.print("Reserve");
	out.print("</th>");
	out.print("<th>");
	out.print("Current Max Bid");
	out.print("</th>");
	out.print("</tr>");
	while(result2.next()) {
		String seller = result2.getString("seller");
		String item = result2.getString("item_type");
		String model = result2.getString("model");
		String brand = result2.getString("brand");
		String color = result2.getString("color");
		String reserve = result2.getString("reserve");
		java.sql.Date dateObj = result2.getDate("closing_date");
		String date = dateObj.toString();
		String maxBid = result2.getString("max_bid");

		
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
		out.print(reserve);
		out.print("</td>");
		out.print("<td>");
		out.print(maxBid);
		out.print("</td>");
		out.print("<td>");
		int auctionId = result2.getInt("auction_id");
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
	    	<input type="submit" name="button_clicked" value="Place Bid">	    	
    	</form>
	<%
		out.print("</td>");
		out.print("<td>");
			%> <form action = "ListOfParticipatedAuctions.jsp" id = "participated" method = "GET">
			View Other Auctions Bidder Has Participated In : <input type="submit" name="view"> <br>
			<input type="hidden" name=user value="<%=seller%>">
		</form><%
		out.print("</td>");
		out.print("</tr>");
	}
} catch(Exception e){
	System.out.println("exception occurred in BrowseAuctions" + e.getMessage());
}finally{
	ApplicationDB.closeConnection(con);
}
%> <button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Page</button></body>
<%
%>
</body>
</html>