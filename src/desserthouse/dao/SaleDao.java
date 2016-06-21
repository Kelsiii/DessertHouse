package desserthouse.dao;

import java.util.ArrayList;
import java.util.List;

import desserthouse.model.PlanCommodity;
import desserthouse.model.StaffSale;
import desserthouse.model.StoreSale;

public interface SaleDao {
	public boolean add(String id,String date,String store,String commodity,int num,double price,String type,String state,String user,String create,String address);
	public boolean update(String id,String state);
	public List findByCreateDate(String day);
	public List findById(String id);
	public List findTodayByStore(String store,String state,String day);
	public List findByUser(String userid);
	public List Statistic();
	public List Statistic(String storeid, String begindate, String enddate);
	public List Statistic(String begindate,String enddate);
	public List PriceStatistic(String begindate, String enddate);
	public List PriceStatistic(String store, String begindate, String enddate);
	public double channelStatistic(String begindate,String enddate,String type);
	public List<StoreSale> storeStatistic(String begindate,String enddate);
	public List<StaffSale> staffStatistic(String begindate,String enddate);
}
