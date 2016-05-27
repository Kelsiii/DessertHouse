package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.CommodityDao;
import desserthouse.dao.DaoHelper;
import desserthouse.model.Commodity;

public class CommodityDaoImpl implements CommodityDao{
	public static CommodityDaoImpl commodityDao = new CommodityDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	public static CommodityDaoImpl getInstance(){
		return commodityDao;
	}
	public List find() {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<Commodity> list = new ArrayList();
		try 
		{
			stmt=con.prepareStatement("select* from commodity");
			result=stmt.executeQuery();
			while(result.next()){
				Commodity commodity = new Commodity();
				commodity.setId(result.getString("commodity_id"));
				commodity.setName(result.getString("name"));
				commodity.setType(result.getString("type"));
				commodity.setPrice(result.getDouble("price"));
				list.add(commodity);
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
	public Commodity find(String id) {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		Commodity commodity = new Commodity();
		try 
		{
			stmt=con.prepareStatement("select* from commodity where commodity_id=?");
			stmt.setString(1, id);
			result=stmt.executeQuery();
			while(result.next()){
				commodity.setId(result.getString("commodity_id"));
				commodity.setName(result.getString("name"));
				commodity.setType(result.getString("type"));
				commodity.setPrice(result.getDouble("price"));
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
		return commodity;
	}

}
