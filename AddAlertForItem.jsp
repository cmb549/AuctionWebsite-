<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Add Alert For Item</title>
</head>
<body>
<h1>Add Alert</h1>
<% out.print("Do not need to fill in all specifics");%>
<form action="ProcessItemAlert.jsp" method="POST">
       Item Type: <select name="electronics" id="elec">
        <option value="empty"></option>
        <option value="headphones">Headphones</option>
        <option value="tv">Television</option>
        <option value="phone">Phone</option>
      </select>  <br>
      Brand: <input type = "text" name = brand> <br>
      Model: <input type = "text" name = model> <br>
      Color: <input type = "text" name = color> <br>
	  <input type="hidden" name=user value="<%=session.getAttribute("user")%>">
       <input type="submit" value="Submit"/>
     </form>
</body>
</html>