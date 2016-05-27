package desserthouse.logic;

import java.util.List;

import desserthouse.model.Store;

public interface StoreManager {
	public List GetStoreList();//获得所有店铺列表
	public Store GetStore(String id);//根据id获得店铺信息
	public boolean add(Store store);//新增店铺
	public boolean update(Store store);//修改店铺
	public boolean delete(String id);//删除店铺
}
