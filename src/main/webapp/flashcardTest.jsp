<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@include file="headbar.jsp" %>
	<% String setId = (String) request.getParameter("setId"); 
	System.out.println(setId);%>
	<div class="displayer-container">
		<jsp:include page="flashcardTestDisplayer.jsp">
			<jsp:param name="sender" value="flashcardTest.jsp"/>
			<jsp:param name="set" value='<%= setId %>'/>
		</jsp:include>
	</div>
</body>
</html>