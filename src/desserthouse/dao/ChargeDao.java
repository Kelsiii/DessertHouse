package desserthouse.dao;

import java.util.List;

public interface ChargeDao {
	public List find(String userid);
	public boolean add(String userid,String date,double sum,double balance);
}
