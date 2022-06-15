<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Input Auction</title>
</head>
<link rel="stylesheet" href="../styles.css">
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.time.*" %>
<%@ page import ="java.text.*" %>
<%@ page import ="java.util.*" %>

<%
	String user = request.getParameter("user");
    String item_type = request.getParameter("electronics");   
    String brand = request.getParameter("brand");
    String model = request.getParameter("model");
    String color = request.getParameter("color");
    String reserve = request.getParameter("reserve");
    float reserveVal;
    if(!reserve.trim().isEmpty()) {
        reserveVal = Float.parseFloat(reserve);
    } else {
    	reserveVal = 0;
    }
    
    SimpleDateFormat dtFormat =  new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    //System.out.println(" from ui input "+ request.getParameter("date"));
    java.util.Date reqDate = dtFormat.parse(request.getParameter("date"));
    SimpleDateFormat dateTime = new SimpleDateFormat("yyyy-MM-dd");
    java.sql.Timestamp sqlReqDateTime = new java.sql.Timestamp(reqDate.getTime());
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
   // System.out.println(dtFormat.format(sqlReqDateTime));   
    

    //System.out.println( " date format "+ reqDate + " sql format " + sqlReqDateTime);
    java.util.Date currentDateTime = new java.util.Date();
    
    //java.sql.Date currentDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select count(*) from auction");
    rs.next();
    int count = rs.getInt(1);
    int maxVal = 1;
   	if(count == 0) {
   		maxVal = 1;
   	} else {
   		String sql = "SELECT MAX(auction_id) from auction";
   	    Statement s = con.createStatement();
   		ResultSet r = s.executeQuery(sql);
   		if(r.next()){
   			maxVal = r.getInt(1) + 1;
   		}
 	
   	}
   	
   	//out.println(sqlReqDateTime);
   	//out.println(currentDateTime);
   	
     if(brand.trim().isEmpty() || model.trim().isEmpty() || color.trim().isEmpty()) {
    	out.println("Missing information, ");
    	out.println("<a href='SubmitAuction.jsp'>try again</a>");
    } else if(reqDate.compareTo(currentDateTime) < 0) {
    	out.println("Cannot set auction before current date, ");
    	out.println("<a href='SubmitAuction.jsp'>try again</a>");
    } else {
    	System.out.println(" user = "+ user);
    	//out.println("insert into BuyMe values('" + userid + "', '"  + pwd + "');");
    	String queryStr = "INSERT INTO auction(auction_id, seller, item_type, model, brand, color, reserve, closing_date, max_bid, winner) "
    					   + " VALUES('" + maxVal + "', '" + user + "', '"  + item_type + "', '"  + model + "', '"  + brand + "', '"  + color + "', '"  + reserveVal 
    			           + "', '"  + sqlReqDateTime + "', '" + "0" + "', '"  + "NULL" + "')";
    	PreparedStatement pstatement = con.prepareStatement(queryStr);
    	/* pstatement.setString(userid,pwd); */
    	int i = pstatement.executeUpdate();

    	
    	String str = "SELECT * FROM item_alerts WHERE username <> '" + user + "' AND alert_status = 'inactive';" ;  //all auctions that are not current sellers.
    	Statement stmt = con.createStatement();
    	ResultSet result2 = stmt.executeQuery(str);
    	
    	while(result2.next()) {
    		int alertId = result2.getInt("alert_id");
    		String itemType = result2.getString("item_type");
    		String alertBrand = result2.getString("brand");
    		String alertModel = result2.getString("model");
    		String alertColor = result2.getString("color");
    		
    		if((itemType.equals("") || itemType.equals(item_type)) && (alertBrand.equals("") || alertBrand.equals(brand)) && (alertModel.equals("") || alertModel.equals(model)) && (alertColor.equals("") || (alertColor.equals(color))) )  {
    	    	String query = "UPDATE item_alerts SET alert_status = 'alert' WHERE alert_id = '" + alertId +  "';";
    	    	String query2 = "UPDATE item_alerts SET auction_id = '" + maxVal + "' WHERE alert_id = '" + alertId +  "';";

    	    	PreparedStatement pstatement1 = con.prepareStatement(query);
    	    	PreparedStatement pstatement2 = con.prepareStatement(query2);
    	    	/* pstatement.setString(userid,pwd); */
    	    	int i2 = pstatement1.executeUpdate();
    	    	int i3 = pstatement2.executeUpdate();
    		}
    		
    	}

    	//need to check if any alerts in the thing match the auction added
    	
        response.sendRedirect("UserMainScreen.jsp");
    }
     ApplicationDB.closeConnection(con);

%>
</body>
</html>