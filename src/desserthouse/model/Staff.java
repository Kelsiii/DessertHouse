package desserthouse.model;

public class Staff {
	String id;
	String password;
	String name;
	String tel;
	String sex;
	int age;
	String position;
	String storeId;
	
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
	public void setSex(String s){
		this.sex = s;
	}
	public String getSex(){
		return this.sex;
	}
	public void setStoreId(String s){
		this.storeId = s;
	}
	public String getStoreId(){
		return this.storeId;
	}
	public void setPosition(String s){
		this.position = s;
	}
	public String getPosition(){
		return this.position;
	}
}
