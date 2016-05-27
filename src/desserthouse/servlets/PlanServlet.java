package desserthouse.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import desserthouse.action.PlanListBean;
import desserthouse.action.StoreListBean;
import desserthouse.logic.PlanManager;
import desserthouse.logic.impl.PlanManagerImpl;
import desserthouse.logic.impl.StoreManagerImpl;
import desserthouse.model.Plan;

/**
 * Servlet implementation class PlanServlet
 */
@WebServlet("/PlanServlet")
public class PlanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlanServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PlanManager pm = new PlanManagerImpl();
		String type = request.getParameter("type");
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		if(type.equals("setDetail")){
			String id = request.getParameter("id");
			List list = pm.GetPlan(id);
			if(list.isEmpty())
				out.print(false);
			else{
				Plan plan  = (Plan) list.get(0);
				session.setAttribute("editplan", plan);
				out.print(true);
			}
		}
		if(type.equals("add")){

			Plan plan = new Plan();
			String id = pm.GetNewId();
			String store = request.getParameter("store");
			String date = request.getParameter("date");
			plan.setId(id);
			plan.setStore(store);
			plan.setDate(date);
			plan.setState("unchecked");
			plan.initCommodity();
			plan.initToday();
			String[] prices = request.getParameter("price").split(",");
			String[] nums = request.getParameter("num").split(",");
			for(int i=0;i<plan.getCommodity().size();i++){
				plan.getCommodity().get(i).setNum(Integer.parseInt(nums[i]));
				plan.getCommodity().get(i).setPrice(Double.parseDouble(prices[i]));
			}
			boolean result = pm.Add(plan);
			if(result){
				out.print("true");
				List planlist = pm.GetAllPlan();
				PlanListBean planListBean = new PlanListBean();
				planListBean.setPlanList(planlist);
				session.setAttribute("PlanList", planListBean);
			}
		}
		if(type.equals("update")){
			Plan plan = (Plan) session.getAttribute("editplan");
			String[] prices = request.getParameter("price").split(",");
			String[] nums = request.getParameter("num").split(",");
			for(int i=0;i<plan.getCommodity().size();i++){
				plan.getCommodity().get(i).setNum(Integer.parseInt(nums[i]));
				plan.getCommodity().get(i).setPrice(Double.parseDouble(prices[i]));
			}
			plan.setState("unchecked");
			boolean result = pm.Update(plan);
			if(result){
				out.print(result);
				List planlist = pm.GetAllPlan();
				PlanListBean planListBean = new PlanListBean();
				planListBean.setPlanList(planlist);
				session.setAttribute("PlanList", planListBean);
				
			}
		}
		if(type.equals("check")){
			String state = request.getParameter("state");
			Plan plan = (Plan) session.getAttribute("editplan");
			plan.setState(state);
			boolean result = pm.Update(plan);
			if(state.equals("approved")&&result){
				result = pm.Approve(plan);
			}
			out.print(result);
			
			List planlist = pm.GetUncheckedPlan();
			PlanListBean planListBean = new PlanListBean();
			planListBean.setPlanList(planlist);
			session.setAttribute("PlanList", planListBean);
		}
	}

}
