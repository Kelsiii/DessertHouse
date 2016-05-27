package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.DaoHelper;
import desserthouse.dao.PlanDao;
import desserthouse.model.Plan;
import desserthouse.model.PlanCommodity;

public class PlanDaoImpl implements PlanDao{
	public static PlanDaoImpl planDao = new PlanDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static PlanDaoImpl getInstance(){
		return planDao;
	}

	
	public List find() {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Plan> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select plan_id,store_id,date,create_date,state from plan group by plan_id");
			result=stmt.executeQuery();
			while(result.next()){
				Plan plan = new Plan();
				plan.setId(result.getString("plan_id"));
				plan.setStore(result.getString("store_id"));
				plan.setDate(result.getString("date"));
				plan.setCreateDate(result.getString("create_date"));
				plan.setState(result.getString("state"));
				list.add(plan);
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


	public List findPlanCommodity(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select * from plan where plan_id=?");
			stmt.setString(1,id);
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity plan = new PlanCommodity();
				plan.setId(result.getString("commodity_id"));
				plan.setPrice(result.getDouble("commodity_price"));
				plan.setNum(result.getInt("commodity_num"));
				list.add(plan);
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


	public List find(String store, String date) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Plan> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select plan_id,store_id,date,create_date,state from plan where store_id=? and date=? group by plan_id");
			stmt.setString(1,store);
			stmt.setString(2, date);
			result=stmt.executeQuery();
			while(result.next()){
				Plan plan = new Plan();
				plan.setId(result.getString("plan_id"));
				plan.setStore(result.getString("store_id"));
				plan.setDate(result.getString("date"));
				plan.setCreateDate(result.getString("create_date"));
				plan.setState(result.getString("state"));
				list.add(plan);
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

	public List findByState(String state) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Plan> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select plan_id,store_id,date,create_date,state from plan where state=? group by plan_id");
			stmt.setString(1,state);
			result=stmt.executeQuery();
			while(result.next()){
				Plan plan = new Plan();
				plan.setId(result.getString("plan_id"));
				plan.setStore(result.getString("store_id"));
				plan.setDate(result.getString("date"));
				plan.setCreateDate(result.getString("create_date"));
				plan.setState(result.getString("state"));
				list.add(plan);
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

	@Override
	public List find(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Plan> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select plan_id,store_id,date,create_date,state from plan where plan_id=? group by plan_id");
			stmt.setString(1,id);
			result=stmt.executeQuery();
			while(result.next()){
				Plan plan = new Plan();
				plan.setId(result.getString("plan_id"));
				plan.setStore(result.getString("store_id"));
				plan.setDate(result.getString("date"));
				plan.setCreateDate(result.getString("create_date"));
				plan.setState(result.getString("state"));
				list.add(plan);
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

	@Override
	public List findByCreateDate(String date) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Plan> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select plan_id,store_id,date,create_date,state from plan where create_date=? group by plan_id");
			stmt.setString(1,date);
			result=stmt.executeQuery();
			while(result.next()){
				Plan plan = new Plan();
				plan.setId(result.getString("plan_id"));
				plan.setStore(result.getString("store_id"));
				plan.setDate(result.getString("date"));
				plan.setCreateDate(result.getString("create_date"));
				plan.setState(result.getString("state"));
				list.add(plan);
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

	@Override
	public boolean add(String id, String store, String date, String create, String state, String commodity,
			double price, int num) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("insert into plan(plan_id,store_id,date,create_date,state,commodity_id,commodity_price,commodity_num) values(?,?,?,?,?,?,?,?)");
			stmt.setString(1,id);
			stmt.setString(2,store);
			stmt.setString(3,date);
			stmt.setString(4,create);
			stmt.setString(5,state);
			stmt.setString(6, commodity);
			stmt.setDouble(7,price);
			stmt.setInt(8,num);
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
	public boolean delete(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("delete from plan where plan_id=?");
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
