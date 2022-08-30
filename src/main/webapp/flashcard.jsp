<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="java.util.ArrayList"
    import="java.util.Random"
    import="java.util.*"
    import="Util.CardParser"
    import="Util.Card"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="flashcard.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;600;700&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/6da084a802.js" crossorigin="anonymous"></script>
</head>
<body>
	<div>
	<%@include file="headbar.jsp" %>
	</div>
	<% String setId = (String) request.getParameter("setId"); 
	System.out.println(setId);%>
	<div class="displayer-container">
		<jsp:include page="flashcardDisplayer.jsp">
			<jsp:param name="sender" value="flashcard.jsp"/>
			<jsp:param name="set" value='<%= setId %>'/>
		</jsp:include>
	</div>
</body>
</html>