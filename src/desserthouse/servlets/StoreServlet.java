package desserthouse.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import desserthouse.action.StoreListBean;
import desserthouse.logic.StoreManager;
import desserthouse.logic.impl.StoreManagerImpl;
import desserthouse.model.Store;

/**
 * Servlet implementation class StaffServlet
 */
@WebServlet("/StoreServlet")
public class StoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		StoreManager stm = new StoreManagerImpl();
		String type = request.getParameter("type");
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		if(type.equals("update")){
			Store store = new Store();
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			String tel = request.getParameter("tel");
			store.setId(id);
			store.setAddress(address);
			store.setName(name);
			store.setTel(tel);
			boolean result = stm.update(store);
			out.print(result);
			if(result){
				StoreListBean storeListBean = new StoreListBean();
				List storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
			}
		}
		if(type.equals("delete")){
			String id = request.getParameter("id");
			boolean result = stm.delete(id);
			out.print(result);
			if(result){
				StoreListBean storeListBean = new StoreListBean();
				List storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
			}
		}
		if(type.equals("add")){
			Store store = new Store();
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			String tel = request.getParameter("tel");
			store.setId(id);
			store.setAddress(address);
			store.setName(name);
			store.setTel(tel);
			boolean result = stm.add(store);
			out.println(result);
			if(result){
				StoreListBean storeListBean = new StoreListBean();
				List storelist = stm.GetStoreList();
				storeListBean.setStoreList(storelist);
				session.setAttribute("StoreList", storeListBean);
			}
		}
	}

}
