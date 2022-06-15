<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.*" %>
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mark As Read</title>
</head>
<body>

<%
	Connection con = ApplicationDB.getConnection();
	String alertId = request.getParameter("alert_id");
	try {
		
		Statement stmt = con.createStatement();
    	String query = "UPDATE item_alerts SET alert_status = 'read' WHERE alert_id = '" + alertId +  "';";
    	PreparedStatement pstatement1 = con.prepareStatement(query);
    	int i2 = pstatement1.executeUpdate();
    	response.sendRedirect("ViewItemAlerts.jsp");
	} catch(Exception e) {
		out.print("oops");
	} finally {
		ApplicationDB.closeConnection(con);
	}
%>

</body>
</html>