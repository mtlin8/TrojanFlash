<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="google-signin-client_id" content="918875497897-8ns0rvvgjtg4eujssm133gbisse8qhr1.apps.googleusercontent.com">
    <title>Login / Register</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin href="https://fonts.gstatic.com" rel="preconnect">
    <script crossorigin="anonymous"
            src="https://kit.fontawesome.com/3204349982.js"></script>
    <script src="https://kit.fontawesome.com/611c6f9edf.js" crossorigin="anonymous"></script>
    <script async defer src="https://apis.google.com/js/platform.js"></script>
    <link rel="stylesheet" href="auth.css">
    <link rel="stylesheet" href="template.css">
    <script src="https://apis.google.com/js/api:client.js"></script>

   <script>
   var googleUser = {};
   var startApp = function() {
     gapi.load('auth2', function(){
       // Retrieve the singleton for the GoogleAuth library and set up the client.
       auth2 = gapi.auth2.init({
         client_id: '918875497897-8ns0rvvgjtg4eujssm133gbisse8qhr1.apps.googleusercontent.com',
         cookiepolicy: 'single_host_origin',
       });
       attachSignin(document.getElementById('customBtn'));
     });
   };

   function attachSignin(element) {
     console.log(element.id);
     auth2.attachClickHandler(element, {},
         function(googleUser) {
           document.getElementById('name').innerText = "Signed in: " +
               googleUser.getBasicProfile().getName();
           console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
		   window.location.href = "google?name=" + googleUser.getBasicProfile().getName() + "&fir=" + googleUser.getBasicProfile().getEmail();
         }, function(error) {
           alert(JSON.stringify(error, undefined, 2));
         });
     }
	   
  </script>
</head>
<body>
    <!-- Top Navigation -->
    <%@include file="headbar.jsp" %>
    <!--Login -->
    <!-- https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_login_form -->
    <div class="content-container">
	    <div class="login">
	       <p class="subtitle-font" style="font-weight: 550;">Login</p>
	       <form class="login-form" action="LoginDispatcher" method="GET">
				<label class="xsmall-font" for="uname">Email</label>
				<input class="text-field" type="email" name="fir" id="fir" required>
			    
				<label class="xsmall-font" for="psw">Password</label>
				<input class="text-field" type="password" id="psw" name="psw" required>
				    
				<button type="submit" class="tertiary-button" style="width: 80%"><i class="fa-solid fa-right-to-bracket"></i>  Sign In</button>
	       </form>
	        <div id="name"></div>
	        <script>startApp();</script>
		</div>
		
		<!-- Registration -->
		<div class="register">
		     <p class="subtitle-font" style="font-weight: 550;">Register</p>
		       <form class="register-form" action="RegisterDispatcher" method="GET">
			        <label class="xsmall-font" for="uname">Email</label>
				    <input class="text-field" type="email" name="sec" id="email2" required>
				    
				    <label class="xsmall-font" for="psw">Name</label>
				    <input class="text-field" type="text" name="name" required>
				    
				    <label class="xsmall-font" for="psw">Password</label>
				    <input class="text-field" type="password" name="psw3" required>
				    
				    <label class="xsmall-font" for="psw2">Confirm Password</label>
				    <input class="text-field" type="password" name="psw2" required>
				    
				    <div style="display:flex; justify-content: start; align-items:center; margin-bottom: 10px;">
					    <input type="checkbox" required>
					    <label class="xsmall-font" for="agree">I have read and agree to all terms and conditions of Trojan Flash.</label>    
				    </div>
				    <button type="submit" class="secondary-button"><i class="fa-solid fa-user-plus"></i> Create Account</button>
		       </form>
	      <%@include file="backgroundAnimation.jsp" %>
		</div>
    </div>
</body>
</html>