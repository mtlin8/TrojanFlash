<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="javax.servlet.jsp.*"
    import="java.util.ArrayList"
    import="java.util.Random"
    import="java.util.*"
    import="Util.CardParser"
    import="Util.Card"
    import="com.google.gson.Gson"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="template.css" rel="stylesheet">
<link href="flashcardDisplayer.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;600;700&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/6da084a802.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>
</head>
<body>
<div class="flashcard-whole-container"> 
	<c:set var = "setName" scope = "session" value = "${param.set}"/> 
	<c:set var = "atPage" scope = "session" value = "${param.sender}"/> 
	<% 
	String setName = (String) pageContext.getAttribute("setName", PageContext.SESSION_SCOPE);
	String atPage = (String) pageContext.getAttribute("atPage", PageContext.SESSION_SCOPE);
	int setId = Integer.parseInt(setName);
	CardParser c = new CardParser();
	ArrayList<Card> cards = c.getCards(setId);
	String json = new Gson().toJson(cards);
	%>
	<c:set var = "cardData" scope = "session" value = '<%= cards %>'/> 
	
	<div class="display-modes-container">
	 	<p class="small-font" style="margin: 15px 0; font-weight: 600;"> Modes: </p>
		<div class="display-modes-buttons">			
			<button class="primaryButton" id="toFlashcardTest" onclick="toFlashcard()">Flashcard</button>
			<button class="primaryButton" id="toStudyTest" onclick="toStudy()">Study</button>
			<button class="primaryButton" id="toTestTest" onclick="toTest()">Test</button>
	 	</div>
	</div>
	
	<div class="flashcard-container">
		<div class="flashcard-displayer-test">
			<div class = "test-term">
				<p class="subtitle-font" id="test-term-header"> <span class="bold-font">Term:</span> </p>
				<p class="small-font" id="test-term-content">Example 1</p>
			</div>
			<div class = "test-definition">
				<p class="subtitle-font" id="test-definition-header"> <span class="bold-font">Definition:</span> </p>
				<p class="small-font" id="test-definition-content">Example 2</p>
			</div>
	    </div>
	    <div style="width: 5px;"></div>
		<div class="flashcard-buttons-container">
		    <div id="flashcard-form" class="flashcard-buttons" >
				<button id="false-button" class="icon-button" onclick="checkFalse()">
				<i class="fa-regular fa-circle-xmark"></i>
				</button>
				
				<p id="tracker" class="small-font"></p>
				
			    <button id="true-button" class="icon-button-2" onclick="checkTrue()">
			    <i class="fa-regular fa-circle-check"></i>
			    </button>
			</div>
		</div>
	</div>
	<%if (!atPage.contentEquals("setinformation.jsp")) { %>
		<input class="progress-bar" type="range" min="0" max="90" value="0" class="slider" id="myRange" disabled>	
	<% } %>
	<div class="next-step-button">
		<button class="icon-button-3" onclick = "update()">
		<i class="fa-solid fa-angles-right"></i>
		</button>
	</div>
	<script>
		var index1 = 0; // initial	
		var index2 = 0;
		var score = 0;
		var tries = 1;
		var isFinished = false;
		// convert java list of cards to json
		var jsonString = '<%= json %>'; 
		var jsonData = JSON.parse(jsonString);
		var cardSize = jsonData.length;
		
		const term = document.getElementById("test-term-content");
		const definition = document.getElementById("test-definition-content");
		const termHeader = document.getElementById("test-term-header");
		const defHeader = document.getElementById("test-definition-header");

		term.innerHTML = jsonData[index1]["term"];
		definition.innerHTML = jsonData[index2]["def"];

		const tracker = document.getElementById("myRange"); // displayer
		tracker.value = 0;
		
		function update() {
			if (!isFinished) {
				if (tries * 10 < tracker.max) {
					tries += 1;
					tracker.value = tries * 10;
					
					index1 = Math.floor( Math.random() * cardSize );
					index2 = Math.random() < 0.8 ? Math.floor( Math.random() * cardSize ) : index1;
					
					term.innerHTML = jsonData[index1]["term"];
					definition.innerHTML = jsonData[index2]["def"];
					
					document.getElementById("false-button").disabled = false;
					document.getElementById("true-button").disabled = false;				
				} else {
					tries += 1;
					confetti({
						particleCount: 160
					})
					termHeader.innerHTML = "Tries";
					termHeader.style.fontWeight = 600;
					term.innerHTML = tries;
					
					defHeader.innerHTML = "Final score";
					defHeader.style.fontWeight = 600;
					definition.innerHTML = score + "/" + tries * 10;
					
					document.getElementById("false-button").disabled = true;
					document.getElementById("true-button").disabled = true;
					isFinished = true;
				} 				
			} else {
				isFinished = false;
				score = 0;
				tries = 0;
				tracker.value = 0;
				
				termHeader.innerHTML = "Term:";
				termHeader.style.fontWeight = 600;
				
				defHeader.innerHTML = "Definition:";
				defHeader.style.fontWeight = 600;
				
				index1 = Math.floor( Math.random() * cardSize );
				index2 = Math.random() < 0.8 ? Math.floor( Math.random() * cardSize ) : index1;
				
				term.innerHTML = jsonData[index1]["term"];
				definition.innerHTML = jsonData[index2]["def"];
				
				document.getElementById("false-button").disabled = false;
				document.getElementById("true-button").disabled = false;
			}
		}
		
		function checkTrue() {
			if (index1 === index2 || definition === jsonData[index1]["def"]) {
				definition.innerHTML = "Correct! Answer: " + jsonData[index2]["def"];
				score += 10;
			} else {
				definition.innerHTML = "Incorrect! Answer: " + jsonData[index1]["def"];
			}
			document.getElementById("true-button").disabled = true;
			document.getElementById("false-button").disabled = true;
		}
		
		function checkFalse() {
			if (definition !== jsonData[index1]["def"]) {
				definition.innerHTML = "Correct! Answer: " + jsonData[index1]["def"];
				score += 10;
			} else {
				definition.innerHTML = "Incorrect! Answer: " + jsonData[index2]["def"];
			}
			document.getElementById("true-button").disabled = true;
			document.getElementById("false-button").disabled = true;
		}
		
		function toFlashcard () {
	        location.href = "./setinformation.jsp?setId=" + ${param.set};
	    };
	    
	    function toStudy () {
	        location.href = "./flashcard.jsp?setId=" + ${param.set};
	    };
	    
	    function toTest () {
	        location.href = "./flashcardTest.jsp?setId=" + ${param.set};
	    };
	</script>
</div>
</body>
</html>