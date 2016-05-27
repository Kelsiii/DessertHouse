package desserthouse.model;

public class Commodity {
	String id;
	String name;
	double price;
	String type;
	
	public void setId(String s){
		this.id = s;
	}
	public String getId(){
		return this.id;
	}
	public void setName(String s){
		this.name = s;
	}
	public String getName(){
		return this.name;
	}
	public void setType(String s){
		this.type = s;
	}
	public String getType(){
		return this.type;
	}
	public void setPrice(double d){
		this.price = d;
	}
	public double getPrice(){
		return this.price;
	}
}
