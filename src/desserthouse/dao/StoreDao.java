package desserthouse.dao;

import java.util.List;

import desserthouse.model.Store;

public interface StoreDao {
	public List<Store> find();
	public List<Store> find(String id);
	public boolean Add(Store store);
	public boolean Update(Store store);
	public boolean Delete(String id);
}
