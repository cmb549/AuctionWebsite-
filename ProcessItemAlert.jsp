<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Process Item Alert</title>
</head>
<link rel="stylesheet" href="../styles.css">
<body>
<%

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = ApplicationDB.getConnection();
	
	String user = request.getParameter("user");
	String item_type = request.getParameter("electronics");   
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	String color = request.getParameter("color");
	
	if(item_type.equals("empty")) {
		item_type = "";
	}
	
	if(brand.trim().isEmpty()) {
		brand = "";
	}
	
	if(model.trim().isEmpty()) {
		model = "";
	}
	
	if(color.trim().isEmpty()) {
		color = "";
	}
	
	if(item_type.equals("") && brand.equals("") && model.equals("") && color.equals("")) {
		out.println("Missing information, ");
    	out.println("<a href='AddAlertForItem.jsp'>try again</a>");
	} else {
		
		Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select count(*) from item_alerts");
	    rs.next();
	    int count = rs.getInt(1);
	    int maxVal = 1;
	   	if(count == 0) {
	   		maxVal = 1;
	   	} else {
	   		String sql = "SELECT MAX(alert_id) from item_alerts";
	   	    Statement s = con.createStatement();
	   		ResultSet r = s.executeQuery(sql);
	   		if(r.next()){
	   			maxVal = r.getInt(1) + 1;
	   		}
	 	
	   	}
	   	
	   	String queryStr = "INSERT INTO item_alerts(alert_id, username, item_type, brand, model, color, alert_status, auction_id) "
				   + " VALUES('" + maxVal + "', '" + user + "', '"  + item_type + "', '"  + brand + "', '"  + model + "', '"  + color  + "', 'inactive', " + 0 + ");";
		PreparedStatement pstatement = con.prepareStatement(queryStr);
		int i = pstatement.executeUpdate();
		out.println("Alert Added, ");
    	out.println("<a href='UserMainScreen.jsp'>return to user main screen</a>");
	   	
	}
	
	
	ApplicationDB.closeConnection(con);
%>
</body>
</html>