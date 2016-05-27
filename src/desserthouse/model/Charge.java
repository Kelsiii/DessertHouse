package desserthouse.model;

public class Charge {
	String userid;
	String date;
	double sum;
	double balance;
	
	public void setUser(String s){
		this.userid = s;
	}
	public String getUser(){
		return this.userid;
	}
	public void setDate(String s){
		this.date = s;
	}
	public String getDate(){
		return this.date;
	}
	public void setBalance(double i){
		this.balance = i;
	}
	public double getBalance(){
		return this.balance;
	}
	public void setSum(double i){
		this.sum = i;
	}
	public double getSum(){
		return this.sum;
	}
}
