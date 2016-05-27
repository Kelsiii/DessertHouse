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
import desserthouse.logic.OrderManager;
import desserthouse.logic.StoreManager;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.OrderManagerImpl;
import desserthouse.logic.impl.StoreManagerImpl;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		UserManager um = new UserManagerImpl();
		StoreManager stm = new StoreManagerImpl();
		OrderManager om = new OrderManagerImpl();
		String result = um.login(id, password);
		if(!result.equals("nouser")){
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
			
			if(!result.equals("wrong")){
				// create a session to show that we are logged in
				HttpSession session = request.getSession(true);
				
				User user = (User) um.find(id).get(0);
				session.setAttribute("user", user);
				
				ChargeListBean chargeListBean = new ChargeListBean();
				List chargeList = um.getChargeRecord(id);
				chargeListBean.setChargeList(chargeList);
				session.setAttribute("ChargeList", chargeListBean);
				
				StoreListBean storeListBean = new StoreListBean();
				List storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
				
				List orderlist = um.getOrder(user.getId());
				OrderListBean orderListBean = new OrderListBean();
				orderListBean.setOrderList(orderlist);
				session.setAttribute("OrderList", orderListBean);
			}
		}
		
		PrintWriter out = response.getWriter();
		out.print(result);
	}

}
