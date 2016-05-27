package desserthouse.action;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import desserthouse.model.Staff;


public class StaffListBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List staffList;

	
	public List getStaffList() {
		return staffList;
	}

	
	public void setStaffList(List staffList) {
		this.staffList = staffList;
	}
	
	
	public void setStaffList(Staff staff, int index) {
		staffList.set(index, staff);
	}
	
	public Staff getStaff(int index) {
		return (Staff) staffList.get(index);
	}

	
}
