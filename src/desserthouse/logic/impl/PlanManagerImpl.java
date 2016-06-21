package desserthouse.logic.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import desserthouse.dao.CommodityDao;
import desserthouse.dao.PlanDao;
import desserthouse.dao.StockDao;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.PlanManager;
import desserthouse.model.Commodity;
import desserthouse.model.Plan;
import desserthouse.model.PlanCommodity;

public class PlanManagerImpl implements PlanManager{
	DaoFactory factory = new DaoFactory();
	PlanDao planDao = factory.getPlanDao();
	CommodityDao commodityDao = factory.getCommodityDao();
	StockDao stockDao = factory.getStockDao();
	public List<Plan> GetAllPlan() {
		ArrayList<Plan> list = new ArrayList<Plan>();
		list = (ArrayList<Plan>) planDao.find();
		for(int i=0;i<list.size();i++){
			list.get(i).initCommodity();
			ArrayList<PlanCommodity> pcomlist = (ArrayList<PlanCommodity>) planDao.findPlanCommodity(list.get(i).getId());
			for(int j=0;j<pcomlist.size();j++){
				for(int k=0;k<list.get(i).getCommodity().size();k++){
					
					if(((PlanCommodity) list.get(i).getCommodity().get(k)).getId().equals(pcomlist.get(j).getId())){
						((PlanCommodity) list.get(i).getCommodity().get(k)).setNum(pcomlist.get(j).getNum());
						((PlanCommodity) list.get(i).getCommodity().get(k)).setPrice(pcomlist.get(j).getPrice());
					}
				}
			}
		}
		return list;
	}
	
	public List<Plan> GetPlan(String id) {
		ArrayList<Plan> list = new ArrayList<Plan>();
		list = (ArrayList<Plan>) planDao.find(id);
		for(int i=0;i<list.size();i++){
			list.get(i).initCommodity();
			ArrayList<PlanCommodity> pcomlist = (ArrayList<PlanCommodity>) planDao.findPlanCommodity(list.get(i).getId());
			for(int j=0;j<pcomlist.size();j++){
				for(int k=0;k<list.get(i).getCommodity().size();k++){
					
					if(((PlanCommodity) list.get(i).getCommodity().get(k)).getId().equals(pcomlist.get(j).getId())){
						((PlanCommodity) list.get(i).getCommodity().get(k)).setNum(pcomlist.get(j).getNum());
						((PlanCommodity) list.get(i).getCommodity().get(k)).setPrice(pcomlist.get(j).getPrice());
					}
				}
			}
		}
		return list;
	}
	
	public List<Plan> GetUncheckedPlan() {
		ArrayList<Plan> list = new ArrayList<Plan>();
		list = (ArrayList<Plan>) planDao.findByState("unchecked");
		for(int i=0;i<list.size();i++){
			list.get(i).initCommodity();
			ArrayList<PlanCommodity> pcomlist = (ArrayList<PlanCommodity>) planDao.findPlanCommodity(list.get(i).getId());
			for(int j=0;j<pcomlist.size();j++){
				for(int k=0;k<list.get(i).getCommodity().size();k++){
					
					if(((PlanCommodity) list.get(i).getCommodity().get(k)).getId().equals(pcomlist.get(j).getId())){
						((PlanCommodity) list.get(i).getCommodity().get(k)).setNum(pcomlist.get(j).getNum());
						((PlanCommodity) list.get(i).getCommodity().get(k)).setPrice(pcomlist.get(j).getPrice());
					}
				}
			}
		}
		return list;
	}
	
	public String GetNewId() {
		DateFormat df=new SimpleDateFormat("yyyyMMdd");
		Date today = new Date();
		String s = df.format(today);
		DateFormat df2=new SimpleDateFormat("yyyy-MM-dd");
		List list = planDao.findByCreateDate(df2.format(today));
		int num = list.size()+1;
		String str = String.format("%03d", num);
		return s+str;
	}
	
	public boolean Add(Plan plan) {
		List list = planDao.find(plan.getStore(), plan.getDate());
		if(list.isEmpty()){
			for(int i=0;i<plan.getCommodity().size();i++){
				if(plan.getCommodity().get(i).getNum()!=0)
					planDao.add(plan.getId(), plan.getStore(), plan.getDate(), plan.getCreateDate(),
						plan.getState(), plan.getCommodity().get(i).getId(),
						plan.getCommodity().get(i).getPrice(), plan.getCommodity().get(i).getNum());
			}
			return true;
		}
		else
			return false;
	}

	public boolean Update(Plan plan) {
		planDao.delete(plan.getId());
		return Add(plan);
	}

	@Override
	public boolean Approve(Plan plan) {
		for(int i=0;i<plan.getCommodity().size();i++){
			stockDao.add(plan.getStore(), plan.getDate(),
					plan.getCommodity().get(i).getId(),
					plan.getCommodity().get(i).getPrice(),
					plan.getCommodity().get(i).getNum());
		}
		return true;
	}

	@Override
	public Plan getNullPlan() {
		Plan plan = new Plan();
        plan.initCommodity();
		return plan;
	}

	
}
