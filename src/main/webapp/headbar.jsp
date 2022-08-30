<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="headbar.css">
	<script src="https://kit.fontawesome.com/6da084a802.js" crossorigin="anonymous"></script>
<title>Flash Card</title>
<style>
/* The side navigation menu */
.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #FD9751;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
  text-align: center;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: inherit;
  color: white;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #FFECDD;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
</head>
<body>
	<%
	boolean isRegistered = false;
	String name = (String) session.getAttribute("username");
	System.out.println("Name on headbar: " + name);
	if (name != null) {
		isRegistered = true;
	}
	%>
	<script>
		/* Open the sidenav */
		function openNav() {
		  document.getElementById("mySidenav").style.width = "100%";
		}
	
		/* Close/hide the sidenav */
		function closeNav() {
		  document.getElementById("mySidenav").style.width = "0";
		} 
	</script>
	<div id="mySidenav" class="sidenav">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	  <a href="./index.jsp">Home</a>
	  <a href="./publicSetSearch.jsp">Explore</a>
	  <a href="./NewSet.jsp">Create</a>
	  <% if (isRegistered) { %>
	  	<form id="header-logout" action="LogoutDispatcher" method="GET"> 
    		<a href=# onClick="document.getElementById('header-logout').submit()"> Logout </a>
    	</form>
	  <% } %>
	</div>
	<div class="headbar-container reset-this">
		<a href="index.jsp"><h1 class="headbar-container-title">Trojan Flash</h1></a>
		<div class="headbar-container-more">
			<% if (!isRegistered) { %>
			<a href="./auth.jsp"><p class="headbar-container-more-auth">Sign up / Log in</p></a>
			<%} else {%>
			<p class="headbar-container-more-auth">Hi <%= name %>!</p>
			<%} %>
			<i class="fa-solid fa-bars" onclick="openNav()"></i>
		</div>
	</div>
</body>
</html>