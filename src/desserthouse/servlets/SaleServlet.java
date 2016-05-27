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

import desserthouse.action.OrderListBean;
import desserthouse.logic.OrderManager;
import desserthouse.logic.StockManager;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.OrderManagerImpl;
import desserthouse.logic.impl.StockManagerImpl;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.Cart;
import desserthouse.model.Commodity;
import desserthouse.model.PlanCommodity;
import desserthouse.model.Store;
import desserthouse.model.User;

/**
 * Servlet implementation class SaleServlet
 */
@WebServlet("/SaleServlet")
public class SaleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaleServlet() {
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
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		StockManager sm = new StockManagerImpl();
		UserManager um = new UserManagerImpl();
		OrderManager om = new OrderManagerImpl();
		
		if(type.equals("addCommodity")){
			Cart cart = (Cart) session.getAttribute("salecart");
			if(cart==null){
				cart = new Cart();
				cart.init();
			}
			String commodity_id = request.getParameter("commodity_id");
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
			int stock = sm.getStock(store.getId(), date, commodity_id);
			if(stock==0)
				out.print("solded");
			else if(stock<0)
				out.print("nocomm");
			else{
				Commodity comm = sm.getCommodity(store.getId(), date, commodity_id);
				cart.add(comm);
				session.setAttribute("salecart", cart);
				out.print("true");
			}
		}
		else if(type.equals("addNum")){
			Cart cart = (Cart) session.getAttribute("salecart");
			int k = Integer.parseInt(request.getParameter("commodity_id"));
			String commodity_id = ((PlanCommodity) cart.getList().get(k)).getId();
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
			int stock = sm.getStock(store.getId(), date, commodity_id);
			int num = ((PlanCommodity) cart.getList().get(k)).getNum();
			if(stock-num-1<0)
				out.print("nostock");
			else{
				Commodity comm = sm.getCommodity(store.getId(), date, commodity_id);
				cart.add(comm);
				session.setAttribute("salecart", cart);
				out.print(cart.getTotal());
			}
		}
		else if(type.equals("minNum")){
			Cart cart = (Cart) session.getAttribute("salecart");
			int k = Integer.parseInt(request.getParameter("commodity_id"));
			String commodity_id = ((PlanCommodity) cart.getList().get(k)).getId();
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
		
			Commodity comm = sm.getCommodity(store.getId(), date, commodity_id);
			cart.min(comm);
			session.setAttribute("salecart", cart);
			out.print(cart.getTotal());
		
		}
		else if(type.equals("delete")){
			Cart cart = (Cart) session.getAttribute("salecart");
			int k = Integer.parseInt(request.getParameter("commodity_id"));
			String commodity_id = ((PlanCommodity) cart.getList().get(k)).getId();
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
		
			Commodity comm = sm.getCommodity(store.getId(), date, commodity_id);
			cart.delete(comm);
			session.setAttribute("salecart", cart);
			out.print(cart.getTotal());
		}
		else if(type.equals("sub")){
			String paytype = request.getParameter("paytype");
			boolean uservalid = false;
			User user = new User();
			Cart cart = (Cart) session.getAttribute("salecart");
			if(paytype.equals("card")){
				String userid = request.getParameter("card");
				List l = um.find(userid);
				if(l.isEmpty())
					out.print("nouser");
				else{
					user = (User) l.get(0);
					if(user.getBalance()<cart.getTotal())
						out.print("nomoney");
					else if(user.getState()!=User.UserState.active)
						out.print("noactive");
					else
						uservalid = true;
				}
			}
			if(paytype.equals("money")||uservalid){
				String saletype="store";
				String userid = "";
				if(uservalid)
					userid = request.getParameter("card");
				Store store = (Store) session.getAttribute("store");
				String date = (String) session.getAttribute("date");
				boolean result = sm.shopping(store.getId(), date, cart, saletype, userid, "", "finish");
				out.print(result);
				if(result&&uservalid){
					double ob = user.getBalance();
					user.setBalance(ob-cart.getTotal());
					double op = user.getPoint();
					user.setPoint((int) (op+cart.getTotal()));
					user.setLevel();
					um.updateUser(user);
				}
				cart = new Cart();
				cart.init();
				session.setAttribute("salecart", cart);
			}
		}
		else if(type.equals("orderget")){
			String orderid = request.getParameter("orderId");
			boolean result = om.finishOrder(orderid);
			out.print(result);
			
			Store store = (Store) session.getAttribute("store");
			List orderlist = om.getOrderByStore(store.getId());
			OrderListBean orderListBean = new OrderListBean();
			orderListBean.setOrderList(orderlist);
			session.setAttribute("StoreOrderList", orderListBean);
		}
	}

}
