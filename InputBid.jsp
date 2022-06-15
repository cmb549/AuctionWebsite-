<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Input Bid</title>
</head>
<link rel="stylesheet" href="../styles.css">
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.time.*" %>
<%@ page import ="java.text.*" %>
<%@ page import ="java.util.*" %>

<%
	//getting the inputs from the user
	String user = request.getParameter("user"); //user is the userid/ primary key of the users table
	System.out.println("checkbox val : " + request.getParameter("automatic"));

    float bid_amt = Float.parseFloat(request.getParameter("bid_amt"));
	System.out.println("upper limit" + request.getParameter("upper_limit"));
	float limit = 0;
	float increment_val = 0;
	if(!request.getParameter("upper_limit").equals("") && !request.getParameter("increment_val").equals("")){  
		//if user enabled automatic parse these o.w. they will be 0
		 limit = Float.parseFloat(request.getParameter("upper_limit"));
		 increment_val = Float.parseFloat(request.getParameter("increment_val"));
	}
    int auction_id = Integer.parseInt(request.getParameter("auction_id")); //
      //increment-value for this auction item

   /*  String reserve = request.getParameter("reserve");
    float reserveVal;
    if(!reserve.trim().isEmpty()) {
        reserveVal = Float.parseFloat(reserve);
    } else {
    	reserveVal = 0;
    } */
    
    //configuring the bid_id to be used
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select count(*) from bids");
    rs.next();
    int count = rs.getInt(1);
    int maxVal;
   	if(count == 0) {
   		maxVal = 1;
   	} else {
   		String sql = "SELECT MAX(bid_id) from bids";
   	    Statement s = con.createStatement();
   		ResultSet r = s.executeQuery(sql);
   		r.next();
   		maxVal = r.getInt(1) + 1;
   	}
   	
    
   	//Inputting/Storing the bid into database
    //CHECK IF BID AMOUNT IS GREATER THAN THE SELLERS MIN BID OTHERWISE IT IS INVALID ?? - do i need to implement this?
   	String queryStr = "INSERT INTO bids(bid_id, buyer, auction_id, bid_amt, bid_increment, upper_limit) VALUES(" + maxVal + ", '" + user + "', "  + auction_id + ", "  + bid_amt + ", " + increment_val + "," + limit + ")";
   	System.out.println("Insert : "+queryStr);
    PreparedStatement pstatement = con.prepareStatement(queryStr);
   	int i = pstatement.executeUpdate();
       
   
    
    //Automatic Bidding:
 	//While loop to update every buyers bid if the bid placed is higher than other peoples (if upper limit = 0 means they opted out of automatic bidding)
 	//one main auction item and bid increment
 	String AUTO_BID_QRY = "select b.* from bids b where b.bid_id in ( "
 			+ " select max(bid_id) from bids where bids.upper_limit > ? AND " 
 			+ " bids.bid_amt < ? AND auction_id = ? AND bids.buyer <> ? "
 			+ " group by bids.buyer) ";
 	System.out.println("qry :" + AUTO_BID_QRY);
 	PreparedStatement pstmt =  con.prepareStatement(AUTO_BID_QRY);
 	pstmt.setFloat(1,bid_amt);
 	pstmt.setFloat(2,bid_amt);
 	pstmt.setInt(3,auction_id);
 	pstmt.setString(4,user);
 	ResultSet bidRS = pstmt.executeQuery(); //gets the rows from the database of buyers who set up automatic bidding, gets their last recent bid

 	//rs = st.executeQuery("select * from bids where bids.upper_limit <> 0 AND bids.bid_amt < " + bid_amt + " AND auction_id = " + auction_id + " AND bids.buyer <> " + "'" + user + "'" +";");
    while(bidRS.next()){  //iterates through everyone that needs to be automatically bid placed
 		int bidId = bidRS.getInt("bid_id");
 		String currUser = bidRS.getString("buyer");
 		float currAuctionID = bidRS.getFloat("auction_id");
 		float past_bid = bidRS.getFloat("bid_amt");
 		//float currIncrement = Float.parseFloat(rs.getString("increment_val"));
 		float currBidLimit = bidRS.getFloat("upper_limit");
 		float currIncrementVal = bidRS.getFloat("bid_increment");
 		System.out.print(currUser + " " + currIncrementVal + " " + currBidLimit);
 		if(past_bid + currIncrementVal < currBidLimit){
 			//the bid can be incremented without going over the limit so insert
 			maxVal += 1; //new row
	 		String insertNewBid = "INSERT INTO bids(bid_id, buyer, auction_id, bid_amt, bid_increment, upper_limit) VALUES(" + maxVal + ", '" + currUser + "', "  + currAuctionID + ", "  + (past_bid + currIncrementVal) + ", " + currIncrementVal + "," + currBidLimit + ")";
 	   	    Statement s2 = con.createStatement();
 	   		s2.executeUpdate(insertNewBid);
    		out.println("Success,");
 		}
 	}
    bidRS.close(); // Closing result after use
 	
 	//update the current auction item's max bid  -- Note this is done after the automatic bidding
 	ResultSet rsMaxBid = st.executeQuery("select MAX(bid_amt) as maxBid FROM bids WHERE auction_id = " + auction_id);
 	rsMaxBid.next();
 	float max_bid =rsMaxBid.getFloat("maxBid");
 	st.executeUpdate("UPDATE auction SET max_bid = " + max_bid + " where auction_id = " + auction_id);
 	
 	//alert users if higher bid
 	
 	
 	response.sendRedirect("UserMainScreen.jsp");
    ApplicationDB.closeConnection(con);

%>
</body>
</html>