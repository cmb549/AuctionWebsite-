<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>  
        <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Auction Details</title>
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
		
	}
	out.print("</table >");
	%> <br> <% 
	int aucId = Integer.parseInt(auctionId);
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
		out.print("<tr>");
		out.print("<td>");
		out.print(question);
		out.print("</td>");
		out.print("<td>");
		if(answer.equals("NULL")) {
			%>
	    	<form action="InputForumAnswer.jsp">
	    		Answer: <input type="text" name="answer"> <br>
	    		<input type="hidden" name=auction_id value="<%=auctionId%>">
	    		<input type="hidden" name=question value="<%=question%>">
		    	<input type="submit" name="button_clicked" value="Answer Question">	    	
	    	</form>
			<%
			out.print("</td>");
		} else {
			out.print(answer);
			out.print("</td>");
		}
		
		out.print("</tr>");
	}
	out.print("</table >");
} catch(Exception e){
}finally{
    ApplicationDB.closeConnection(con);

}
%>
<br>
<button onclick = "location.href = 'ViewAuctions.jsp'">Return to Auction List</button></body>
<%
%>
</body>
</html>