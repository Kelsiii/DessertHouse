package desserthouse.model;

import java.util.ArrayList;

public class Order {
	String id;
	String store;
	String createDate;
	String date;
	String state;
	String type;
	String userid;
	ArrayList<PlanCommodity> commodity = new ArrayList();
	
	public void setId(String s){
		this.id = s;
	}
	public String getId(){
		return this.id;
	}
	public void setStore(String s){
		this.store = s;
	}
	public String getStore(){
		return this.store;
	}
	public void setDate(String s){
		this.date = s;
	}
	public String getDate(){
		return this.date;
	}
	public void setCreateDate(String s){
		this.createDate = s;
	}
	public String getCreateDate(){
		return this.createDate;
	}
	public void setType(String s){
		this.type = s;
	}
	public String getType(){
		return this.type;
	}
	public void setUser(String s){
		this.userid = s;
	}
	public String getUser(){
		return this.userid;
	}
	public void setState(String s){
		this.state = s;
	}
	public String getState(){
		return this.state;
	}
	public void setCommodity(ArrayList list){
		this.commodity = list;
	}
	public ArrayList<PlanCommodity> getCommodity(){
		return this.commodity;
	}
}
