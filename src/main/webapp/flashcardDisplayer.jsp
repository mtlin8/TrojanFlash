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
<script type="text/javascript">
   // Flip
   
</script>
<link href="flashcardDisplayer.css" rel="stylesheet">
<link href="template.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;600;700&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/6da084a802.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>
</head>
<body>
<div class="flashcard-whole-container"> 
	<%-- Code part one --%>
	<c:set var = "setName" scope = "session" value = "${param.set}"/> 
	<c:set var = "atPage" scope = "session" value = "${param.sender}"/> 
	<% 
	String setName = (String) pageContext.getAttribute("setName", PageContext.SESSION_SCOPE);
	String atPage = (String) pageContext.getAttribute("atPage", PageContext.SESSION_SCOPE);
	System.out.println("Id in flash: " + setName);
	int setId = Integer.parseInt(setName);
	CardParser c = new CardParser();
	ArrayList<Card> cards = c.getCards(setId);
	System.out.println("cards in flash: " + cards.toString());
	String json = new Gson().toJson(cards);
	int cardSize = cards.size();
	%>
	<c:set var = "cardData" scope = "session" value = '<%= cards %>'/> 
	
	<div class="display-modes-container">
		<p class="small-font" style="margin-bottom: 15px; font-weight: 600;"> Display: </p>
		<div class="display-modes-buttons">			
			<button class="primaryButton" onclick="switchTerm()">Term</button>
			<button class="primaryButton" onclick="switchDef()">Definition</button>
	 	</div>
	 	<p class="small-font" style="margin: 15px 0; font-weight: 600;"> Modes: </p>
		<div class="display-modes-buttons">			
			<button class="primaryButton" id="toFlashcard">Flashcard</button>
			<button class="primaryButton" id="toStudy">Study</button>
			<button class="primaryButton" id="toTest">Test</button>
	 	</div>
	</div>
	<div class="flashcard-container">
		<button class="flashcard-displayer" id="cards" onclick="flip()">
			<p id="cards-content" class="subheader-font"> Front </p>
	    </button>
	    
		<div class="flashcard-buttons-container">
		    <div id="flashcard-form" class="flashcard-buttons" action="CardHandler" autocomplete="on" method="GET">
				<button id="backward-button" class="icon-button" onclick="back()">
				<i class="fa-solid fa-arrow-left"></i>
				</button>
				
				<p id="tracker" class="small-font"></p>
				
				<div class="next-or-shuffle">
				    <button id="shuffle-button" class="icon-button" onclick="shuffle()">
				    <i class="fa-solid fa-shuffle"></i>
				    </button>    
					<button id="forward-button" class="icon-button" onclick="next()">
					<i class="fa-solid fa-arrow-right"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	<%if (!atPage.contentEquals("setinformation.jsp")) { %>
		<input class="progress-bar" type="range" min="0" max='<%= cardSize - 1%>' value="0" class="slider" id="myRange" disabled>
	<% } else { %>
		<input class="progress-bar" type="range" min="0" max='<%= cardSize - 1%>' value="0" class="slider" id="myRange" disabled hidden="true">
	<% } %>
	<script>
		var index = 0; // initial
		var isTerm = true;
		var visited = 0;
		var isFinished = false;
		
		// convert java list of cards to json
		var jsonString = '<%= json %>'; 
		var jsonData = JSON.parse(jsonString);
		var cardSize = jsonData.length;
		console.log(jsonData);
		var frontFace = jsonData[index]["term"];
		var backFace = jsonData[index]["def"];
		const card = document.getElementById("cards-content"); // displayer
		const tracker = document.getElementById("tracker"); // displayer
		const slider = document.getElementById("myRange"); // displayer
		card.innerHTML = frontFace;
		tracker.innerHTML = (index + 1).toString() +  "/" + cardSize.toString(); 
		slider.value = visited;
		
		// confetti
		function restart() {
			isFinished = false;
			slider.value = 0;
			index = 0;
			if (isTerm) {
				frontFace = jsonData[index]["term"];
				backFace = jsonData[index]["def"];
			} else {
				frontFace = jsonData[index]["def"];
				backFace = jsonData[index]["term"];
			}
			card.innerHTML = frontFace
			tracker.innerHTML = (index + 1).toString() +  "/" + cardSize.toString(); 
		}
		
		function update() {
			if (!isFinished) {
				if (slider.value < slider.max) {
					slider.value = index;
					if (isTerm) {
						frontFace = jsonData[index]["term"];
						backFace = jsonData[index]["def"];
					} else {
						frontFace = jsonData[index]["def"];
						backFace = jsonData[index]["term"];
					}
					card.innerHTML = frontFace
					tracker.innerHTML = (index + 1).toString() +  "/" + cardSize.toString(); 					
				} else {
					if (!slider.hidden) {
						confetti({
							particleCount: 160
						});
						card.innerHTML = "Congrats! You've studied everything!!!";
						isFinished = true;
					} else {
						restart();
					}
				}	
			} else { // if finished
				restart();
			}
		}
		
		function flip() {
			if(card.innerHTML === frontFace) {
			 card.innerHTML = backFace;
			} else {
			 card.innerHTML = frontFace;
			}
	   }  
		
		function next() {
			if (index === cardSize - 1) {
				index = 0;
			} else {
				index += 1;
			}
			update();
		}
		
		function back() {
			if (index === 0) {
				index = 0;
			} else {
				index -= 1;
			}
			update();
		}
		
		function shuffle() {
			index = Math.floor( Math.random() * cardSize );
			update();
		}
		
		function switchTerm() {
			if (isTerm) return;
			isTerm = true;
			update();
		}
		
		function switchDef() {
			if (!isTerm) return;
			isTerm = false;
			update();
		}
		
		document.getElementById("toFlashcard").onclick = function () {
	        location.href = "./setinformation.jsp?setId=" + ${param.set};
	    };
	    
	    document.getElementById("toStudy").onclick = function () {
	        location.href = "./flashcard.jsp?setId=" + ${param.set};
	    };
	    
	    document.getElementById("toTest").onclick = function () {
	        location.href = "./flashcardTest.jsp?setId=" + ${param.set};
	    };
	</script>
</div>
</body>
</html>