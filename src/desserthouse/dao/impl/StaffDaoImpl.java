package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.DaoHelper;
import desserthouse.dao.StaffDao;
import desserthouse.model.Staff;
import desserthouse.model.Store;

public class StaffDaoImpl implements StaffDao{
	private static StaffDaoImpl staffDao=new StaffDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static StaffDaoImpl getInstance(){
		return staffDao;
	}

	public List<Staff> FindById(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Staff> list=new ArrayList<Staff>();
		try 
		{
			stmt=con.prepareStatement("select * from staff where staff_id=?");
			stmt.setString(1,id);
			result=stmt.executeQuery();
			while(result.next()){
				Staff staff = new Staff();
				staff.setId(result.getString("staff_id"));
				staff.setPassword(result.getString("password"));
				staff.setName(result.getString("name"));
				staff.setTel(result.getString("tel"));
				staff.setSex(result.getString("sex"));
				staff.setAge(result.getInt("age"));
				staff.setPosition(result.getString("position"));
				staff.setStoreId(result.getString("store_id"));
				list.add(staff);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			daoHelper.closeConnection(con);
			daoHelper.closePreparedStatement(stmt);
			daoHelper.closeResult(result);
		}
		return list;
	}

	public boolean Add(Staff staff) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("insert into staff(staff_id,password,name,tel,sex,age,store_id,position) values(?,?,?,?,?,?,?,?)");
			stmt.setString(1,staff.getId());
			stmt.setString(2,staff.getPassword());
			stmt.setString(3,staff.getName());
			stmt.setString(4,staff.getTel());
			stmt.setString(5,staff.getSex());
			stmt.setInt(6, staff.getAge());
			stmt.setString(7,staff.getStoreId());
			stmt.setString(8,staff.getPosition());
			stmt.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally
		{
			daoHelper.closeConnection(con);
			daoHelper.closePreparedStatement(stmt);
			daoHelper.closeResult(result);
		}
		return true;
	}

	public boolean Update(Staff staff) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("update staff set password=?,name=?,tel=?,sex=?,age=?,store_id=?,position=? where staff_id=?");
			stmt.setString(8,staff.getId());
			stmt.setString(1,staff.getPassword());
			stmt.setString(2,staff.getName());
			stmt.setString(3,staff.getTel());
			stmt.setString(4,staff.getSex());
			stmt.setInt(5, staff.getAge());
			stmt.setString(6,staff.getStoreId());
			stmt.setString(7,staff.getPosition());
			stmt.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally
		{
			daoHelper.closeConnection(con);
			daoHelper.closePreparedStatement(stmt);
			daoHelper.closeResult(result);
		}
		return true;
	}


	public List<Staff> FindByStore(String storeid) {
		
		return null;
	}

	@Override
	public List<Staff> Find() {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Staff> list=new ArrayList<Staff>();
		try 
		{
			stmt=con.prepareStatement("select * from staff");
			result=stmt.executeQuery();
			while(result.next()){
				Staff staff = new Staff();
				staff.setId(result.getString("staff_id"));
				staff.setPassword(result.getString("password"));
				staff.setName(result.getString("name"));
				staff.setTel(result.getString("tel"));
				staff.setSex(result.getString("sex"));
				staff.setAge(result.getInt("age"));
				staff.setPosition(result.getString("position"));
				staff.setStoreId(result.getString("store_id"));
				list.add(staff);
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			daoHelper.closeConnection(con);
			daoHelper.closePreparedStatement(stmt);
			daoHelper.closeResult(result);
		}
		return list;
	}

	@Override
	public boolean Delete(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("delete from staff where staff_id=?");
			stmt.setString(1,id);
			stmt.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally
		{
			daoHelper.closeConnection(con);
			daoHelper.closePreparedStatement(stmt);
			daoHelper.closeResult(result);
		}
		return true; 
	}
	
	
}
