package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.DaoHelper;
import desserthouse.dao.StoreDao;
import desserthouse.model.Store;

public class StoreDaoImpl implements StoreDao{
	
	private static StoreDaoImpl storeDao=new StoreDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static StoreDaoImpl getInstance(){
		return storeDao;
	}
	
	public List<Store> find() {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Store> list=new ArrayList<Store>();
		try 
		{
			stmt=con.prepareStatement("select * from store");
			result=stmt.executeQuery();
			while(result.next()){
				Store store = new Store();
				store.setId(result.getString("store_id"));
				store.setAddress(result.getString("address"));
				store.setName(result.getString("name"));
				store.setTel(result.getString("tel"));
				list.add(store);
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

	public boolean Add(Store store) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("insert into store(store_id,tel,address,name) values(?,?,?,?)");
			stmt.setString(1,store.getId());
			stmt.setString(2,store.getTel());
			stmt.setString(3,store.getAddress());
			stmt.setString(4,store.getName());
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

	public boolean Update(Store store) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Store> list=new ArrayList<Store>();
		try 
		{
			stmt=con.prepareStatement("update store set tel=?,address = ?, name=? where store_id=?");
			stmt.setString(4,store.getId());
			stmt.setString(1,store.getTel());
			stmt.setString(2,store.getAddress());
			stmt.setString(3,store.getName());
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

	public boolean Delete(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("delete from store where store_id=?");
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

	@Override
	public List find(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Store> list=new ArrayList<Store>();
		try 
		{
			stmt=con.prepareStatement("select * from store where store_id=?");
			stmt.setString(1,id);
			result=stmt.executeQuery();
			while(result.next()){
				Store store = new Store();
				store.setId(result.getString("store_id"));
				store.setAddress(result.getString("address"));
				store.setName(result.getString("name"));
				store.setTel(result.getString("tel"));
				list.add(store);
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
}
