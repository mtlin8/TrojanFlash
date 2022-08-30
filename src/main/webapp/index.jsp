<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <script src="https://kit.fontawesome.com/81f50cf91f.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
    <title>Home</title>
</head>


<body>
 <%@include file="headbar.jsp" %>
    
    <!-- Top image  -->
    <section class="bg-dark text-light p-5 text-center text-sm-start">
       <div class="container">
           <div class="d-sm-flex align-items-center justify-content-between">
               <div>
                   <h1>Welcome to <span style="color: #FD9751">Trojan Flash.</span></h1>
               </div>
               <img class="img-fluid rounded-xl w-75" src="studentstudying.jpg"/>
           </div>
        </div>
    </section>
    
    
    <!-- About Trojan Flash --> 
     <section id="about" class="bg-light text-dark p-4 text-center text-sm-start">
        <div class="container">
            <h2 class="text-center m-3 pb-5">90% of students who use Trojan Flash report higher grades.</h2>

            <div class="row align-items-center justify-content-between">
                <div class="col-md">
                    <img src="1.svg" class="img-fluid d-sm-block d-none" style="width: 75%">
                </div>
                <div class="col-md p-5">
                    <h2 class="pb-3">Explanations you can trust</h2>
                    <p class="lead">
                        Trojan Flash explanations show you step-by-step approaches to solve tough problems. Find solutions in 64 subjects, all written and verified by experts.
                    </p>
                    <a href="NewSet.jsp" class="btn btn-primary mt-3"><i class="bi bi-chevron-right"></i>Get Started</a>
                </div>

                <div class="row align-items-center justify-content-between">
                    <div class="col-md p-5">
                        <h2 class="pb-3">Whether you plan or cram, find your study jam.</h2>
                        <p class="lead">
                            Early morning? All-nighter? With teaching methods backed by learning science, Trojan Flash is designed to save you time.
                        </p>
                    </div>
                    <div class="col-md">
                        <img src="2.svg" class="img-fluid d-sm-block d-none" style="width: 75%">
                    </div>
            	</div>
        	</div>
        	<div class="row align-items-center justify-content-between">
                <div class="col-md">
                    <img src="3.svg" class="img-fluid d-sm-block d-none" style="width: 75%">
                </div>
                <div class="col-md p-5">
                    <h2 class="pb-3">Flashcards on repeat. Study modes on shuffle.</h2>
                    <p class="lead">
                        Mixed with smart study tools, our flashcards have been helping students ace their toughest exams since 2005.
                    </p>
                </div>

                <div class="row align-items-center justify-content-between">
                    <div class="col-md p-5">
                        <h2 class="pb-3">Millions of study sets.</h2>
                        <p class="lead">
                        	Find, study or create sets anywhere life takes you with the mobile app.
                        </p>
                    </div>
                    <div class="col-md">
                        <img src="4.svg" class="img-fluid d-sm-block d-none" style="width: 75%">
                    </div>
            	</div>
        	</div>
        </div>
    </section>
    
     <section class="text-center" style="background-color: #FD9751">
    	<div class="container">
    		<div class="col-md p-5">
            	<h3 class="header">Ready to start getting better grades?</h3>
            	<a href="NewSet.jsp" class="btn btn-primary btn-lg mt-3 p-3">Get Started</a>
            </div>
    	</div>
    </section>

</body>
</html>