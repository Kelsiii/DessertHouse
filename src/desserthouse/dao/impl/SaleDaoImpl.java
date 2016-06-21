package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.DaoHelper;
import desserthouse.dao.SaleDao;
import desserthouse.model.Order;
import desserthouse.model.Plan;
import desserthouse.model.PlanCommodity;
import desserthouse.model.StaffSale;
import desserthouse.model.StoreSale;

public class SaleDaoImpl implements SaleDao{
	public static SaleDaoImpl saleDao = new SaleDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static SaleDaoImpl getInstance(){
		return saleDao;
	}
	public boolean add(String id, String date, String store, String commodity, int num, double price, String type,
			String state, String user, String create, String address) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("insert into sale(sale_id,store_id,date,commodity_id,price,num,sale_type,state,user_id,create_date,address) values(?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setString(1,id);
			stmt.setString(2,store);
			stmt.setString(3,date);
			stmt.setString(4, commodity);
			stmt.setDouble(5,price);
			stmt.setInt(6,num);
			stmt.setString(7,type);
			stmt.setString(8,state);
			stmt.setString(9,user);
			stmt.setString(10,create);
			stmt.setString(11, address);
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
	public List findByCreateDate(String day) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Order> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select sale_id,store_id,date,create_date,state,sale_type,user_id from sale where create_date=? group by sale_id");
			stmt.setString(1,day);
			result=stmt.executeQuery();
			while(result.next()){
				Order order = new Order();
				order.setId(result.getString("sale_id"));
				order.setStore(result.getString("store_id"));
				order.setDate(result.getString("date"));
				order.setCreateDate(result.getString("create_date"));
				order.setState(result.getString("state"));
				order.setType(result.getString("sale_type"));
				order.setUser(result.getString("user_id"));
				list.add(order);
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
	public List<PlanCommodity> findById(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select * from sale where sale_id=?");
			stmt.setString(1,id);
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setNum(result.getInt("num"));
				pc.setPrice(result.getDouble("price"));
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
	@Override
	public List findTodayByStore(String store, String state, String day) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Order> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select sale_id,store_id,date,create_date,state,sale_type,user_id from sale where store_id=? and state=? and date=? group by sale_id");
			stmt.setString(1,store);
			stmt.setString(2, state);
			stmt.setString(3, day);
			result=stmt.executeQuery();
			while(result.next()){
				Order order = new Order();
				order.setId(result.getString("sale_id"));
				order.setStore(result.getString("store_id"));
				order.setDate(result.getString("date"));
				order.setCreateDate(result.getString("create_date"));
				order.setState(result.getString("state"));
				order.setType(result.getString("sale_type"));
				order.setUser(result.getString("user_id"));
				list.add(order);
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
	public boolean update(String id, String state) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		
		try {	
			stmt=con.prepareStatement("update sale set state=? where sale_id=?");
			stmt.setString(1, state);
			stmt.setString(2, id);
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
	@Override
	public List findByUser(String userid) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Order> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select sale_id,store_id,date,create_date,state,sale_type,user_id from sale where user_id=? group by sale_id");
			stmt.setString(1,userid);
			result=stmt.executeQuery();
			while(result.next()){
				Order order = new Order();
				order.setId(result.getString("sale_id"));
				order.setStore(result.getString("store_id"));
				order.setDate(result.getString("date"));
				order.setCreateDate(result.getString("create_date"));
				order.setState(result.getString("state"));
				order.setType(result.getString("sale_type"));
				order.setUser(result.getString("user_id"));
				list.add(order);
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
	public List Statistic() {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select commodity_id, count(commodity_id) as sumnum from sale group by commodity_id");
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setNum(result.getInt("sumnum"));
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
	
	public List Statistic(String begindate,String enddate) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select commodity_id, count(commodity_id) as sumnum from sale"
					+ " where date>='"+begindate+"' and date<'"+enddate
					+ "' group by commodity_id;");
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setNum(result.getInt("sumnum"));
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
	@Override
	public List<PlanCommodity> Statistic(String storeid,String begindate,String enddate) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select commodity_id, count(commodity_id) as sumnum from sale"
					+ " where date>='"+begindate+"' and date<'"+enddate+"' and store_id='"+storeid+"' "
					+ "group by commodity_id;");
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setNum(result.getInt("sumnum"));
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

	public List<PlanCommodity> PriceStatistic(String storeid,String begindate,String enddate) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select commodity_id, coalesce(sum(price),0) as sumnum from sale"
					+ " where date>='"+begindate+"' and date<'"+enddate+"' and store_id='"+storeid+"' "
					+ "group by commodity_id;");
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setPrice(result.getDouble("sumnum"));
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
	@Override
	public List PriceStatistic(String begindate, String enddate) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<PlanCommodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select commodity_id, coalesce(sum(price),0) as sumnum from sale"
					+ " where date>='"+begindate+"' and date<'"+enddate
					+ "' group by commodity_id;");
			result=stmt.executeQuery();
			while(result.next()){
				PlanCommodity pc = new PlanCommodity();
				pc.setId(result.getString("commodity_id"));
				pc.setPrice(result.getDouble("sumnum"));
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

	public double channelStatistic(String begindate,String enddate,String type){
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		double num=0;
		try 
		{
			stmt=con.prepareStatement("select sum(price) as num from sale where date>='"+begindate+"' and date<'"+enddate+"' and sale_type='"+type+"';");
			result=stmt.executeQuery();
			while(result.next()){
				num = result.getDouble("num");
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
		return num;
	}
	
	public List<StoreSale> storeStatistic(String begindate,String enddate){
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<StoreSale> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select sum(price) as sum,store_id from sale where date>='"+begindate+"' and date<'"+enddate+"' group by store_id;");
			result=stmt.executeQuery();
			while(result.next()){
				StoreSale ss = new StoreSale();
				ss.setId(result.getString("store_id"));
				ss.setPrice(result.getDouble("sum"));
				list.add(ss);
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
	
	public List<StaffSale> staffStatistic(String begindate,String enddate){
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<StaffSale> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select count(*) as sum,p.saler_id from (select saler_id,sale_id from sale where date>='"+begindate+"' and date<'"+enddate+"' group by sale_id) p group by p.saler_id");
			result=stmt.executeQuery();
			while(result.next()){
				StaffSale ss = new StaffSale();
				ss.setId(result.getString("saler_id"));
				ss.setNum(result.getInt("sum"));
				list.add(ss);
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
