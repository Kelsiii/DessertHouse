package desserthouse.dao;

import java.util.List;

import desserthouse.model.Plan;

public interface PlanDao {
	public List find();
	public List findPlanCommodity(String id);
	public List find(String store, String date);
	public List findByCreateDate(String date);
	public List findByState(String state);
	public List find(String id);
	
	public boolean add(String id,String store,String date,String create,String state,String commodity,double price,int num);
	public boolean delete(String id);
}
