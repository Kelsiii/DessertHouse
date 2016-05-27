package desserthouse.action;

import java.io.Serializable;
import java.util.List;

import desserthouse.model.Plan;

public class PlanListBean  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List planList;

	
	public List getPlanList() {
		return planList;
	}

	
	public void setPlanList(List planList) {
		this.planList = planList;
	}
	
	
	public void setPlanList(Plan plan, int index) {
		planList.set(index, plan);
	}
	
	public Plan getPlan(int index) {
		return (Plan) planList.get(index);
	}

	
}
