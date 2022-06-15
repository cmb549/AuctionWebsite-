<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.io.*,java.util.*,java.sql.*"%>  
        <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Item Details</title>
</head>
<body>
<h3>Item Details:</h3>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String auctionId = request.getParameter("auction_id");
	String str2 = "SELECT * FROM auction WHERE auction_id = '" + auctionId + "'";
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
		out.print("</tr>");
		
		   out.print("</table >");
		    %> <br> <% 
	}
	
	//bids table
	out.print("</table >");
	%> <br> <% 
	int aucId = Integer.parseInt(auctionId);
	String str1 = "SELECT * FROM bids where auction_id = " + aucId + ";";
	Statement stmt1 = con.createStatement();
	ResultSet result1 = stmt1.executeQuery(str1);
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("Bidder");
	out.print("</th>");
	out.print("<th>");
	out.print("Bid Value");
	out.print("</th>");
	out.print("</tr>");
	
	while(result1.next()) {
		String bidder = result1.getString("buyer");
		String bidVal = result1.getString("bid_amt");
		out.print("<tr>");
		out.print("<td>");
		out.print(bidder);
		out.print("</td>");
		out.print("<td>");
		out.print(bidVal);
		out.print("</td>");
		out.print("<td>");
		%> <form action = "ListOfParticipatedAuctions.jsp" id = "participated" method = "GET">
			<input type="submit" name="view" value = "View Other Auctions Bidder Has Participated In"> <br>
			<input type="hidden" name=user value="<%=bidder%>">
		</form><%
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table >");
	
	//question table
	out.print("</table >");
	%> <br> <% 
	String str = "SELECT * FROM item_questions where auction_id = " + aucId + ";";
	ResultSet result = stmt.executeQuery(str);
	out.print("<table >");
	out.print("<tr>");
	out.print("<th>");
	out.print("Question");
	out.print("</th>");
	out.print("<th>");
	out.print("Answer");
	out.print("</th>");
	out.print("</tr>");
	
	while(result.next()) {
		String question = result.getString("question");
		String answer = result.getString("answer");
		if(answer.equals("NULL")) {
			answer = "Not Answered";
		}
		out.print("<tr>");
		out.print("<td>");
		out.print(question);
		out.print("</td>");
		out.print("<td>");
		out.print(answer);
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table >");

	%>
	<br>
	<form action = "ViewSimilarItems.jsp" id = "viewsim" method = "GET">
	<input type="submit" name="view" value = "View Similar Items in Past Month"> <br>
	<input type="hidden" name=auction_id value="<%=auctionId%>">
	</form>
	<%
} catch(Exception e){
	System.out.println(" Exception occured in View Forum "+e.getMessage());
}finally{
    ApplicationDB.closeConnection(con);

}
%>
<br>
<form action = "SubmitItemQuestion.jsp" id = "questionform" method = "POST">
	Ask Questions About Item: <input type="text" name="question"> <br>
	<input type="hidden" name=user value="<%=session.getAttribute("user")%>">
	<input type="hidden" name=auction_id value=<%=request.getParameter("auction_id")%>>
	<input type = "submit">
</form>
<form action = "SearchQuestions.jsp" id = "questionform" method = "POST">
	Search Questions and Answers: <input type="text" name="search"> <br>
	<input type="hidden" name=auction_id value=<%=request.getParameter("auction_id")%>>
	<input type = "submit">
</form>
<button onclick = "location.href = 'BrowseAuctions.jsp'">Return to Auction List</button></body>
<%
%>
</body>
</html>