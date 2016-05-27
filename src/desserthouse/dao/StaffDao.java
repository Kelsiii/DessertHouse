package desserthouse.dao;

import java.util.List;

import desserthouse.model.Staff;

public interface StaffDao {
	public List<Staff> FindById(String id);
	public List<Staff> FindByStore(String storeid);
	public List<Staff> Find();
	public boolean Add(Staff staff);
	public boolean Update(Staff staff);
	public boolean Delete(String id);
}
