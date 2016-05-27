package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.DaoHelper;
import desserthouse.dao.StockDao;
import desserthouse.model.PlanCommodity;
import desserthouse.model.Staff;

public class StockDaoImpl implements StockDao{
	public static StockDaoImpl stockDao = new StockDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static StockDaoImpl getInstance(){
		return stockDao;
	}
	public boolean add(String store, String date, String commodity, double price, int num) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("insert into stock(store_id,date,commodity_id,price,num) values(?,?,?,?,?)");
			
			stmt.setString(1,store);
			stmt.setString(2,date);
			stmt.setString(3, commodity);
			stmt.setDouble(4,price);
			stmt.setInt(5,num);
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
	public PlanCommodity find(String store, String date, String commodity) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		PlanCommodity pc = new PlanCommodity();
		pc.setNum(-1);
		try 
		{
			stmt=con.prepareStatement("select * from stock where store_id=? and date=? and commodity_id=?");
			stmt.setString(1,store);
			stmt.setString(2, date);
			stmt.setString(3, commodity);
			result=stmt.executeQuery();
			if(result.next()){
				pc.setId(result.getString("commodity_id"));
				pc.setPrice(result.getDouble("price"));
				pc.setNum(result.getInt("num"));
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
		return pc;
	}

	public boolean update(String store, String date, String commodity, int num) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		
		try {	
			stmt=con.prepareStatement("update stock set num=num-? where store_id=? and date=? and commodity_id=?");
			stmt.setInt(1, num);
			stmt.setString(2, store);
			stmt.setString(3, date);
			stmt.setString(4, commodity);
			stmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally{
			daoHelper.closeConnection(con);
			daoHelper.closePreparedStatement(stmt);
			return true;
		}
	}

	public List<PlanCommodity> find(String store, String date) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		
		ArrayList<PlanCommodity> list = new ArrayList<PlanCommodity>();
		try 
		{
			stmt=con.prepareStatement("select * from stock where store_id=? and date=?");
			stmt.setString(1,store);
			stmt.setString(2, date);
			result=stmt.executeQuery();
			if(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setPrice(result.getDouble("price"));
				pc.setNum(result.getInt("num"));
				list.add(pc);
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

}
