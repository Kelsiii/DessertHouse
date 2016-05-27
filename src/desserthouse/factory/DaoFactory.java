package desserthouse.factory;

import desserthouse.dao.ChargeDao;
import desserthouse.dao.CommodityDao;
import desserthouse.dao.PlanDao;
import desserthouse.dao.SaleDao;
import desserthouse.dao.StaffDao;
import desserthouse.dao.StockDao;
import desserthouse.dao.StoreDao;
import desserthouse.dao.UserDao;
import desserthouse.dao.impl.ChargeDaoImpl;
import desserthouse.dao.impl.CommodityDaoImpl;
import desserthouse.dao.impl.PlanDaoImpl;
import desserthouse.dao.impl.SaleDaoImpl;
import desserthouse.dao.impl.StaffDaoImpl;
import desserthouse.dao.impl.StockDaoImpl;
import desserthouse.dao.impl.StoreDaoImpl;
import desserthouse.dao.impl.UserDaoImpl;

public class DaoFactory {
	public static UserDao getUserDao(){
		return UserDaoImpl.getInstance();
	}
	public static StaffDao getStaffDao(){
		return StaffDaoImpl.getInstance();
	}
	public static StoreDao getStoreDao(){
		return StoreDaoImpl.getInstance();
	}
	public static PlanDao getPlanDao(){
		return PlanDaoImpl.getInstance();
	}
	public static CommodityDao getCommodityDao(){
		return CommodityDaoImpl.getInstance();
	}
	public static StockDao getStockDao(){
		return StockDaoImpl.getInstance();
	}
	public static SaleDao getSaleDao(){
		return SaleDaoImpl.getInstance();
	}
	public static ChargeDao getChargeDao(){
		return ChargeDaoImpl.getInstance();
	}
}
