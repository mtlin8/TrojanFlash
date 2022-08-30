package Util;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class RegisterDispatcher
 */
@WebServlet("/RegisterDispatcher")
public class RegisterDispatcher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterDispatcher() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Set response content type
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		// Validation
		boolean isValid = true;
		String error = "";
		String email = request.getParameter("sec");
		String password = request.getParameter("psw3").strip();
		String password2 = request.getParameter("psw2").strip();
		// Check validity of password
		if(password.equals(password2) == false) {
			isValid = false;
			error += " Passwords do not match" +  "\n";
		}
	    
		String name = request.getParameter("name");
		
		// Check validity of name
		boolean isValidName = true;
		if(name.matches(Constant.namePattern)) {
			isValidName = true;
		} else {
			isValidName = false;
		}
	    if(isValidName == false) {
	    	isValid = false;
	    	error += "Invalid username. Please use only letters and spaces. No special characters!!" + "\n";
	    	System.out.println("THis is name: " + name);
	    } else {
	    	System.out.println("Sucess");
	    }
	    
	    // Check validity of email
	    if(email.matches(Constant.emailPattern)) {
	    	// Do nothing
	    } else {
	    	isValid = false;
	    	error += "Not a valid email id";
	    }
		String agree = request.getParameter("agree");
		// out.println("<p>" + email + " " + password + " " + password2 + " " + name + " " + agree + "</p>" );
		// Insert into databse
		try{  
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
	        String message = e.getMessage();
			out.println("<h1>" + message + "</h1>");
			// e.printStackTrace();
		}
		try (Connection con= DriverManager.getConnection(  
					Constant.DBUrl, Constant.DBUserName,Constant.DBPassword);) {
			//here seekeats is database name, root is username and password  
			// Check is user already exists
			String query = "Select email, password, name from flashcards.user WHERE email='" + email + "'";
		    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,  ResultSet.CONCUR_UPDATABLE);
			System.out.println(query);
			ResultSet rs = stmt.executeQuery(query);
			String realEmail = null;
			String pass = null;
			if(rs.next()) {
				isValid = false;
				error += "User already exists with the same email";
				System.out.println("Not found");
			}
		    // Query/statement to insert the values
			String sql = "INSERT INTO flashcards.user (email, name, password) VALUES ('"+ email + "','" + name + "', '" + password + "');";
            Statement in = con.createStatement();

            // Execute the query
            if(isValid) {
            	 in.executeUpdate(sql);
            	 System.out.println("works");
            	 System.out.println(sql);
            }
  
            in.close();
            con.close(); 
           // out.println("<p>" + email + " " + password + " " + password2 + " " + name + " " + agree + "</p>" );
      
		} catch(Exception e) {
			out.println("<div style=\"background-color:pink; height:4%; padding-bottom:1%;\">" + "<p>" + e.getMessage() + "</p><div>");
		}
		// Action
		if(isValid == false) {
			out.println("<div style=\"background-color:pink; height:4%; padding-bottom:1%;\">" + "<p>" + error + "</p><div>");
			request.getRequestDispatcher("./auth.jsp").include(request, response);
		} else {
			request.getRequestDispatcher("./index.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
