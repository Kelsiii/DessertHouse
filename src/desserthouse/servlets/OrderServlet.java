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

import desserthouse.action.CommodityListBean;
import desserthouse.action.OrderListBean;
import desserthouse.logic.StockManager;
import desserthouse.logic.StoreManager;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.StockManagerImpl;
import desserthouse.logic.impl.StoreManagerImpl;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.Cart;
import desserthouse.model.Commodity;
import desserthouse.model.PlanCommodity;
import desserthouse.model.Store;
import desserthouse.model.User;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
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
		
		if(type.equals("find")){
			String storeid = request.getParameter("store");
			String date = request.getParameter("date");
			String ctype = request.getParameter("ctype");
			List<Commodity> list = sm.getList(storeid, date,ctype);
			if(list==null)
				out.print("noplan");
			else{
				int all = list.size();
				for(int i=0;i<all;i++){
					int stock = sm.getStock(storeid, date, list.get(i).getId());
					if(stock==0){
						list.remove(i);
						i--;
						all--;
					}
				}
				CommodityListBean commodityListBean = new CommodityListBean();
				commodityListBean.setCommodityList(list);
				session.setAttribute("CommodityList", commodityListBean);
				
				StoreManager stm = new StoreManagerImpl();
				Store store = stm.GetStore(storeid);
				session.setAttribute("store", store);
				session.setAttribute("date", date);
				out.print("true");
			}
		}
		else if(type.equals("findtype")){
			String storeid = ((Store) session.getAttribute("store")).getId();
			String date = (String) session.getAttribute("date");
			String ctype = request.getParameter("ctype");
			List<Commodity> list = sm.getList(storeid, date,ctype);
			int all = list.size();
			for(int i=0;i<all;i++){
				int stock = sm.getStock(storeid, date, list.get(i).getId());
				if(stock==0){
					list.remove(i);
					i--;
					all--;
				}
			}
			CommodityListBean commodityListBean = new CommodityListBean();
			commodityListBean.setCommodityList(list);
			session.setAttribute("CommodityList", commodityListBean);
			out.print("true");
		
		}
		else if(type.equals("addCommodity")){
			Cart cart = (Cart) session.getAttribute("ordercart");
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
				session.setAttribute("ordercart", cart);
				out.print("true");
			}
		}
		else if(type.equals("addNum")){
			Cart cart = (Cart) session.getAttribute("ordercart");
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
				session.setAttribute("ordercart", cart);
				out.print(cart.getTotal());
			}
		}
		else if(type.equals("minNum")){
			Cart cart = (Cart) session.getAttribute("ordercart");
			int k = Integer.parseInt(request.getParameter("commodity_id"));
			String commodity_id = ((PlanCommodity) cart.getList().get(k)).getId();
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
		
			Commodity comm = sm.getCommodity(store.getId(), date, commodity_id);
			cart.min(comm);
			session.setAttribute("ordercart", cart);
			out.print(cart.getTotal());
		
		}
		else if(type.equals("delete")){
			Cart cart = (Cart) session.getAttribute("ordercart");
			int k = Integer.parseInt(request.getParameter("commodity_id"));
			String commodity_id = ((PlanCommodity) cart.getList().get(k)).getId();
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
		
			Commodity comm = sm.getCommodity(store.getId(), date, commodity_id);
			cart.delete(comm);
			session.setAttribute("ordercart", cart);
			out.print(cart.getTotal());
		}
		else if(type.equals("sub")){
			UserManager um = new UserManagerImpl();
			String delivertype = request.getParameter("delivertype");
			Store store = (Store) session.getAttribute("store");
			String date = (String) session.getAttribute("date");
			Cart cart = (Cart) session.getAttribute("ordercart");
			User user = (User) session.getAttribute("user");
			String address = request.getParameter("address");

			String usepoint = request.getParameter("usepoint");
			int pointused = 0;
			if(usepoint.equals("yes")){
				pointused = Integer.parseInt(request.getParameter("point"));
				double total = cart.getTotal();
				total = total - pointused/100;
				cart.setTotal(total);
				
			}
			if(user.getBalance()<cart.getTotal())
				out.print("nomoney");
			else if(user.getState()!=User.UserState.active)
				out.print("noactive");
			else{
				boolean result = sm.shopping(store.getId(), date, cart, delivertype, user.getId(), address, "unfinish");
			
				out.print(result);
				if(result){
					double ob = user.getBalance();
					user.setBalance(ob-cart.getTotal());
					double op = user.getPoint();
					user.setPoint((int) (op+cart.getTotal()-pointused));
					user.setLevel();
					um.updateUser(user);
					cart = new Cart();
					cart.init();
					session.setAttribute("ordercart", cart);
					
					user = um.find(user.getId()).get(0);
					session.setAttribute("user", user);
					
					List orderlist = um.getOrder(user.getId());
					OrderListBean orderListBean = new OrderListBean();
					orderListBean.setOrderList(orderlist);
					session.setAttribute("OrderList", orderListBean);
				}
			}
		}
	}

}
