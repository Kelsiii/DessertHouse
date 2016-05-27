package desserthouse.dao;

import java.util.List;

public interface SaleDao {
	public boolean add(String id,String date,String store,String commodity,int num,double price,String type,String state,String user,String create,String address);
	public boolean update(String id,String state);
	public List findByCreateDate(String day);
	public List findById(String id);
	public List findTodayByStore(String store,String state,String day);
	public List findByUser(String userid);
	public List Statistic();
}
