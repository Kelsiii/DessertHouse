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

import desserthouse.action.StaffListBean;
import desserthouse.logic.StaffManager;
import desserthouse.logic.impl.StaffManagerImpl;
import desserthouse.model.Staff;

/**
 * Servlet implementation class StaffServlet
 */
@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StaffServlet() {
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
		String type=request.getParameter("type");
		StaffManager sm = new StaffManagerImpl();
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		if(type.equals("update")){
			Staff staff = new Staff();
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String sex = request.getParameter("sex");
			String position = request.getParameter("position");
			String store = request.getParameter("store");
			int age = Integer.parseInt(request.getParameter("age"));
			staff.setId(id);
			staff.setPassword(password);
			staff.setName(name);
			staff.setTel(tel);
			staff.setSex(sex);
			staff.setPosition(position);
			staff.setStoreId(store);
			staff.setAge(age);
			boolean result = sm.update(staff);
			out.print(result);
			if(result){
				StaffListBean staffListBean = new StaffListBean();
				List stafflist = sm.GetStaffList();
				staffListBean.setStaffList(stafflist);
				session.setAttribute("StaffList", staffListBean);
			}
		}
		if(type.equals("add")){
			Staff staff = new Staff();
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String sex = request.getParameter("sex");
			String position = request.getParameter("position");
			String store = request.getParameter("store");
			int age = Integer.parseInt(request.getParameter("age"));
			staff.setId(id);
			staff.setPassword(password);
			staff.setName(name);
			staff.setTel(tel);
			staff.setSex(sex);
			staff.setPosition(position);
			staff.setStoreId(store);
			staff.setAge(age);
			boolean result = sm.add(staff);
			out.print(result);
			if(result){
				StaffListBean staffListBean = new StaffListBean();
				List stafflist = sm.GetStaffList();
				staffListBean.setStaffList(stafflist);
				session.setAttribute("StaffList", staffListBean);
			}
		}
		if(type.equals("delete")){
			String id = request.getParameter("id");
			boolean result = sm.delete(id);
			out.print(result);
			if(result){
				StaffListBean staffListBean = new StaffListBean();
				List stafflist = sm.GetStaffList();
				staffListBean.setStaffList(stafflist);
				session.setAttribute("StaffList", staffListBean);
			}
		}
	}

}
