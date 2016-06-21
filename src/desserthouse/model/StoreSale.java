package desserthouse.model;

public class StoreSale {
	String id;
	String name;
	double price;
	
	public void setId(String s){
		this.id = s;
	}
	public String getId(){
		return this.id;
	}
	public void setPrice(double d){
		this.price = d;
	}
	public double getPrice(){
		return this.price;
	}
	public void setName(String s){
		this.name = s;
	}
	public String getName(){
		return this.name;
	}
}
