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

/**
 * Servlet implementation class CardHandler
 */
@WebServlet("/CardHandler")
public class CardHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public CardHandler() {
    	
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
        PrintWriter out = response.getWriter();
		
		// Validation
		if(request.getParameterMap().containsKey("shuffle")) {
			String s = request.getParameter("shuffle");
			out.println("Hello");
			if(s.equals("yes")) {
				Cookie man = new Cookie("shuffle", "yes");
				response.addCookie(man);
	       }
		}
		if(request.getParameterMap().containsKey("ac")) {
			String index = request.getParameter("index");
			String increase = request.getParameter("ac");
			String siz = request.getParameter("size");
			Integer ind = Integer.parseInt(index);
			Integer size = Integer.parseInt(siz);
			if(increase.equals("up")) {
				if(ind >= size) {
					ind = 0;
				} else {
					ind = ind+1;
				}
			} else if(increase.equals("down")) {
				if(ind <= 0) {
					ind = size-1;
				} else {
					ind = ind-1;
				}
				System.out.println("This is index: " + ind);
			} 
			String index2 = ind.toString();
			Cookie pumpkin = new Cookie("index", index2);
			response.addCookie(pumpkin);
		}
		if(request.getParameterMap().containsKey("op")) {
			String op = request.getParameter("op");
			if(op.equals("t")) {
				Cookie pumpkin2 = new Cookie("op", "t");
				response.addCookie(pumpkin2);
			} else if(op.equals("d")) {
				Cookie pumpkin2 = new Cookie("op", "d");
				response.addCookie(pumpkin2);
			}
		}
		response.sendRedirect("./" + request.getParameter("sender"));	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}