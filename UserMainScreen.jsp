<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
  <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>User Home Page</title>
</head>
<body>
<h1>Welcome, <%=session.getAttribute("user")%></h1>
<%
Connection con = ApplicationDB.getConnection();
int count = 0;
try {
     //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select count(*) from item_alerts where username = '" + session.getAttribute("user") + "' AND alert_status = 'alert';");
    rs.next();
    count = rs.getInt(1);
} catch (Exception e){
	System.out.println("error in userMainScreen " + e.getMessage());
	
}
	

	//check for closed auctions and declare winner/input the winner into the database
	//DECLARING WINNER
	
	Statement winnerStmt = con.createStatement();
	ResultSet winRS = winnerStmt.executeQuery("SELECT * from auction where closing_date < NOW()");  //returns all the closed auctions
	while (winRS.next()){
		float currReserve = winRS.getFloat("reserve");
		float currMaxBid = winRS.getFloat("max_bid");
		float currAuctionId = winRS.getFloat("auction_id");
		String currWinner = "";
		//if the reserve is higher than the last bid none is the winner.
		//if no: whoever has the higher bid is the winner

		if(currReserve > 0 && currMaxBid < currReserve) { //no winner
			currWinner = "None";
    	}else{
    		Statement wStmt = con.createStatement();
    		ResultSet wRS = wStmt.executeQuery("select buyer from bids where auction_id = " + currAuctionId + " and bid_amt = " + currMaxBid + ";");
    		

    		while(wRS.next()){   //update the winner variable with the maxbid buyer from prev line
    			currWinner = wRS.getString("buyer");
    		}
    				
    	}
		//update the auction table with the winner
		Statement stmt2 = con.createStatement();
		stmt2.executeUpdate("UPDATE auction SET auction.winner = '" + currWinner + "' where auction_id = " + currAuctionId);
	}
			
        
  
	


	//check for higher bid and alert if someone bids higher than current buyer (manual) 
	String currUser = session.getAttribute("user")!=null ? session.getAttribute("user").toString(): "";

	String MAX_BID_ITEM_ALERT_QRY = "SELECT t1.auction_id, t1.item, t1.buyer"
			+" FROM"
			+" (SELECT b.buyer, k.max_bid_amt, k.auction_id, "
			+" (SELECT item_type from auction where auction_id = k.auction_id) as item"
			+" from bids b ,"
			+" (SELECT auction_id, max(bid_amt) as max_bid_amt from bids "
			+" group by auction_id) k"
			+" where b.bid_amt = k.max_bid_amt) t1"
			+" INNER JOIN  (SELECT distinct buyer, auction_id FROM BuyMe.bids where upper_limit= 0 and buyer = '" + currUser + "') t2"
			+" ON t1.auction_id = t2.auction_id" ;
	System.out.println(MAX_BID_ITEM_ALERT_QRY);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(MAX_BID_ITEM_ALERT_QRY);
	String alertMsg = "<font color = 'red'> A higher bid has been placed for : ";
	int acount = 0;
	while(rs.next()){
		if(!currUser.equals(rs.getString("buyer"))){
			System.out.println(rs.getInt("auction_id"));
			acount++;
			alertMsg += "<br/>" + rs.getString("item") + " with auction id: " + rs.getString("auction_id") + "<br/>"; 
		}/* else{
			alertMsg = "";
		} */
	}
	alertMsg += "</font>";
	System.out.println("acount = " + acount);
	if(acount > 0) out.println(alertMsg);
	
	//check for higher upper limit
		String UPPER_BID_ITEM_ALERT_QRY = "SELECT t1.auction_id, t1.item, t1.buyer, t1.max_bid_amt, t2.upper_limit"
				+" FROM"
				+" (SELECT b.buyer, k.max_bid_amt, k.auction_id, "
				+" (SELECT item_type from auction where auction_id = k.auction_id) as item"
				+" from bids b ,"
				+" (SELECT auction_id, max(bid_amt) as max_bid_amt from bids "
				+" group by auction_id) k"
				+" where b.bid_amt = k.max_bid_amt) t1"
				+" INNER JOIN  (SELECT distinct buyer, auction_id, upper_limit FROM BuyMe.bids where upper_limit<>0 and buyer = '" + currUser + "') t2"
				+" ON t1.auction_id = t2.auction_id "
				+" where t1.max_bid_amt > t2.upper_limit";
		Statement stmt1 = con.createStatement();
		ResultSet rs1 = stmt1.executeQuery(UPPER_BID_ITEM_ALERT_QRY);
		String alertMsg1 = "<font color = 'red'> A bid higher than your upper limit has been placed for : ";
		int acount1 = 0;
		while(rs1.next()){
			if(!currUser.equals(rs1.getString("buyer"))){
				System.out.println(rs1.getInt("auction_id"));
				acount1++;
				alertMsg1 += "<br/>" + rs1.getString("item") + " with auction id: " + rs1.getString("auction_id") + "<br/>"; 
			}/* else{
				alertMsg = "";
			} */
		}
		alertMsg1 += "</font>";
		if(acount1 > 0) out.println(alertMsg1);
		
		//alert about winning auctions
		String WINNER_ALERT_QRY = "SELECT count(*) count" 
				+" FROM auction"
				+" WHERE auction.winner = '"+currUser+ "'" ;
		Statement stmt2 = con.createStatement();
		ResultSet rs2 = stmt2.executeQuery(WINNER_ALERT_QRY);
		//String alertMsg2 = "<font color = 'red'> A bid higher than your upper limit has been placed for : ";
		rs2.next();
		if(rs2.getInt("count") > 0){
			out.println("<strong>Congrats you have won! Please click 'View Won Auctions' to see which ones you have won!</strong> <br/>");
		}

	
%>

</br>
<button onclick = "location.href = 'SubmitAuction.jsp'">Auction Item</button> <br>
<button onclick = "location.href = 'BrowseAuctions.jsp'">Browse Auctions</button>
<button onclick = "location.href = 'ViewAuctions.jsp'">View My Auctions</button> 
<button onclick = "location.href = 'WonAuctions.jsp'">View Won Auctions</button> <br>
<button onclick = "location.href = 'Questions.jsp'">Questions</button> 
<button onclick = "location.href = 'PendingQuestions.jsp'">Pending Questions</button>
<button onclick = "location.href = 'AnsweredQuestions.jsp'">Answered Questions</button> <br>
<button onclick = "location.href = 'ViewItemAlerts.jsp'">New Item Alerts (<%out.print(count);%>)</button> 
<button onclick = "location.href = 'AddAlertForItem.jsp'">Add Alert For Item</button> <br>
<button onclick = "location.href = '../logout.jsp'">Log Out</button> <br>
</body>
</html>