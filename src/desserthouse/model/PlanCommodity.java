package desserthouse.model;

public class PlanCommodity {
	String commodity_id;
	double price;
	int num;
	String name="";
	
	public void setId(String s){
		this.commodity_id = s;
	}
	public String getId(){
		return this.commodity_id;
	}
	public void setName(String s){
		this.name = s;
	}
	public String getName(){
		return this.name;
	}
	public void setPrice(double d){
		this.price = d;
	}
	public double getPrice(){
		return this.price;
	}
	public void setNum(int d){
		this.num = d;
	}
	public int getNum(){
		return this.num;
	}
}
