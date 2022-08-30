<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.*"
    import="Util.*"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
    <link rel="stylesheet" href="template.css">
    <link rel="stylesheet" href="publicSetSearch.css">
    <script src="https://kit.fontawesome.com/3204349982.js"
            crossorigin="anonymous"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<body>
	<%@include file="headbar.jsp" %>
	<%
	int ownerValue = 0;
	if (session.getAttribute("id") != null) {
		ownerValue = (int) session.getAttribute("id");
	}
	%>
	<form id="search-form" action="SearchDispatcher" method="get" autocomplete="on">
	    <input id="search-input" type="text" name="search-input" placeholder="Search a set by name"/>
	    <input type="text" name="owner" value='<%= ownerValue %>' hidden/>
	    <button onclick="submit()" class="icon-button"><i class="fa fa-search"></i></button>
	</form>
	<div style="height:50px"></div>
	<div>
	<% ArrayList<CardSet> cardSets = (ArrayList<CardSet>) request.getAttribute("Results"); 
	String username = (String) request.getAttribute("user"); %>
	<div class="set-block-container">
		<c:forEach var="set" items='<%= cardSets %>'>
				<button class="set-block" onclick="toFlashcard(${set.getID()})">
				<p class="subtitle-font"><b>${set.getName()} </b></p>
				<div class="more-info-set">
				<p class="xsmall-font">Description: ${set.getDescription()}</p>
				<p class="xsmall-font">${set.getCount()} terms</p>
				<p class="xsmall-font">Created by <b>${set.getOwner()} <i class="fa-solid fa-chalkboard-user"></i></b></p>	
				</div>
				</button>
		</c:forEach>
	</div>
	</div>
	<script>
	function check() {
		console.log(document.getElementById("search-input").value + " " + document.getElementById("owner-id").value);		
	}
	
	function submit() {
		$("#search-form").submit();
	}
	
	function toFlashcard(x, y) {
		window.location = "flashcard.jsp?setId=" + x;
	}
	</script>
</body>
</html>