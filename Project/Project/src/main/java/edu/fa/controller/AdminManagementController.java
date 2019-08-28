package edu.fa.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.fa.dao.CustomerDAO;
import edu.fa.dao.CustomerDAOImpl;
import edu.fa.dao.EmployeeDAO;
import edu.fa.dao.EmployeeDAOImpl;
import edu.fa.model.Customer;
import edu.fa.model.Employee;

public class AdminManagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminManagementController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if ("getEmployeeList".equalsIgnoreCase(request.getParameter("param"))) {

			HttpSession session = request.getSession();

			if (session.getAttribute("employeeid") == null) {
				session.setAttribute("error", "You must Login before go to ADMIN MANAGEMENT!");
				response.sendRedirect("Login.jsp");
			} else {

				String search = request.getParameter("searchEmp");

				if (search != null) {
					search = search.trim();
					session.setAttribute("searchEmp", search);
				}
				else
					search = (String) session.getAttribute("searchEmp");
				
				int pageid = 1;
				if (request.getParameter("page") != null)
					pageid = Integer.parseInt(request.getParameter("page"));

				EmployeeDAO employeeDAO = new EmployeeDAOImpl();

				List<Employee> employeeList;

				if (session.getAttribute("searchEmp") == null || search == null || "".equals(search)) {

					employeeList = employeeDAO.getAllEmployee(pageid);

				} else {

					employeeList = employeeDAO.searchEmployee(search, pageid);
				}

				if (employeeList.size() == 0) {
					request.setAttribute("employeeList", "-1");
					request.setAttribute("pageNumber", 0);
				}
				else {
					request.setAttribute("employeeList", employeeList);
					request.setAttribute("pageNumber", employeeList.get(0).getPageNumber());
				}

				request.setAttribute("pageActive", pageid);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/EmpManagement.jsp");
				dispatcher.forward(request, response);
			}
		} else {
			if ("quitEmployee".equalsIgnoreCase(request.getParameter("param"))) {

				HttpSession session = request.getSession();

				if (session.getAttribute("employeeid") == null) {
					session.setAttribute("error", "You must Login before go to ADMIN MANAGEMENT!");
					response.sendRedirect("Login.jsp");
				} else {

					String employeeID = request.getParameter("employeeID");

					EmployeeDAO employeeDAO = new EmployeeDAOImpl();
					employeeDAO.updateEmployee(Integer.parseInt(employeeID));

					response.sendRedirect("EmpManagement.jsp");
				}
			} else {
				if ("getCustomerList".equalsIgnoreCase(request.getParameter("param"))) {

					HttpSession session = request.getSession();

					if (session.getAttribute("employeeid") == null) {
						session.setAttribute("error", "You must Login before go to ADMIN MANAGEMENT!");
						response.sendRedirect("Login.jsp");
					} else {

						String search = request.getParameter("searchCus");

						if (search != null) {
							search = search.trim();
							session.setAttribute("searchCus", search);
						}
						else
							search = (String) session.getAttribute("searchCus");

						int pageid = 1;
						if (request.getParameter("page") != null)
							pageid = Integer.parseInt(request.getParameter("page"));

						CustomerDAO customerDAO = new CustomerDAOImpl();

						List<Customer> customerList;

						if (session.getAttribute("searchCus") == null || search == null || "".equals(search)) {

							customerList = customerDAO.getAllCustomer(pageid);

						} else {

							customerList = customerDAO.searchCustomer(search, pageid);
						}

						if (customerList.size() == 0) {
							request.setAttribute("customerList", "-1");
							request.setAttribute("pageNumber", 0);
						}
						else {
							request.setAttribute("customerList", customerList);
							request.setAttribute("pageNumber", customerList.get(0).getPageNumber());
						}

						request.setAttribute("pageActive", pageid);

						RequestDispatcher dispatcher = request.getRequestDispatcher("/UserManagement.jsp");
						dispatcher.forward(request, response);
					}
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
