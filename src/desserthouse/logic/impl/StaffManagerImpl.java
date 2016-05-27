package desserthouse.logic.impl;

import java.util.List;

import desserthouse.dao.StaffDao;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.StaffManager;
import desserthouse.model.Staff;

public class StaffManagerImpl implements StaffManager{
	DaoFactory factory = new DaoFactory();
	StaffDao staffDao = factory.getStaffDao();
	
	public String login(String id, String password) {
		List<Staff> list = staffDao.FindById(id);
		if(list.isEmpty())
			return "nouser";
		else{
			Staff staffinfo = list.get(0);
			if(!password.equals(staffinfo.getPassword()))
				return "wrong";
			else{
				return staffinfo.getPosition();
			}
		}
	}

	public List GetStaffList() {
		List<Staff> list = staffDao.Find();
		for(int i=0;i<list.size();i++){
			String position = list.get(i).getPosition();
			if(position.equals("admin")||position.equals("manager"))
				list.remove(i);
		}
		return list;
	}

	@Override
	public boolean add(Staff staff) {
		return staffDao.Add(staff);
	}

	@Override
	public boolean update(Staff staff) {
		return staffDao.Update(staff);
	}

	@Override
	public boolean delete(String id) {
		return staffDao.Delete(id);
	}

	@Override
	public List find(String id) {
		List<Staff> list = staffDao.FindById(id);
		return list;
	}

}
