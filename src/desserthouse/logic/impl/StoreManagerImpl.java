package desserthouse.logic.impl;

import java.util.ArrayList;
import java.util.List;

import desserthouse.dao.StoreDao;
import desserthouse.factory.DaoFactory;
import desserthouse.logic.StoreManager;
import desserthouse.model.Store;

public class StoreManagerImpl implements StoreManager{
	DaoFactory factory = new DaoFactory();
	StoreDao storeDao = factory.getStoreDao();
	
	public List GetStoreList() {
		List<Store> list = storeDao.find();
		return list;
	}

	
	public Store GetStore(String id) {
		List list = storeDao.find(id);
		if(list.isEmpty())
			return null;
		else{
			Store store = storeDao.find(id).get(0);
			return store;
		}
	}


	@Override
	public boolean add(Store store) {
		return storeDao.Add(store);
	}


	@Override
	public boolean update(Store store) {
		// TODO Auto-generated method stub
		return storeDao.Update(store);
	}


	@Override
	public boolean delete(String id) {
		return storeDao.Delete(id);
	}

}
