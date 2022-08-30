<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" charset="ISO-8859-1">
    <link rel="stylesheet" href="NewSet.css">
    <link rel="stylesheet" href="template.css">
    <link rel="stylesheet" href="cardBlock.css">
    <title>New Set</title>
</head>

<body>
<%@include file="headbar.jsp" %>
<%! String name = null; %>
<%  if (!isRegistered) {
		response.sendRedirect("./auth.jsp");
	} else {
	    if(name != null) {
	    	name = name.replace("$", " ");
	    }		
	}
  %>
<div class="subtitle-font">Created by <span style="font-weight: bold"><%=name%></span></div>
<form class="create-form" id='form' name="form" action="SetService" onsubmit="return validateForm()" method="GET">
    <label>
        <input type="radio" name="publicity" value="Public" class="radiobtn" checked/>Public<br>
        <input type="radio" name="publicity" value="Private" class="radiobtn"/>Private
    </label>

    <div class="getSetInfo">
        <input type="text" placeholder="Please enter new set name" name="setname"/>
        <input type="text" placeholder="Please enter description here" name="description"/>
    </div>
    
    <div class="btngroup">
        <input class="tertiary-button" type="button" name="addbtn" value="Add more cards" onclick="addNode()"/>
        <input class="secondary-button" type="submit" name="fshbtn" value="Submit"/>
    </div>
    <div id="card-list">
	    <div class="card-block-container">
	        <div class="card-block-text">
	            <p class="card-block-phrase">
	                <input type="text" name="phrase" class="phrase" placeholder="new term"/>
	            </p>
	            <p class="card-block-definition">
	                <input type="text" name="des" class="description" placeholder="new definition"/>
	            </p>
	        </div>
	    </div>
	    <div class="card-block-container">
	        <div class="card-block-text">
	            <p class="card-block-phrase">
	                <input type="text" name="phrase" class="phrase" placeholder="new term"/>
	            </p>
	            <p class="card-block-definition">
	                <input type="text" name="des" class="description" placeholder="new definition"/>
	            </p>
	        </div>
	    </div>
    </div>
</form>
</body>

<script>
    function addNode() {
        var form = document.getElementById("card-list");
        var p =
            "    <div class=\"card-block-container\">\n" +
            "        <div class=\"card-block-text\">\n" +
            "            <p class=\"card-block-phrase\">\n" +
            "                <input type=\"text\" name=\"phrase\" class=\"phrase\" placeholder=\"new term\"/>\n" +
            "            </p>\n" +
            "            <p class=\"card-block-definition\">\n" +
            "                <input type=\"text\" name=\"des\" class=\"description\" placeholder=\"new definition\"/>\n" +
            "            </p>\n" +
            "        </div>\n" +
            "    </div>";
        var o = document.createElement("div");
        o.innerHTML = p;
        console.log(o.childNodes[1])
        form.appendChild(o.childNodes[1]);
    }
    
    function validateForm() {
    	var set = document.forms["form"]["setname"].value;
    	if (set == "" || set == null) {
	   	    alert("Set Name must be filled out");
	   	    return false;
	   	}
    }
</script>
</html>
