<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
    <%@ page import ="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Reports</title>
   	<link rel="stylesheet" href="../styles.css">
</head>
<body>
    <%   String reportType = request.getParameter("type"); %>	
     
    	<div class="content">
	    <%	
	    	
			
			Locale locale = new Locale("en", "US");
			NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
			
 
				Class.forName("com.mysql.jdbc.Driver");
		   		Connection con = ApplicationDB.getConnection(); //DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "root");
		    	Statement st = con.createStatement();
		    	PreparedStatement ps = null;
		    	ResultSet rs = null;
				
				String query = null;
		    	if (reportType.equals("totalEarnings")) {
		    		query = "SELECT SUM(max_bid) FROM auction WHERE winner <> 'NULL' AND winner <> 'NONE' " ;
		    		ps = con.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Total Earnings</th>
		    				</tr>	
		    		<%	do { %>
		    				<tr>
		    					<td><%= currency.format(rs.getDouble("SUM(max_bid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    			</table>
		    			<br><a href="SalesReport.jsp">CLICK TO GENERATE MORE SALES REPORTS.</a>
		    	<%	}		    		
		    	} else if (reportType.equals("earningsPerItem")) {
		    		query = "SELECT model, SUM(max_bid) FROM auction WHERE winner <> 'NULL' AND winner <> 'NONE' GROUP BY model";
		    		ps = con.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Model</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("model") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(max_bid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="SalesReport.jsp">CLICK TO GENERATE MORE SALES REPORTS.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerItemType")) {
		    		query = "SELECT item_type, SUM(max_bid) FROM auction WHERE winner <> 'NULL' AND winner <> 'NONE' GROUP BY item_type";
		    		ps = con.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Category</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("item_type") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(max_bid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="SalesReport.jsp">CLICK TO GENERATE MORE SALES REPORTS.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerEndUser")) {
		    		query = "SELECT seller, SUM(max_bid) FROM auction WHERE winner <> 'NULL' AND winner <> 'NONE' GROUP BY seller";
		    		ps = con.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>User</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("seller") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(max_bid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="SalesReport.jsp">CLICK TO GENERATE MORE SALES REPORTS.</a>
		    	<%	}
		    	} else if (reportType.equals("bestSelling")) {
		    		query = "SELECT model, COUNT(model), SUM(max_bid) FROM auction WHERE winner <> 'NULL' AND winner <> 'NONE' GROUP BY model ORDER BY COUNT(model) DESC";
		    		ps = con.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Model</th>
		    					<th>Number Sold</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("model") %></td>
		    					<td><%= rs.getInt("COUNT(model)") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(max_bid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="SalesReport.jsp">CLICK TO GENERATE MORE SALES REPORTS.</a>
		    	<%	}
		    	} else if (reportType.equals("bestBuyers")) {
		    		 query = "SELECT winner, COUNT(winner), SUM(max_bid) FROM auction WHERE winner <> 'NULL' AND winner <> 'NONE' GROUP BY winner ORDER BY COUNT(winner) DESC";
		    		ps = con.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) {  %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Buyer</th>
		    					<th>Number of purchases</th>
		    					<th>Total amount spent</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("winner") %></td>
		    					<td><%= rs.getInt("COUNT(winner)") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(max_bid)")) %></td>
		    				</tr>
		    		<%	} while (rs.next());  %>
		    		</table> 
		    		<br><a href="SalesReport.jsp">CLICK TO GENERATE MORE SALES REPORTS.</a>
		    	<% } 
		    	 
			 
			}  
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
		        try { con.close(); } catch (Exception e) {}
			 
	    %>	
    	</div>
     
</body>
</html>