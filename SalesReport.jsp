<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Generate Sales Report</title>
</head>
<body>

    	 
    	<div class="content">
	    	<h2>Select a sales report to generate</h2>
	    	<ul>
	            <li><a href="SalesReportHandler.jsp?type=totalEarnings">Total Earnings</a></li>
	            <li><a href="SalesReportHandler.jsp?type=earningsPerItem">Earnings per item</a></li>
	            <li><a href="SalesReportHandler.jsp?type=earningsPerItemType">Earnings per item type</a></li>
	            <li><a href="SalesReportHandler.jsp?type=earningsPerEndUser">Earnings per end-user</a></li>
	            <li><a href="SalesReportHandler.jsp?type=bestSelling">Best-selling items</a></li>
	            <li><a href="SalesReportHandler.jsp?type=bestBuyers">Best buyers</a></li>	            
	    	</ul>
    	</div>
     



     <button onclick = "location.href = 'AdminMainPage.jsp'">Return to Main Admin Screen</button>
</body>
</html>