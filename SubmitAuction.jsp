<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../styles.css">
<meta charset="UTF-8">
<title>Submit Auction</title>
</head>
<body>
<form action="InputAuction.jsp" method="POST">
       Item Type: <select name="electronics" id="elec">
        <option value="headphones">Headphones</option>
        <option value="tv">Television</option>
        <option value="phone">Phone</option>
      </select> <br/> <br/>
       Brand:<input type = "text" name = "brand"/> <br/> <br/>
       Model:<input type="text" name="model"/> <br/> <br/>
       Color:<input type="text" name = "color"/> <br/> <br/>
       Closing Date:<input type="datetime-local" value="2022-01-01T00:00:00" name = "date"/> <br/> <br/>
       Reserve Value:<input type="text" name = "reserve"/> <br/> <br/>
	  <input type="hidden" name=user value="<%=session.getAttribute("user")%>">
       <input type="submit" value="Submit"/>
     </form>
     <button onclick = "location.href = 'UserMainScreen.jsp'">Return to User Main Screen</button>
</body>
</html>