package desserthouse.dao;

import java.util.List;

import desserthouse.model.Commodity;

public interface CommodityDao {
	public List find();
	public Commodity find(String id);
}
