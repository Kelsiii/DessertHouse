package desserthouse.logic;

import java.util.List;

import desserthouse.model.Staff;

public interface StaffManager {
	public String login(String id, String password);//管理人员登录
	public List GetStaffList();//获得员工列表
	public boolean add(Staff staff);//新增员工
	public boolean update(Staff staff);//修改员工信息
	public boolean delete(String id);//删除员工
	public List find(String id);//根据员工编号获取员工信息
}
