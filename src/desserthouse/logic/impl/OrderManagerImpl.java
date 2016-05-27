package desserthouse.logic.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import desserthouse.dao.CommodityDao;
import desserthouse.dao.SaleDao;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.OrderManager;
import desserthouse.model.Commodity;
import desserthouse.model.Order;
import desserthouse.model.PlanCommodity;

public class OrderManagerImpl implements OrderManager{
	DaoFactory factory = new DaoFactory();
	SaleDao saleDao = factory.getSaleDao();
	CommodityDao commodityDao = factory.getCommodityDao();
	
	public List<Order> getOrderByStore(String store) {
		DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String day = df2.format(today);
		List<Order> list = saleDao.findTodayByStore(store, "unfinish", day);
		for(int i=0;i<list.size();i++){
			ArrayList<PlanCommodity> pclist = (ArrayList<PlanCommodity>) saleDao.findById(list.get(i).getId());
			for(int j=0;j<pclist.size();j++){
				Commodity c = commodityDao.find(pclist.get(j).getId());
				pclist.get(j).setName(c.getName());
			}
			list.get(i).setCommodity(pclist);
		}
		
		return list;
	}

	@Override
	public boolean finishOrder(String id) {
		boolean result = saleDao.update(id, "finish");
		return result;
	}

	
}
