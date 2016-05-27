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
import desserthouse.action.StaffListBean;
import desserthouse.action.SaleStatisticBean;
import desserthouse.action.StoreListBean;
import desserthouse.logic.OrderManager;
import desserthouse.logic.PlanManager;
import desserthouse.logic.StaffManager;
import desserthouse.logic.StockManager;
import desserthouse.logic.StoreManager;
import desserthouse.logic.UserManager;
import desserthouse.logic.impl.OrderManagerImpl;
import desserthouse.logic.impl.PlanManagerImpl;
import desserthouse.logic.impl.StaffManagerImpl;
import desserthouse.logic.impl.StockManagerImpl;
import desserthouse.logic.impl.StoreManagerImpl;
import desserthouse.logic.impl.UserManagerImpl;
import desserthouse.model.Staff;
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
				List storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
			}
			else if(result.equals("manager")){
				List planlist = pm.GetUncheckedPlan();
				PlanListBean planListBean = new PlanListBean();
				planListBean.setPlanList(planlist);
				session.setAttribute("PlanList", planListBean);
				List statisticlist = stcm.saleStatistic();
				
				SaleStatisticBean sb = new SaleStatisticBean();
				sb.setCommodityList(statisticlist);
				session.setAttribute("SaleStat", sb);
				
				List<User> userlist = um.find();
				int age18 = 0;int age25=0;int age35=0;int age50=0;int agemore=0;
				int level1 = 0; int level2 = 0; int level3=0; int level4=0;
				int statei=0; int statea=0; int states=0; int statep=0;
				for(int i=0;i<userlist.size();i++){
					int age = userlist.get(i).getAge();
					int level = userlist.get(i).getLevel();
					User.UserState state = userlist.get(i).getState();
					
					switch(level){
					case 1:
						level1++;
						break;
					case 2:
						level2++;
						break;
					case 3:
						level3++;
						break;
					case 4:
						level4++;
						break;
					}
					if(age<18)
						age18++;
					else if(age<25)
						age25++;
					else if(age<35)
						age35++;
					else if(age<50)
						age50++;
					else
						agemore++;
					if(state==User.UserState.active)
						statea++;
					else if(state==User.UserState.inactive)
						statei++;
					else if(state==User.UserState.paused)
						statep++;
					else if(state==User.UserState.stopped)
						states++;
				}
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("less18", age18);
				map.put("1825", age25);
				map.put("2535", age35);
				map.put("3550", age50);
				map.put("more50", agemore);
				map.put("level1", level1);
				map.put("level2", level2);
				map.put("level3", level3);
				map.put("level4", level4);
				map.put("active", statea);
				map.put("inactive", statei);
				map.put("stop", states);
				map.put("paused", statep);
				session.setAttribute("UserStat", map);
				
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
