package desserthouse.logic.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import desserthouse.dao.CommodityDao;
import desserthouse.dao.SaleDao;
import desserthouse.dao.StockDao;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.StockManager;
import desserthouse.model.Cart;
import desserthouse.model.Commodity;
import desserthouse.model.PlanCommodity;

public class StockManagerImpl implements StockManager{
	DaoFactory factory = new DaoFactory();
	StockDao stockDao = factory.getStockDao();
	CommodityDao commodityDao = factory.getCommodityDao();
	SaleDao saleDao = factory.getSaleDao();
	
	public int getStock(String store, String date, String commodity) {
		PlanCommodity pc = stockDao.find(store, date, commodity);
		return pc.getNum();
	}

	public Commodity getCommodity(String store, String date, String commodity) {
		PlanCommodity pc = stockDao.find(store, date, commodity);
		Commodity comm = commodityDao.find(commodity);
		comm.setPrice(pc.getPrice());
		return comm;
	}


	public List<Commodity> getList(String store, String date, String type) {
		List<PlanCommodity> list = stockDao.find(store, date);
		List<Commodity> clist = commodityDao.find();
		List<Commodity> resultlist = new ArrayList();
		if(list.isEmpty())
			return null;
		else{
			for(int i=0;i<clist.size();i++){
				if(clist.get(i).getType().equals(type))
					resultlist.add(clist.get(i));
			}
			for(int i=0;i<resultlist.size();i++){
				for(int j=0;j<list.size();j++)
					if(resultlist.get(i).getId().equals((list.get(j)).getId()))
						resultlist.get(i).setPrice(list.get(j).getPrice());
			}
			return resultlist;
			
		}
	}

	public List<Commodity> getList(String store, String date) {
		List<PlanCommodity> list = stockDao.find(store, date);
		List<Commodity> clist = commodityDao.find();
		if(list.isEmpty())
			return null;
		else{
			for(int i=0;i<clist.size();i++){
				for(int j=0;j<list.size();j++)
					if(clist.get(i).getId().equals((list.get(j)).getId()))
						clist.get(i).setPrice(list.get(j).getPrice());
			}
			return clist;
			
		}
	}
	
	public boolean shopping(String store, String date, Cart cart, String type, String user, String address, String state) {
		String id = GetNewId();
		for(int i=0;i<cart.getList().size();i++){
			stockDao.update(store, date, 
					((PlanCommodity) cart.getList().get(i)).getId(), 
					((PlanCommodity) cart.getList().get(i)).getNum());
			
			saleDao.add(id, date, store, ((PlanCommodity) cart.getList().get(i)).getId(),
					((PlanCommodity) cart.getList().get(i)).getNum(),
			((PlanCommodity) cart.getList().get(i)).getPrice(), type, state, user, date, address);
		}
		return true;
	}
	
	public String GetNewId() {
		DateFormat df=new SimpleDateFormat("yyyyMMdd");
		Date today = new Date();
		String s = df.format(today);
		DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		List list = saleDao.findByCreateDate(df2.format(today));
		int num = list.size()+1;
		String str = String.format("%04d", num);
		return s+str;
	}

	@Override
	public List<PlanCommodity> saleStatistic() {
		ArrayList<PlanCommodity> list = (ArrayList<PlanCommodity>) saleDao.Statistic();
		List<Commodity> comlist = commodityDao.find();
		ArrayList<PlanCommodity> pclist = new ArrayList();
		for(int j=0;j<comlist.size();j++){
			PlanCommodity pc = new PlanCommodity();
			pc.setId(comlist.get(j).getId());
			pc.setName(comlist.get(j).getName());
			pc.setPrice(comlist.get(j).getPrice());
			pc.setNum(0);
			pclist.add(pc);
		}
		for(int i=0;i<pclist.size();i++){
			for(int j=0;j<list.size();j++){
				if(pclist.get(i).getId().equals(list.get(j).getId()))
					pclist.get(i).setNum(list.get(j).getNum());
			}
		}
		return pclist;
	}


}
