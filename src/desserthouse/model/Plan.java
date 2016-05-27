package desserthouse.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import desserthouse.dao.CommodityDao;
import desserthouse.dao.PlanDao;
import desserthouse.factory.DaoFactory;

public class Plan {
	String id;
	String store;
	String createDate;
	String date;
	String state;
	ArrayList<PlanCommodity> commodity = new ArrayList();
	DaoFactory factory = new DaoFactory();
	CommodityDao commodityDao = factory.getCommodityDao();
	public void initCommodity(){
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
		this.commodity = pclist;
	}
	public void initToday(){
		DateFormat df=new SimpleDateFormat("yyyyMMdd");
		Date today = new Date();
		String s = df.format(today);
		this.createDate = s;
	}
	
	public void setId(String s){
		this.id = s;
	}
	public String getId(){
		return this.id;
	}
	public void setStore(String s){
		this.store = s;
	}
	public String getStore(){
		return this.store;
	}
	public void setDate(String s){
		this.date = s;
	}
	public String getDate(){
		return this.date;
	}
	public void setCreateDate(String s){
		this.createDate = s;
	}
	public String getCreateDate(){
		return this.createDate;
	}
	public void setState(String s){
		this.state = s;
	}
	public String getState(){
		return this.state;
	}
	public void setCommodity(ArrayList list){
		this.commodity = list;
	}
	public ArrayList<PlanCommodity> getCommodity(){
		return this.commodity;
	}
}
