package desserthouse.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import desserthouse.action.SaleStatisticBean;
import desserthouse.logic.Statistic;
import desserthouse.logic.impl.StatisticImpl;
import desserthouse.model.StaffSale;

/**
 * Servlet implementation class StatServlet
 */
@WebServlet("/StatServlet")
public class StatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Statistic stat = new StatisticImpl();
		String type = request.getParameter("type");
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		
		if(type.equals("commodity-stat")){
			String store = request.getParameter("store");
			String timetype = request.getParameter("timetype");
			List statisticlist = stat.saleStatistic(store, timetype);
			SaleStatisticBean sb = new SaleStatisticBean();
			sb.setCommodityList(statisticlist);
			session.setAttribute("SaleStat", sb);
			Map commdmap = stat.commodityStatByType(store, timetype);
			session.setAttribute("CommodityStat", commdmap);

			session.setAttribute("selectstore", store);
			session.setAttribute("selecttime", timetype);
			out.print(true);
		}
		if(type.equals("channel-stat")){
			String time = request.getParameter("time");
			List channel = stat.channelStatistic(time);
			session.setAttribute("ChannelStat", channel);
			session.setAttribute("selectyear", time);
			Map storemap = stat.storeStatistic(time);
			session.setAttribute("StoreStat", storemap);
		}
		if(type.equals("staff-stat")){
			String timetype = request.getParameter("timetype");
			List<StaffSale> staffsale = stat.staffStatistic(timetype);
			session.setAttribute("StaffStat", staffsale);
			session.setAttribute("selecttime", timetype);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
