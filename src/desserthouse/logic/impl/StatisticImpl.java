package desserthouse.logic.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import desserthouse.dao.CommodityDao;
import desserthouse.dao.SaleDao;
import desserthouse.dao.StaffDao;
import desserthouse.dao.StockDao;
import desserthouse.dao.StoreDao;
import desserthouse.dao.UserDao;
import desserthouse.dao.impl.SaleDaoImpl;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.Statistic;
import desserthouse.model.Commodity;
import desserthouse.model.PlanCommodity;
import desserthouse.model.Staff;
import desserthouse.model.StaffSale;
import desserthouse.model.Store;
import desserthouse.model.StoreSale;
import desserthouse.model.User;

public class StatisticImpl implements Statistic{
	DaoFactory factory = new DaoFactory();
	StockDao stockDao = factory.getStockDao();
	StoreDao storeDao = factory.getStoreDao();
	CommodityDao commodityDao = factory.getCommodityDao();
	SaleDao saleDao = factory.getSaleDao();
	StaffDao staffDao = factory.getStaffDao();
	UserDao userDao = factory.getUserDao();
	
	public List<PlanCommodity> planStatistic(String store, String date) {
		String begindate = monthSubtraction(date)+"-"+date.split("-")[2];
		String enddate = date;
		ArrayList<PlanCommodity> list1 = (ArrayList<PlanCommodity>) saleDao.Statistic(store, begindate, enddate);
		
		List<Commodity> comlist = commodityDao.find();
		ArrayList<PlanCommodity> pclist1 = new ArrayList();
		ArrayList<PlanCommodity> pclist2 = new ArrayList();
		for(int j=0;j<comlist.size();j++){
			PlanCommodity pc = new PlanCommodity();
			pc.setId(comlist.get(j).getId());
			pc.setName(comlist.get(j).getName());
			pc.setPrice(comlist.get(j).getPrice());
			pc.setNum(0);
			pclist1.add(pc);
			pclist2.add(pc);
		}
		for(int i=0;i<pclist1.size();i++){
			for(int j=0;j<list1.size();j++){
				if(pclist1.get(i).getId().equals(list1.get(j).getId()))
					pclist1.get(i).setNum(list1.get(j).getNum());
			}
		}
		
		date = Integer.toString(Integer.parseInt(date.split("-")[0])-1)+date.substring(4);
		begindate = monthSubtraction(date)+"-"+date.split("-")[2];
		enddate = date;
		ArrayList<PlanCommodity> list2 = (ArrayList<PlanCommodity>) saleDao.Statistic(store, begindate, enddate);
		for(int i=0;i<pclist2.size();i++){
			for(int j=0;j<list2.size();j++){
				if(pclist2.get(i).getId().equals(list2.get(j).getId()))
					pclist2.get(i).setNum(list2.get(j).getNum());
			}
		}
		
		for(int i=0;i<pclist1.size();i++){
			for(int j=0;j<list2.size();j++){
				if(pclist1.get(i).getId().equals(pclist2.get(j).getId())){
					
					pclist1.get(i).setNum((int) Math.ceil(pclist1.get(j).getNum()*0.8+pclist2.get(j).getNum()*0.2));
				}
			}
		}
		
		return pclist1;
	}
	
	public List<PlanCommodity> saleStatistic(String store, String timetype) {
		DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String day = df2.format(today);
		
		String begindate="";
		String enddate=day;
		
		if(timetype.equals("year")){
			begindate = day.split("-")[0]+"-01-01";
		}
		else if(timetype.equals("season")){
			int month = Integer.parseInt(day.split("-")[1]);
			if(month<=3)
				begindate = day.split("-")[0]+"-01-01";
			else if(month<=6)
				begindate = day.split("-")[0]+"-04-01";
			else if(month<=9)
				begindate = day.split("-")[0]+"-07-01";
			else 
				begindate = day.split("-")[0]+"-10-01";
		}
		else
			begindate = day.substring(0, 8)+"01";
		ArrayList<PlanCommodity> list = new ArrayList();
		if(store.equals("all"))
			list = (ArrayList<PlanCommodity>) saleDao.Statistic(begindate,enddate);
		else
			list = (ArrayList<PlanCommodity>) saleDao.Statistic(store,begindate,enddate);
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
				if(pclist.get(i).getId().equals(list.get(j).getId())){
					pclist.get(i).setNum(list.get(j).getNum());
					System.out.println(pclist.get(i).getNum());
				}
			}
		}
		return pclist;
	}

	public List<StaffSale> staffStatistic(String timetype){
		DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String day = df2.format(today);
		
		String begindate="";
		String enddate=day;
		
		if(timetype.equals("year")){
			begindate = day.split("-")[0]+"-01-01";
		}
		else if(timetype.equals("season")){
			int month = Integer.parseInt(day.split("-")[1]);
			if(month<=3)
				begindate = day.split("-")[0]+"-01-01";
			else if(month<=6)
				begindate = day.split("-")[0]+"-04-01";
			else if(month<=9)
				begindate = day.split("-")[0]+"-07-01";
			else 
				begindate = day.split("-")[0]+"-10-01";
		}
		else
			begindate = day.substring(0, 8)+"01";
		
		List<StaffSale> list = saleDao.staffStatistic(begindate, enddate);
		List<Staff> stafflist = staffDao.Find();
		List<StaffSale> sslist = new ArrayList<StaffSale>();
		for(int i=0;i<stafflist.size();i++){
			if(stafflist.get(i).getPosition().equals("saler")){
				StaffSale ss = new StaffSale();
				ss.setId(stafflist.get(i).getId());
				ss.setName(stafflist.get(i).getName());
				ss.setNum(0);
				sslist.add(ss);
			}
		}
		for(int i=0;i<sslist.size();i++){
			for(int j=0;j<list.size();j++){
				if(sslist.get(i).getId().equals(list.get(j).getId())){
					sslist.get(i).setNum(list.get(j).getNum());
					break;
				}
			}
		}
		return sslist; 
		
	}
	
	public Map commodityStatByType(String store,String timetype){
		List<PlanCommodity> numList = saleStatistic(store,timetype);
		List<PlanCommodity> priceList = salePriceStatistic(store,timetype);
		List<Commodity> commodityList = commodityDao.find();
		
		int breadnum=0,cakenum=0,dessertnum=0,drinknum=0;
		double breadprice=0,cakeprice=0,dessertprice=0,drinkprice=0;
		for(int i=0;i<commodityList.size();i++){
			for(int j=0;j<numList.size();j++){
				if(commodityList.get(i).getId().equals(numList.get(j).getId())){
					switch(commodityList.get(i).getType()){
					case "bread":
						breadnum = breadnum+numList.get(j).getNum();
						break;
					case "cake":
						cakenum = cakenum+numList.get(j).getNum();
						break;
					case "drink":
						drinknum = drinknum+numList.get(j).getNum();
						break;
					case "dessert":
						dessertnum = dessertnum+numList.get(j).getNum();
						break;
					}
				}
			}
			for(int j=0;j<priceList.size();j++){
				if(commodityList.get(i).getId().equals(priceList.get(j).getId())){
					switch(commodityList.get(i).getType()){
					case "bread":
						breadprice = breadprice+priceList.get(j).getPrice();
						break;
					case "cake":
						cakeprice = cakeprice+priceList.get(j).getPrice();
						break;
					case "drink":
						drinkprice = drinkprice+priceList.get(j).getPrice();
						break;
					case "dessert":
						dessertprice = dessertprice+priceList.get(j).getPrice();
						break;
					}
				}
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("breadnum", breadnum);
		map.put("drinknum",drinknum);
		map.put("dessertnum", dessertnum);
		map.put("cakenum",cakenum);
		map.put("breadprice", breadprice);
		map.put("drinkprice", drinkprice);
		map.put("dessertprice", dessertprice);
		map.put("cakeprice", cakeprice);
		
		return map;
		
	}
	
	public Map storeStatistic(String year){
		Map<String,Object> map = new HashMap<String,Object>();
		for(int m=0;m<12;m++){
			String month = Integer.toString(m+1);
			if(m<9)
				month = "0"+month;
			String begindate = year+"-"+month+"-01";
			String enddate = monthAddition(begindate)+"-01";
			List<StoreSale> list = saleDao.storeStatistic(begindate, enddate);
			List<Store> storelist = storeDao.find();
			List<StoreSale> sslist = new ArrayList<StoreSale>();
			for(int i=0;i<storelist.size();i++){
				StoreSale ss = new StoreSale();
				ss.setId(storelist.get(i).getId());
				ss.setName(storelist.get(i).getName());
				ss.setPrice(0);
				sslist.add(ss);
			}
			for(int i=0;i<sslist.size();i++){
				for(int j=0;j<list.size();j++){
					if(sslist.get(i).getId().equals(list.get(j).getId())){
						sslist.get(i).setPrice(list.get(j).getPrice());
						break;
					}
				}
			}
			map.put(month,sslist);
		}
		
		return map;
	}
	
	public List<double[]> channelStatistic(String year){
		double store[] = new double[12];
		double online[] = new double[12];
		for(int i=0;i<12;i++){
			String month = Integer.toString(i+1);
			if(i<9)
				month = "0"+month;
			String begindate = year+"-"+month+"-01";
			String enddate = monthAddition(begindate);
			double storeprice = saleDao.channelStatistic(begindate, enddate, "store");
			double onlineprice = saleDao.channelStatistic(begindate, enddate, "online");
			store[i]=storeprice;
			online[i]=onlineprice;
		}
		List<double[]> list = new ArrayList();
		list.add(store);
		list.add(online);
		
		return list;
		
	}
	
	public Map userLevelStatistic(){
		List<User> userlist = userDao.Find();
		int[] level1 = {0,0,0,0,0};
		int[] level2 = {0,0,0,0,0};
		int[] level3 = {0,0,0,0,0};
		int[] level4 = {0,0,0,0,0};
		
		for(int i=0;i<userlist.size();i++){
			int age = userlist.get(i).getAge();
			int level = userlist.get(i).getLevel();
			
			switch(level){
			case 1:
				if(age<18)
					level1[0]++;
				else if(age<25)
					level1[1]++;
				else if(age<35)
					level1[2]++;
				else if(age<50)
					level1[3]++;
				else
					level1[4]++;
				break;
			case 2:
				if(age<18)
					level2[0]++;
				else if(age<25)
					level2[1]++;
				else if(age<35)
					level2[2]++;
				else if(age<50)
					level2[3]++;
				else
					level2[4]++;
				break;
			case 3:
				if(age<18)
					level3[0]++;
				else if(age<25)
					level3[1]++;
				else if(age<35)
					level3[2]++;
				else if(age<50)
					level3[3]++;
				else
					level3[4]++;
				break;
			case 4:
				if(age<18)
					level4[0]++;
				else if(age<25)
					level4[1]++;
				else if(age<35)
					level4[2]++;
				else if(age<50)
					level4[3]++;
				else
					level4[4]++;
				break;
			}
		}
		
		Map<String, int[]> map = new HashMap<String, int[]>();
		map.put("level1", level1);
		map.put("level2", level2);
		map.put("level3", level3);
		map.put("level4", level4);
		return map;
	}
	
	public Map userStatistic(){
		List<User> userlist = userDao.Find();
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
		
		return map;
	}
	
	private List<PlanCommodity> salePriceStatistic(String store,String timetype){
		DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String day = df2.format(today);
		
		String begindate="";
		String enddate=day;
		
		if(timetype.equals("year")){
			begindate = day.split("-")[0]+"-01-01";
		}
		else if(timetype.equals("season")){
			int month = Integer.parseInt(day.split("-")[1]);
			if(month<=3)
				begindate = day.split("-")[0]+"-01-01";
			else if(month<=6)
				begindate = day.split("-")[0]+"-04-01";
			else if(month<=9)
				begindate = day.split("-")[0]+"-07-01";
			else 
				begindate = day.split("-")[0]+"-10-01";
		}
		else
			begindate = day.substring(0, 8)+"01";
		ArrayList<PlanCommodity> list = new ArrayList();
		if(store.equals("all"))
			list = (ArrayList<PlanCommodity>) saleDao.PriceStatistic(begindate,enddate);
		else
			list = (ArrayList<PlanCommodity>) saleDao.PriceStatistic(store,begindate,enddate);
		List<Commodity> comlist = commodityDao.find();
		ArrayList<PlanCommodity> pclist = new ArrayList();
		for(int j=0;j<comlist.size();j++){
			PlanCommodity pc = new PlanCommodity();
			pc.setId(comlist.get(j).getId());
			pc.setName(comlist.get(j).getName());
			pc.setPrice(0);
			pc.setNum(0);
			pclist.add(pc);
		}
		for(int i=0;i<pclist.size();i++){
			for(int j=0;j<list.size();j++){
				if(pclist.get(i).getId().equals(list.get(j).getId()))
					pclist.get(i).setPrice(list.get(j).getPrice());
			}
		}
		return pclist;
		
	}
	
	private String monthSubtraction(String date){
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1]);
		String newdate="";
		if(month==1){
			month=12;
			year=year-1;
		}
		else
			month = month-1;
		
		if(month<10)
			newdate = Integer.toString(year)+"-0"+Integer.toString(month);
		else
			newdate = Integer.toString(year)+"-"+Integer.toString(month);
		
		return newdate;
	}

	private String monthAddition(String date){
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1]);
		String newdate="";
		if(month==12){
			month=1;
			year=year+1;
		}
		else
			month = month+1;
		
		if(month<10)
			newdate = Integer.toString(year)+"-0"+Integer.toString(month);
		else
			newdate = Integer.toString(year)+"-"+Integer.toString(month);
		
		return newdate;
	}

}
