package desserthouse.model;

import java.util.ArrayList;

public class Stock {
	String store;
	String date;
	ArrayList<PlanCommodity> commodity = new ArrayList();
	
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
	public void setCommodity(ArrayList list){
		this.commodity = list;
	}
	public ArrayList<PlanCommodity> getCommodity(){
		return this.commodity;
	}
}
