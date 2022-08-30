package Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;

/**
 * Servlet implementation class LogoutDispatcher
 */
@WebServlet("/LogoutDispatcher")
public class LogoutDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // TODO Remove userID cookie (gets rid of all possible cookies)
    	Cookie[] cookies = request.getCookies();
        System.out.println("Cookie: " + cookies.length);
        for(Cookie gingerBreadCookie : cookies) {
        	gingerBreadCookie.setMaxAge(0);
        	response.addCookie(gingerBreadCookie);
        }
        HttpSession session = request.getSession(true);
        session.removeAttribute("username");
        System.out.println("Cookies Now: " + request.getCookies());
        // Redirect to the homepage
        try {
        	response.sendRedirect("./index.jsp");
			//request.getRequestDispatcher("./index.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        doGet(request, response);
    }

}
