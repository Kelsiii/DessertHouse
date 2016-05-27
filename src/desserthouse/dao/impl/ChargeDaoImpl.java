package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.ChargeDao;
import desserthouse.dao.DaoHelper;
import desserthouse.model.Charge;
import desserthouse.model.PlanCommodity;

public class ChargeDaoImpl implements ChargeDao{
	public static ChargeDaoImpl chargeDao = new ChargeDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static ChargeDaoImpl getInstance(){
		return chargeDao;
	}
	
	public List find(String userid) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Charge> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select * from charge where userid=? order by date desc");
			stmt.setString(1,userid);
			result=stmt.executeQuery();
			while(result.next()){
				Charge charge = new Charge();
				charge.setUser(userid);
				charge.setDate(result.getString("date"));
				charge.setSum(result.getDouble("money"));
				charge.setBalance(result.getDouble("balance"));
				list.add(charge);
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

	public boolean add(String userid, String date, double sum, double balance) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		try 
		{
			stmt=con.prepareStatement("insert into charge(userid,date,money,balance) values(?,?,?,?)");
			
			stmt.setString(1,userid);
			stmt.setString(2,date);
			stmt.setDouble(3, sum);
			stmt.setDouble(4,balance);
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
