package desserthouse.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.DaoHelper;
import desserthouse.dao.UserDao;
import desserthouse.model.User;

public class UserDaoImpl implements UserDao{
	private static UserDaoImpl userDao=new UserDaoImpl();
	private static DaoHelper daoHelper=DaoHelperImpl.getBaseDaoInstance();
	
	public static UserDaoImpl getInstance(){
		return userDao;
	}
	
	public boolean Add(User user){
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		
		try {	
			stmt=con.prepareStatement("insert into member(member_id,password,age,tel,address,bank_card) values(?,?,?,?,?,?)");
			stmt.setString(1, user.getId());
			stmt.setString(2, user.getPassword());
			stmt.setInt(3, user.getAge());
			stmt.setString(4, user.getTel());
			stmt.setString(5, user.getAddress());
			stmt.setString(6, user.getCard());
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
	
	public boolean Update(User user){
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		
		try {	
			stmt=con.prepareStatement("update member set password=?,age=?,tel=?,address=?,bank_card=?,balance=?,state=?,level=?,points=?,valid_date=?,charge=? where member_id=?");
			stmt.setString(1, user.getPassword());
			stmt.setInt(2, user.getAge());
			stmt.setString(3, user.getTel());
			stmt.setString(4, user.getAddress());
			stmt.setString(5, user.getCard());
			stmt.setDouble(6, user.getBalance());
			stmt.setString(7, user.getState().toString());
			stmt.setInt(8, user.getLevel());
			stmt.setInt(9, user.getPoint());
			stmt.setString(10, user.getDate());
			stmt.setInt(11, user.getCharge());
			stmt.setString(12, user.getId());
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
	
	public List<User> Find(String id){
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<User> list=new ArrayList<User>();
		try 
		{
			stmt=con.prepareStatement("select * from member where member_id=?");
			stmt.setString(1,id);
			result=stmt.executeQuery();
			while(result.next())
			{
				User user = new User();
				user.setId(result.getString("member_id"));
				user.setPassword(result.getString("password"));
				user.setAddress(result.getString("address"));
				user.setAge(result.getInt("age"));
				user.setTel(result.getString("tel"));
				user.setCard(result.getString("bank_card"));
				user.setBalance(result.getDouble("balance"));
				user.setDate(result.getString("valid_date"));
				user.setLevel(result.getInt("level"));
				user.setPoint(result.getInt("points"));
				user.setState(result.getString("state"));
				user.setCharge(result.getInt("charge"));
				list.add(user);
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
	public List<User> Find() {
		Connection con=daoHelper.getConnection();
		PreparedStatement stmt=null;
		ResultSet result=null;
		ArrayList<User> list=new ArrayList<User>();
		try 
		{
			stmt=con.prepareStatement("select * from member");
			result=stmt.executeQuery();
			while(result.next())
			{
				User user = new User();
				user.setId(result.getString("member_id"));
				user.setPassword(result.getString("password"));
				user.setAddress(result.getString("address"));
				user.setAge(result.getInt("age"));
				user.setTel(result.getString("tel"));
				user.setCard(result.getString("bank_card"));
				user.setBalance(result.getDouble("balance"));
				user.setDate(result.getString("valid_date"));
				user.setLevel(result.getInt("level"));
				user.setPoint(result.getInt("points"));
				user.setState(result.getString("state"));
				user.setCharge(result.getInt("charge"));
				list.add(user);
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
