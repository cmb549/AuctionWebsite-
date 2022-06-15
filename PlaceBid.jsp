<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.io.*,java.util.*,java.sql.*"%>  
        <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Place Bid</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style>
	.tab {
            tab-size: 4;
        }
</style>
</head>
<body>
<%
Connection con = null;
try {
	
	con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
	Statement stmt = con.createStatement();
	String auctionId = request.getParameter("auction_id");
	//float incrementVal = Float.parseFloat(request.getParameter("increment_val"));

	//display the auction item you are placing a bid on 
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
} catch(Exception e){
}finally{
    ApplicationDB.closeConnection(con);

}
%> <button onclick = "location.href = 'BrowseAuctions.jsp'">Return to Auction List</button> <br/> <br/>

	<form action="InputBid.jsp" method="POST">
       Bid Amount:<input type = "text" name = "bid_amt"/> <br/> <br/>
       <input type = "checkbox" name = "automatic" id = "aut_bid" />Automatic Bidding? <br/> <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Secret Upper Limit:<input type="text" name="upper_limit" id = "toggleInput" style="display:none" class = "tab"/> <br/> <br/>
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Increment Value:<input type="text" name = "increment_val" id = "toggleInput2" style="display:none" class = "tab"/> <br/> <br/>
	  
	  <input type="hidden" name=user value="<%=session.getAttribute("user")%>">
	  <input type="hidden" name=auction_id value="<%=request.getParameter("auction_id")%>">
<%-- 	  <input type="hidden" name=increment_val value="<%=request.getParameter("increment_val")%>">
 --%>	  
	  
      <input type="submit" value="Submit"/>
     </form>
 <h3>Bidding on : </h3>
 
 <script>
$('#aut_bid').on('change', function(){
    if ( $(this).is(':checked') ) {
       $('#toggleInput').show();
       $('#toggleInput2').show();
   } else {
       $('#toggleInput').hide();
       $('#toggleInput2').hide();
   }
});
</script>
 
</body>
</html>
