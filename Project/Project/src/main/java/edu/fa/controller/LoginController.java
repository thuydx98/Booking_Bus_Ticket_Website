package edu.fa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.fa.dao.AccountDAO;
import edu.fa.dao.AccountDAOImpl;
import edu.fa.dao.CustomerDAO;
import edu.fa.dao.CustomerDAOImpl;
import edu.fa.jdbc.MD5Library;
import edu.fa.model.Account;
import edu.fa.model.Customer;
import edu.fa.model.Employee;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("logout".equalsIgnoreCase(request.getParameter("param"))) {
			HttpSession session = request.getSession();
			if (session != null) {
				session.invalidate();
			}
			response.sendRedirect("HomePage.jsp");
		} else {
			if ("logoutEmployee".equalsIgnoreCase(request.getParameter("param"))) {
				HttpSession session = request.getSession();
				if (session != null) {
					session.invalidate();
				}
				response.sendRedirect("Login.jsp");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("login".equalsIgnoreCase(request.getParameter("param"))) {
			String user = request.getParameter("username");
			String password = request.getParameter("password");

			Customer customer = new Customer(user, MD5Library.md5(password));

			HttpSession session = request.getSession();
			session.setMaxInactiveInterval(1800);

			CustomerDAO customerDAO = new CustomerDAOImpl();
			customer = customerDAO.getCustomer(customer);
			session.removeAttribute("errorReg");

			if (customer.getCustomer_ID() == 0) {
				session.setAttribute("error", "Invalid User Name or Password");
				response.sendRedirect("HomePage.jsp");
			} else {
				session.setAttribute("customername", customer.getFullName());
				session.setAttribute("customerid", customer.getCustomer_ID());
				session.setAttribute("email", customer.getEmail());
				session.setAttribute("password", customer.getPassword());

				session.removeAttribute("error");
				response.sendRedirect("HomePage.jsp");
			}
		} else {

			if ("loginEmployee".equalsIgnoreCase(request.getParameter("param"))) {

				HttpSession session = request.getSession();
				session.setMaxInactiveInterval(1800);

				String user = request.getParameter("username");
				String password = request.getParameter("password");

				Account account = new Account(user, MD5Library.md5(password));
				AccountDAO accountDAO = new AccountDAOImpl();
				Employee employee = accountDAO.getEmployeeByAccount(account);

				if (employee.getEmployee_ID() == 0) {
					session.setAttribute("error", "Invalid User Name or Password");
					response.sendRedirect("Login.jsp");

				} else {

					session.setAttribute("employeeid", employee.getEmployee_ID());
					session.setAttribute("employeefirstname", employee.getFirstName());
					session.setAttribute("employeelastname", employee.getLastName());
					session.setAttribute("employeeemail", employee.getEmail());
					/* session.setAttribute("rolename", employee.getRoleList().get(0)); */

					session.removeAttribute("error");
					if (employee.getRoleList().get(0) == 1)
						response.sendRedirect("EmpManagement.jsp");
					else {
						if (employee.getRoleList().get(0) == 2)
							response.sendRedirect("TicketsBooked.jsp");
					}

				}
			}
		}
	}

}
