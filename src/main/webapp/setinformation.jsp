<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%-- use jstl tags --%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Flash Card</title>
	<link rel="stylesheet" href="setinformation.css">
</head>
<body>
	<%@include file="headbar.jsp" %>  
	<% String setId = (String) request.getParameter("setId"); 
	System.out.println(setId);%>
	<div class="set-information-container">
		<section class="set-information-displayer">
			<jsp:include page="flashcardDisplayer.jsp">
				<jsp:param name="sender" value="setinformation.jsp"/>
				<jsp:param name="set" value='<%= setId %>'/>
			</jsp:include>
		</section>
		<div style="margin-bottom: 10px;">
		</div>
		<section class="set-information-list">
		<%-- passing info into card components: https://stackoverflow.com/questions/19150683/passing-parameters-to-another-jsp-file-using-jspinclude-tag --%>
			<c:forEach var = "card" items = "${cardData}">
				<form>
					<jsp:include page="cardBlock.jsp">
						<jsp:param name="term" value="${card.getTerm()}"/>
						<jsp:param name="definition" value="${card.getDef()}"/>
					</jsp:include>
				</form>
			</c:forEach>
		</section>
	</div>
</body>
</html>