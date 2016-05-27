package desserthouse.action;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import desserthouse.model.Store;


public class StoreListBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List storeList;

	
	public List getStoreList() {
		return storeList;
	}

	
	public void setStoreList(List storeList) {
		this.storeList = storeList;
	}
	
	
	public void setHomeworkList(Store store, int index) {
		storeList.set(index, store);
	}
	
	public Store getStore(int index) {
		return (Store) storeList.get(index);
	}

	
}
