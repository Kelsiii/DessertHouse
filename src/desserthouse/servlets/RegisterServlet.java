package desserthouse.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import desserthouse.action.ChargeListBean;
import desserthouse.action.OrderListBean;
import desserthouse.action.StoreListBean;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = new User();
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String tel = request.getParameter("tel");
		String address = request.getParameter("address");
		String card = request.getParameter("card");
		user.init();
		user.setAddress(address);
		user.setCard(card);
		user.setAge(0);
		user.setId(id);
		user.setPassword(password);
		user.setTel(tel);
		UserManager uc = new UserManagerImpl();
		boolean result = uc.addUser(user);
		PrintWriter out = response.getWriter();
		out.print(result);
		
		if(result){
			boolean cookieFound = false;
			Cookie cookie = null;
			Cookie[] cookies = request.getCookies();
			if (null != cookies) {
				// Look through all the cookies and see if the
				// cookie with the login info is there.
				for (int i = 0; i < cookies.length; i++) {
					cookie = cookies[i];
					if (cookie.getName().equals("LoginCookie")) {
						cookieFound = true;
						break;
					}
				}
			}
			if (cookieFound) { 
				// If the cookie exists update the value only
				if (!id.equals(cookie.getValue())) {
					cookie.setValue(id);
					response.addCookie(cookie);
				}
			} else {
				// If the cookie does not exist, create it and set value
				cookie = new Cookie("LoginCookie", id);
				cookie.setMaxAge(Integer.MAX_VALUE);
				response.addCookie(cookie);
			}
		}
	}
	
	
	

}
