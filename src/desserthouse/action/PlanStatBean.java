package desserthouse.action;

import java.io.Serializable;
import java.util.List;

import desserthouse.model.Plan;

public class PlanStatBean  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Plan plan;

	
	public Plan getStatPlan() {
		return plan;
	}

	
	public void setPlan(Plan plan) {
		this.plan = plan;
	}
	
	
	public Plan getPlan() {
		return plan;
	}

	
}
