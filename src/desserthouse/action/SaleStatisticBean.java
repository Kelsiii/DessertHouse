package desserthouse.action;

import java.io.Serializable;
import java.util.List;

import desserthouse.model.Commodity;
import desserthouse.model.PlanCommodity;

public class SaleStatisticBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List commodityList;

	
	public List getCommodityList() {
		return commodityList;
	}

	
	public void setCommodityList(List commodityList) {
		this.commodityList = commodityList;
	}
	
	
	public void setCommodityList(PlanCommodity commodity, int index) {
		commodityList.set(index, commodity);
	}
	
	public PlanCommodity getcommodity(int index) {
		return (PlanCommodity) commodityList.get(index);
	}

	
}
