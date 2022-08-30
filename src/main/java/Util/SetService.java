package Util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SetService")
public class SetService extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private String setname;
	private int user;
	private String description;
	private int numCards;
	private int privacy;
	private String publicity;
	private String[] term;
	private String[] def;
	private int setID;
	
	public SetService() {}
	
	public void doGet(HttpServletRequest request, HttpServletResponse
			response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		publicity = request.getParameter("publicity");
		if(publicity == "Public") {
			privacy = 0;
		}
		else {
			privacy = 1;
		}
		term = request.getParameterValues("phrase");
		def = request.getParameterValues("des");
		setname = request.getParameter("setname");
		// Error Checking
		boolean isValid = true;
		String error = "";
		if(session.getAttribute("username") == null) {
			isValid = false;
			error += "Not signed in. Only authenticated users can make a set.";
			PrintWriter out = response.getWriter();
			out.println("<div style=\"background-color:pink; height:4%; padding-bottom:1%;\">" + "<p>" + error + "</p><div>");
			request.getRequestDispatcher("/NewSet.jsp").include(request, response);
		}
		user = (int) session.getAttribute("id");
		description = request.getParameter("description");
		numCards = term.length;
		
		SetData setdata = new SetData();
		setdata.insertSet(setname, user, description, numCards, privacy);
		setID = setdata.getSetID(setname, user);
		System.out.println("Mayb " + setID);
		for(int i=0; i<term.length; i++) {
			setdata.insertCard(setID, term[i], def[i]);
		}
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse 
			response) throws ServletException, IOException {
		doGet(request, response);
	}
}