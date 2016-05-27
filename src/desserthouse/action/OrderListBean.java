package desserthouse.action;

import java.io.Serializable;
import java.util.List;

import desserthouse.model.Order;
import desserthouse.model.Order;

public class OrderListBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List orderList;

	
	public List getOrderList() {
		return orderList;
	}

	
	public void setOrderList(List orderList) {
		this.orderList = orderList;
	}
	
	
	public void setOrderList(Order order, int index) {
		orderList.set(index, order);
	}
	
	public Order getOrder(int index) {
		return (Order) orderList.get(index);
	}

	
}
