package desserthouse.logic;

import java.util.List;

import desserthouse.model.Charge;
import desserthouse.model.Order;
import desserthouse.model.User;

public interface UserManager {
	public boolean addUser(User user);//新增会员
	public boolean updateUser(User user);//修改会员信息
	public String getUserNum();//生成会员编号
	public String login(String id,String password);//会员登录
	public List<User> find(String id);//根据id获得会员信息
	public List<User> find();//获得所有会员列表
	public List<Charge> getChargeRecord(String id);//根据会员id获得该会员所有充值记录
	public boolean charge(User user, double money);//会员账户充值
	public List<Order> getOrder(String userid);//根据会员id获得该会员所有订单记录
}
