package desserthouse.model;

import java.util.ArrayList;

public class Cart {
	ArrayList<PlanCommodity> commodityList;
	double total;
	
	public void init(){
		commodityList = new ArrayList<PlanCommodity>();
		total = 0.0;
	}
	
	public void setTotal(double d){
		this.total = d;
	}
	public double getTotal(){
		return this.total;
	}
	public void setList(ArrayList list){
		this.commodityList = list;
	}
	public ArrayList getList(){
		return this.commodityList;
	}
	
	public void add(Commodity commodity){
		boolean find = false;
		for(int i=0;i<commodityList.size();i++){
			if(commodityList.get(i).getId().equals(commodity.getId())){
				int n = commodityList.get(i).getNum();
				commodityList.get(i).setNum(n+1);
				find = true;
			}
		}
		if(!find){
			PlanCommodity pc = new PlanCommodity();
			pc.setId(commodity.getId());
			pc.setPrice(commodity.getPrice());
			pc.setNum(1);
			pc.setName(commodity.getName());
			commodityList.add(pc);
		}
		total = total+commodity.getPrice();
		
	}
	
	public void min(Commodity commodity){
		for(int i=0;i<commodityList.size();i++){
			if(commodityList.get(i).getId().equals(commodity.getId())){
				int n = commodityList.get(i).getNum();
				commodityList.get(i).setNum(n-1);
			}
		}
		total = total-commodity.getPrice();
	}
	
	public void delete(Commodity commodity){
		total = 0.0;
		for(int i=0;i<commodityList.size();i++){
			if(commodityList.get(i).getId().equals(commodity.getId())){
				commodityList.remove(i);
			}
		}
		for(int i=0;i<commodityList.size();i++){
			total = total+ commodityList.get(i).getPrice()*commodityList.get(i).getNum();
		}
	}
}
