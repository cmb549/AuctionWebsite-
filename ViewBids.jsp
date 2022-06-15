<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Bids</title>
</head>
<link rel="stylesheet" href="../styles.css">
<body>
<h1>Bids</h1>
<%
Connection con = null;
try {

	//Get the database connection
    con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	String auctionId = request.getParameter("auction_id");
	int aucId = Integer.parseInt(auctionId);
	//Get the combobox from the index.jsp
	String str = "SELECT * FROM bids where auction_id = " + aucId + ";";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	
	//Make an HTML table to show the results in:
	out.print("<table >");
	//make a row
	out.print("<tr>");
	//make a column
	out.print("<th>");
	//print out column header
	out.print("Buyer");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Bid Amount");
	out.print("</th>");
	//make a column
	out.print("</tr>");
	while (result.next()) {
		//make a row
		String buyer = result.getString("buyer");
		float bidAmount = result.getFloat("bid_amt");
		out.print("<tr>");
		//make a column
		out.print("<td>");
		out.print(buyer);
		out.print("</td>");
		out.print("<td>");
		out.print(bidAmount);
		out.print("</td>");
		out.print("<td>");
		int bidId = result.getInt("bid_id");
		%>
    	<form action="DeleteBid.jsp">
    		<input type="hidden" name=bid_id value="<%=bidId%>">
	    	<input type="submit" name="button_clicked" value="Delete Bid">	    	
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