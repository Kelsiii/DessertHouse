package desserthouse.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import desserthouse.action.ChargeListBean;
import desserthouse.action.OrderListBean;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.Cart;
import desserthouse.model.User;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
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
		String type = request.getParameter("type");
		UserManager um = new UserManagerImpl();
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		
		if(type.equals("update")){
			User user = (User) session.getAttribute("user");
			String tel = request.getParameter("tel");
			int age = Integer.parseInt(request.getParameter("age"));
			String address = request.getParameter("address");
			user.setAddress(address);
			user.setAge(age);
			user.setTel(tel);
			boolean result = um.updateUser(user);
			if(result){
				session.setAttribute("user", user);
			}
			out.println(result);
		}
		if(type.equals("stop")){
			User user = (User) session.getAttribute("user");
			user.setState("stopped");
			boolean result = um.updateUser(user);
			if(result){
				session.setAttribute("user", user);
			}
			out.println(result);
		}
		if(type.equals("charge")){
			User user = (User) session.getAttribute("user");
			double money = Double.parseDouble(request.getParameter("money"));
			boolean result = um.charge(user, money);
			if(result){
				session.setAttribute("user", user);
				
				ChargeListBean chargeListBean = new ChargeListBean();
				List chargeList = um.getChargeRecord(user.getId());
				chargeListBean.setChargeList(chargeList);
				session.setAttribute("ChargeList", chargeListBean);
			}
			out.println(result);
		}
		if(type.equals("search")){
			String id = request.getParameter("id");
			List list = um.find(id);
			if(list.isEmpty())
				out.print("nouser");
			else{
				User user = (User) list.get(0);
				session.setAttribute("saleuser", user);
				
				ChargeListBean chargeListBean = new ChargeListBean();
				List chargeList = um.getChargeRecord(user.getId());
				chargeListBean.setChargeList(chargeList);
				session.setAttribute("ChargeList", chargeListBean);
				List orderlist = um.getOrder(user.getId());
				OrderListBean orderListBean = new OrderListBean();
				orderListBean.setOrderList(orderlist);
				session.setAttribute("OrderList", orderListBean);
				out.print("true");
			}
		}
		if(type.equals("logout")){
			User user = new User();
			session.setAttribute("user", user);
			Cart cart = new Cart();
			session.setAttribute("ordercart", cart);
		}
	}

}
