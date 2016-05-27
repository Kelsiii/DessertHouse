package desserthouse.logic;

import java.util.List;

import desserthouse.model.Order;

public interface OrderManager {
	public List<Order> getOrderByStore(String store);//根据店铺获取店铺预定订单
	public boolean finishOrder(String id);//根据id获取订单信息
}
