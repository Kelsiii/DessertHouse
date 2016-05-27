package desserthouse.model;

public class Store {
	String id;
	String address;
	String tel;
	String name;
	
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
	public void setAddress(String s){
		this.address = s;
	}
	public String getAddress(){
		return this.address;
	}
	public void setTel(String s){
		this.tel = s;
	}
	public String getTel(){
		return this.tel;
	}
}
