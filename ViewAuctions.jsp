<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>My Auctions</title>
</head>
<body>
<h1>My Auctions</h1>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection();//DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String username = String.valueOf(session.getAttribute("user"));
	String str2 = "SELECT * FROM auction WHERE seller = '" + username + "'";
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
		String winner;
		
		/*
		//DECLARING WINNER
		
		//converting to JAVA date
		java.util.Date currDate = new java.util.Date();
        java.util.Date closeDate = new java.util.Date(dateObj.getTime());
        
        //out.println(currDate);
        //out.println(closeDate);
        
        //check if auction is past date
        
        int num = currDate.compareTo(closeDate);
        if (num > 0){ //currDate > closeDate
        	//determine the winner
        	if(reserve != "0" && Float.parseFloat(maxBid) < Float.parseFloat(reserve)) { //no winner
        		winner = "None";
        	}else{
        		Statement stmt1 = con.createStatement();
        		ResultSet r = stmt1.executeQuery("select buyer as winner from bids where auction_id = " + auction_id + " and bid_amt = " + maxBid + ";");
        		

        		while(r.next()){
        			Statement stmt2 = con.createStatement();
        			winner = r.getString("winner");
        			
        			stmt2.executeUpdate("UPDATE auction SET auction.winner = '" + winner + "' where auction_id = " + auction_id);
        		}
        	}
        	
        }*/

 		winner = result2.getString("winner");
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

		out.print("<td>");
		int auctionId = result2.getInt("auction_id");
		//float incrementVal = result2.getFloat("increment_val");
		%>
		
		
    	<form action="ViewItem.jsp">
    		<input type="hidden" name=auction_id value="<%=auctionId%>">
	    	<input type="submit" name="button_clicked" value="View Auction Details">	    	
    	</form>
	<%
		out.print("</td>");
		out.print("</tr>");
			
		
	}
	out.print("</table >");
} catch(Exception e){
	System.out.println(" Exception occured in view my auctions " + e.getMessage());
}finally{
    ApplicationDB.closeConnection(con);

}
%> <button onclick = "location.href = 'UserMainScreen.jsp'">Return to Main Page</button></body>
<%
%>
</body>
</html>