package desserthouse.logic;

import java.util.List;

import desserthouse.model.Plan;
import desserthouse.model.PlanCommodity;

public interface PlanManager {
	public List<Plan> GetAllPlan();//获得所有销售计划
	public List<Plan> GetPlan(String id);//根据计划id获得销售计划
	public List<Plan> GetUncheckedPlan();//获得所有未审批计划
	public String GetNewId();//自动生成计划id
	public boolean Add(Plan plan);//增加销售计划
	public boolean Update(Plan plan);//修改销售计划
	public boolean Approve(Plan plan);//通过销售计划
	
	public Plan getNullPlan();
}
