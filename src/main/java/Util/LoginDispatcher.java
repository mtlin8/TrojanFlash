package Util;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginDispatcher
 */
@WebServlet("/LoginDispatcher")
public class LoginDispatcher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginDispatcher() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		// Set response content type
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		// Validation
		boolean isValid = true; 
		String password = request.getParameter("psw").strip();
		String email = request.getParameter("fir");
		System.out.println(email);
		String name = request.getParameter("name");
		boolean userExists = false;
		String error = "";
		
		// Finf in databse
		try{  
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
	        String message = e.getMessage();
			out.println("<h1>" + "Error" + "</h1>");
		}
		String name2 = null;
		int id = 0;
		try (Connection con= DriverManager.getConnection(  
					Constant.DBUrl, Constant.DBUserName,Constant.DBPassword);) {
			//here seekeats is database name, root is username and password  
		    // Query/statement to insert the values
		    String query = "Select email, password, name, user_id from flashcards.user WHERE email='" + email + "'";
		    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,  ResultSet.CONCUR_UPDATABLE) ;
			ResultSet rs = stmt.executeQuery(query);
			String realEmail = null;
			String pass = null;
			if(rs.next()) {
				realEmail = rs.getString("email");
				pass = rs.getString("password").strip();
				id = rs.getInt("user_id");
				if(pass.equals(password) == false || pass == null) {
					 error = " Invalid Password";
					 isValid = false;
				}
				name2 = rs.getString("name");
			} else {
				error = "No account with that email exists";
				isValid = false;
			}
		} catch(Exception e) {
			out.println("<h1>" + e.getMessage() + "</h1>");
		}
 		// Action
		if(isValid == false) {
			out.println("<div style=\"background-color:pink; height:4%; padding-bottom:1%;\">" + "<p>" + error + "</p><div>");
			//out.println("<div style=" + "\"background-color:pink\"" + "\"height:50px\"" + "<p>" + error + "</p><div>");
			request.getRequestDispatcher("/auth.jsp").include(request, response);
		} else {
			// Make cookie
			String name3 = name2.replace(' ', '$');
			System.out.println("Name3: " + name3);
			Cookie user = new Cookie("User", name3);
			response.addCookie(user);
			HttpSession session = request.getSession();
			session.setAttribute("username", name3);
			session.setAttribute("id", id);
			response.sendRedirect("./index.jsp");
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
