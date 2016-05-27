package desserthouse.model;


public class User {
	public enum UserState {
        inactive, active, paused, stopped;
    }
	String id;
	int age;
	String password;
	String tel;
	String address;
	String card;
	double balance;
	int level;
	int point;
	String date;
	UserState state;
	int charge;
	
	public void init(){
		this.balance = 0.0;
		this.level = 1;
		this.point = 0;
		this.state = UserState.inactive;
	}
	
	public void setId(String s){
		this.id = s;
	}
	public String getId(){
		return this.id;
	}
	
	public void setAge(int a){
		this.age = a;
	}
	public int getAge(){
		return this.age;
	}
	
	public void setPassword(String s){
		this.password = s;
	}
	public String getPassword(){
		return this.password;
	}

	public void setTel(String s){
		this.tel = s;
	}
	public String getTel(){
		return this.tel;
	}

	public void setCard(String s){
		this.card = s;
	}
	public String getCard(){
		return this.card;
	}

	public void setAddress(String s){
		this.address = s;
	}
	public String getAddress(){
		return this.address;
	}

	public void setBalance(double i){
		this.balance = i;
	}
	public double getBalance(){
		return this.balance;
	}

	public void setLevel(int i){
		this.level = i;
	}
	public int getLevel(){
		return this.level;
	}

	public void setPoint(int i){
		this.point = i;
	}
	public int getPoint(){
		return this.point;
	}

	public void setDate(String s){
		this.date = s;
	}
	public String getDate(){
		return this.date;
	}

	public void setState(String s){
		if(s.equals("active"))
			this.state = UserState.active;
		if(s.equals("inactive"))
			this.state = UserState.inactive;
		if(s.equals("paused"))
			this.state = UserState.paused;
		if(s.equals("stopped"))
			this.state = UserState.stopped;
	}
	public UserState getState(){
		return this.state;
	}
	public void setCharge(int a){
		this.charge = a;
	}
	public int getCharge(){
		return this.charge;
	}
	public void setLevel(){
		if(this.charge<500)
			this.level = 1;
		else if(this.charge<1000)
			this.level = 2;
		else if(this.charge<2000)
			this.level = 3;
		else
			this.level = 4;
	}
}
