<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="java.util.ArrayList"
	import="Util.*"    
	import="com.google.gson.Gson"
%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="cardBlock.css">
</head>
<body>
	<div class="card-block-container">
		<div class="card-block-text">
			<p class="card-block-phrase"> <c:out value="${param.term}"/> </p>
			<p class="card-block-definition"> <c:out value="${param.definition}"/> </p>
		</div>
	</div>
</body>
</html>