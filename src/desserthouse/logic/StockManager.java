package desserthouse.logic;

import java.util.List;

import desserthouse.model.Cart;
import desserthouse.model.Commodity;
import desserthouse.model.PlanCommodity;

public interface StockManager {
	/*获得店铺某日某商品库存*/
	public int getStock(String store,String date,String commodity);
	/*获得店铺某日某商品销售信息*/
	public Commodity getCommodity(String store,String date,String commodity);
	/*用户在线订购*/
	public boolean shopping(String store,String date,Cart cart,String type,String user,String address,String state);
	/*获得店铺某日某类型商品信息*/
	public List<Commodity> getList(String store,String date,String type);
	/*获得店铺某日所有商品信息*/
	public List<Commodity> getList(String store,String date);
	/*销售情况统计*/
	public List<PlanCommodity> saleStatistic();
}
