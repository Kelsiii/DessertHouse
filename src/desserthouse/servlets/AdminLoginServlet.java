package desserthouse.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import desserthouse.action.OrderListBean;
import desserthouse.action.PlanListBean;
import desserthouse.action.PlanStatBean;
import desserthouse.action.StaffListBean;
import desserthouse.action.SaleStatisticBean;
import desserthouse.action.StoreListBean;
import desserthouse.logic.OrderManager;
import desserthouse.logic.PlanManager;
import desserthouse.logic.StaffManager;
import desserthouse.logic.Statistic;
import desserthouse.logic.StockManager;
import desserthouse.logic.StoreManager;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.OrderManagerImpl;
import desserthouse.logic.impl.PlanManagerImpl;
import desserthouse.logic.impl.StaffManagerImpl;
import desserthouse.logic.impl.StatisticImpl;
import desserthouse.logic.impl.StockManagerImpl;
import desserthouse.logic.impl.StoreManagerImpl;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.Plan;
import desserthouse.model.PlanCommodity;
import desserthouse.model.Staff;
import desserthouse.model.StaffSale;
import desserthouse.model.Store;
import desserthouse.model.User;

/**
 * Servlet implementation class AdminLoginServlet
 */
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		StaffManager sm = new StaffManagerImpl();
		StoreManager stm = new StoreManagerImpl();
		StockManager stcm = new StockManagerImpl();
		PlanManager pm = new PlanManagerImpl();
		OrderManager om = new OrderManagerImpl();
		UserManager um = new UserManagerImpl();
		Statistic stat = new StatisticImpl();
		String result = sm.login(id,password);
		response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("UTF-8");
		if(!(result=="nouser"||result=="wrong")){
			HttpSession session = request.getSession(true);
			Staff staff = (Staff) sm.find(id).get(0);
			session.setAttribute("staff", staff);
			if(result.equals("admin")){
				StoreListBean storeListBean = new StoreListBean();
				List storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
				
				StaffListBean staffListBean = new StaffListBean();
				List stafflist = sm.GetStaffList();
				staffListBean.setStaffList(stafflist);
				session.setAttribute("StaffList", staffListBean);
			}
			else if(result.equals("planner")){
				List planlist = pm.GetAllPlan();
				PlanListBean planListBean = new PlanListBean();
				planListBean.setPlanList(planlist);
				session.setAttribute("PlanList", planListBean);
				
				StoreListBean storeListBean = new StoreListBean();
				List<Store> storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
				
				Plan statplan = pm.getNullPlan();
				statplan.setStore(storelist.get(0).getId());
				statplan.setDate("点击选择日期");
				PlanStatBean planStat = new PlanStatBean();
				planStat.setPlan(statplan);
				session.setAttribute("PlanStat", planStat);
			}
			else if(result.equals("manager")){
				List planlist = pm.GetUncheckedPlan();
				PlanListBean planListBean = new PlanListBean();
				planListBean.setPlanList(planlist);
				session.setAttribute("PlanList", planListBean);
				
				List statisticlist = stat.saleStatistic("all", "month");
				SaleStatisticBean sb = new SaleStatisticBean();
				sb.setCommodityList(statisticlist);
				session.setAttribute("SaleStat", sb);
				

				Map commdmap = stat.commodityStatByType("all", "month");
				session.setAttribute("CommodityStat", commdmap);
				
				StoreListBean storeListBean = new StoreListBean();
				List<Store> storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
				
				Map usermap = stat.userStatistic();
				session.setAttribute("UserStat", usermap);
				Map userlevelmap = stat.userLevelStatistic();
				session.setAttribute("UserLevel", userlevelmap);
				
				List channel = stat.channelStatistic("2016");
				session.setAttribute("ChannelStat", channel);
				session.setAttribute("selectyear", "2016");
				
				Map storemap = stat.storeStatistic("2016");
				session.setAttribute("StoreStat", storemap);
				
				List<StaffSale> staffsale = stat.staffStatistic("month");
				session.setAttribute("StaffStat", staffsale);
				session.setAttribute("selectstore", "all");
				session.setAttribute("selecttime", "month");
			}
			else if(result.equals("saler")){
				Store store = stm.GetStore(staff.getStoreId());
				session.setAttribute("store", store);
				Date today = new Date();
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				String day = df.format(today);
				session.setAttribute("date", day);
				
				List orderlist = om.getOrderByStore(store.getId());
				OrderListBean orderListBean = new OrderListBean();
				orderListBean.setOrderList(orderlist);
				session.setAttribute("StoreOrderList", orderListBean);
				
			}
		}
		PrintWriter out = response.getWriter();
		out.print(result);
	}

}
