package desserthouse.logic.impl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import desserthouse.dao.ChargeDao;
import desserthouse.dao.CommodityDao;
import desserthouse.dao.SaleDao;
import desserthouse.dao.UserDao;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.UserManager;
import desserthouse.model.Charge;
import desserthouse.model.Commodity;
import desserthouse.model.Order;
import desserthouse.model.PlanCommodity;
import desserthouse.model.User;

public class UserManagerImpl implements UserManager{
	DaoFactory factory = new DaoFactory();
	UserDao userDao = factory.getUserDao();
	ChargeDao chargeDao = factory.getChargeDao();
	SaleDao saleDao = factory.getSaleDao();
	CommodityDao commodityDao = factory.getCommodityDao();
	
	public boolean addUser(User user) {
		return userDao.Add(user);
	}
	
	public boolean updateUser(User user){
		return userDao.Update(user);
	}
	
	public String login(String id,String password){
		List<User> list = userDao.Find(id);
		if(list.isEmpty())
			return "nouser";
		else{
			User userinfo = list.get(0);
			if(!password.equals(userinfo.getPassword()))
				return "wrong";
			else{
				String state;
				try {
					state = checkState(userinfo).toString();
					return state;
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return "wrong";
				}
			}
		}
	}
	
	public User.UserState checkState(User user) throws ParseException{
		User.UserState state = user.getState();
		if(state==User.UserState.active || state==User.UserState.paused){
			DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			Date validday = df.parse(user.getDate());
			Date today = new Date();
			if(today.getTime()>=validday.getTime()){
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(today);
				calendar.add(Calendar.YEAR, 1);//��һ��
				validday = calendar.getTime();
				if(user.getBalance()<10.0){
					if(state==User.UserState.paused)
						user.setState("stopped");
					else{
						user.setState("paused");
						user.setDate(df.format(validday));
					}
				}
				else{
					user.setState("active");
					user.setDate(df.format(validday));
				}
				updateUser(user);
			}
		}
		
		return user.getState();
		
	}
	

	public String getUserNum() {
		String userNum = RandomID();
		List list = userDao.Find(userNum);
		while(!list.isEmpty()){
			userNum = RandomID();
			list = userDao.Find(userNum);
		}
		return userNum;
	}
	
	public String RandomID(){
		StringBuffer letterbuffer = new StringBuffer("ABCDEFGHIJKLMNOPQRSTUVWXYZ");   
        StringBuffer numbuffer = new StringBuffer("0123456789");
		StringBuffer sb = new StringBuffer();   
        Random random = new Random();   
        int range1 = letterbuffer.length();   
        int range2 = numbuffer.length();
        for (int i = 0; i < 3; i ++) {   
            sb.append(letterbuffer.charAt(random.nextInt(range1)));   
        }
        for (int i = 0; i < 4; i ++) {   
            sb.append(numbuffer.charAt(random.nextInt(range2)));   
        }
        
        return sb.toString();
	}

	public List<User> find(String id) {
		List list = userDao.Find(id);
		return list;
	}

	public List<Charge> getChargeRecord(String id) {
		List list = chargeDao.find(id);
		return list;
	}

	public boolean charge(User user, double money) {
		DateFormat df1=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String date = df1.format(now);
		double balance = user.getBalance()+money;
		int charge = (int) (user.getCharge()+money);
		boolean result=chargeDao.add(user.getId(), date, money, balance);
		if(result){
			if(user.getState()==User.UserState.inactive||user.getState()==User.UserState.paused){
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(now);
				calendar.add(Calendar.YEAR, 1);
				Date validday = calendar.getTime();
				user.setState("active");
				user.setDate(df.format(validday));
			}
			user.setBalance(balance);
			user.setCharge(charge);
			user.setLevel();
			result = updateUser(user);
		}
		return result;
	}
	
	public List<Order> getOrder(String userid) {
		List<Order> list = saleDao.findByUser(userid);
		for(int i=0;i<list.size();i++){
			ArrayList<PlanCommodity> pclist = (ArrayList<PlanCommodity>) saleDao.findById(list.get(i).getId());
			for(int j=0;j<pclist.size();j++){
				Commodity c = commodityDao.find(pclist.get(j).getId());
				pclist.get(j).setName(c.getName());
			}
			list.get(i).setCommodity(pclist);
		}
		
		return list;
	}

	@Override
	public List<User> find() {
		List list = userDao.Find();
		return list;
	}

}
