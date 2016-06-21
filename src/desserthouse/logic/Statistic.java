package desserthouse.logic;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import desserthouse.model.PlanCommodity;
import desserthouse.model.StaffSale;
import desserthouse.model.Store;

public interface Statistic {
	public List<PlanCommodity> planStatistic(String store,String date);
	
	public List<PlanCommodity> saleStatistic(String store,String timetype);

	public Map commodityStatByType(String store,String timetype);
	
	public List<StaffSale> staffStatistic(String timetype);
	
	public Map storeStatistic(String year);
	
	public List<double[]> channelStatistic(String year);
	
	public Map userLevelStatistic();
	
	public Map userStatistic();
}
