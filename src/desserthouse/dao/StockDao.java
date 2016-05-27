package desserthouse.dao;

import java.util.List;

import desserthouse.model.PlanCommodity;

public interface StockDao {
	public boolean add(String store,String date,String commodity,double price,int num);
	public PlanCommodity find(String store,String date,String commodity);
	public List<PlanCommodity> find(String store,String date);
	public boolean update(String store,String date,String commodity,int num);
}
