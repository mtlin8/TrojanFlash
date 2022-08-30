package Util;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Serial;
import java.util.ArrayList;

/**
 * Servlet implementation class SearchDispatcher
 */
@WebServlet("/SearchDispatcher")
public class SearchDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public SearchDispatcher() {
    	 
    	
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html");
    	PrintWriter out = response.getWriter();
    	String Id = request.getParameter("owner");
    	String searchInput = request.getParameter("search-input");
    	int userId = 0;
    	if (Id != null) {
    		userId = Integer.parseInt(Id);
    	}    	
    	ArrayList<CardSet> result = new PublicSetParser().getPublicSets(searchInput, userId);
    	if (result == null) {
    		String error = "No results found";
    		out.println("<div style=\"background-color:pink; height:4%; padding-bottom:1%;\">" + "<p>" + error + "</p><div>");
            // Go back to search page (error already printed)
            request.getRequestDispatcher("/publicSetSearch.jsp").include(request, response);
    	} else if(result.size() == 0) {
			String error = "No results found";
			out.println("<div style=\"background-color:pink; height:4%; padding-bottom:1%;\">" + "<p>" + error + "</p><div>");
            // Go back to search page (error already printed)
            request.getRequestDispatcher("/publicSetSearch.jsp").include(request, response);
		} 
		else {
			request.setAttribute("Results", result);
			request.setAttribute("cookie", request.getAttribute("Cookie"));
            HttpSession session = request.getSession();
			session.setAttribute("sets", result);
			request.getRequestDispatcher("./publicSetSearch.jsp").forward(request, response);
		}
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}