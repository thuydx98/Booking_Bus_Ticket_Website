package edu.fa.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.fa.dao.AccountDAO;
import edu.fa.dao.AccountDAOImpl;
import edu.fa.dao.CustomerDAO;
import edu.fa.dao.CustomerDAOImpl;
import edu.fa.dao.EmployeeDAO;
import edu.fa.dao.EmployeeDAOImpl;
import edu.fa.jdbc.MD5Library;
import edu.fa.model.Account;
import edu.fa.model.Customer;
import edu.fa.model.Employee;

public class ChangeInfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ChangeInfoController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("loadInfoCustomer".equalsIgnoreCase(request.getParameter("param"))) {
			String email = (String) request.getSession().getAttribute("email");
			String password = (String) request.getSession().getAttribute("password");

			Customer customer = new Customer(email, password);

			CustomerDAO customerDAO = new CustomerDAOImpl();
			customer = customerDAO.getCustomer(customer);

			request.setAttribute("customerinfo", customer);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/HomePage.jsp");

			dispatcher.forward(request, response);
		} else {
			if ("loadInfoCustomerManagement".equalsIgnoreCase(request.getParameter("param"))) {
				String customerID = (String) request.getParameter("customerID");

				Customer customer = new Customer(Integer.parseInt(customerID));

				CustomerDAO customerDAO = new CustomerDAOImpl();
				customer = customerDAO.getCustomer(customer);

				request.getSession().setAttribute("customerinfo", customer);
				request.getSession().setAttribute("passCusSave", customer.getPassword());

				response.sendRedirect("UserManagement.jsp");
			} else {
				if ("loadInfoEmployee".equalsIgnoreCase(request.getParameter("param"))) {

					String employee_ID = request.getParameter("employeeID");

					Employee employee = new Employee(Integer.parseInt(employee_ID));

					EmployeeDAO employeeDAO = new EmployeeDAOImpl();
					employee = employeeDAO.getEmployee(employee);

					request.getSession().setAttribute("usernameSave", employee.getUserName());
					
					request.getSession().setAttribute("passEmpSave", employee.getPassword());

					request.getSession().setAttribute("employeeinfo", employee);

					response.sendRedirect("EmpManagement.jsp");
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		if ("changeInfoCustomer".equalsIgnoreCase(request.getParameter("param"))) {

			CustomerDAO customerDAO = new CustomerDAOImpl();

			// Get Email and Password of User who is available in session
			String email = (String) request.getSession().getAttribute("email");
			String password = (String) request.getSession().getAttribute("password");
			String oldPass = password;
			int customer_id = (int) request.getSession().getAttribute("customerid");

			// Get ID of User
			Customer customer = new Customer(email, password, customer_id);
			customer = customerDAO.getCustomer(customer);

			// Get Password and Re-Password
			password = request.getParameter("password");
			String repassword = request.getParameter("repassword");

			// Check Password == Re-Password ?
			if (!password.equals(repassword)) {
				request.getSession().setAttribute("errorUpd", "Password is different with RePassword");
				response.sendRedirect("ChangeInfoController?param=loadInfoCustomer");
			} else {
				
				if(!oldPass.equals(password) )
					password = MD5Library.md5(password);

				// Set User with a new Infomation
				customer.setEmail(request.getParameter("email"));
				customer.setPhoneNumber(request.getParameter("phonenumber"));
				customer.setPassword(password);
				customer.setFullName(request.getParameter("fullname"));
				customer.setAddress(request.getParameter("address"));
				
				

				// Update Info to Database
				customerDAO = new CustomerDAOImpl();
				int result = customerDAO.updateCustomer(customer);

				// Result of check Email exists
				if (result == -1) {
					request.getSession().setAttribute("errorUpd", "Email was exists");
					response.sendRedirect("ChangeInfoController?param=loadInfoCustomer");

				} else {

					// Result of Check PhoneNumber exists
					if (result == -2) {
						request.getSession().setAttribute("errorUpd", "Phone Number was exists");
						response.sendRedirect("ChangeInfoController?param=loadInfoCustomer");
					} else {

						// Result of Update complete
						if (result == 1) {

							// Save new Info to Session
							HttpSession session = request.getSession();
							session.setAttribute("customername", customer.getFullName());
							session.setAttribute("email", customer.getEmail());
							session.setAttribute("password", customer.getPassword());

							// Delete errorUpd when Update Complete
							request.getSession().removeAttribute("errorUpd");

							response.sendRedirect("HomePage.jsp");

						} else { // Result of Update Fail
							request.getSession().setAttribute("errorUpd",
									"Internal Server Error, Please try again later.");
							response.sendRedirect("ChangeInfoController?param=loadInfoCustomer");
						}
					}
				}
			}

		} else {
			if ("loadInfoEmployee".equalsIgnoreCase(request.getParameter("param"))) {

				String employee_ID = request.getParameter("employeeID");

				Employee employee = new Employee(Integer.parseInt(employee_ID));

				EmployeeDAO employeeDAO = new EmployeeDAOImpl();
				employee = employeeDAO.getEmployee(employee);

				request.getSession().setAttribute("usernameSave", employee.getUserName());
				
				request.getSession().setAttribute("passEmpSave", employee.getPassword());

				request.getSession().setAttribute("employeeinfo", employee);

				response.sendRedirect("EmpManagement.jsp");
			} else {
				if ("changeInfoEmployee".equalsIgnoreCase(request.getParameter("param"))) {

					HttpSession session = request.getSession();

					String employeeID = request.getParameter("employeeid");
					String firstName = request.getParameter("firstname");
					String lastName = request.getParameter("lastname");
					String email = request.getParameter("email");
					String idNumber = request.getParameter("idnumber");
					String phonenumber = request.getParameter("phonenumber");
					String Address = request.getParameter("address");

					String userName = request.getParameter("username");
					String password = request.getParameter("password");
					String repassword = request.getParameter("repassword");
					String role = request.getParameter("role");

					if (!password.equals(repassword)) {
						request.getSession().setAttribute("errorEditEmp", "Error: Password is different with RePassword");
						response.sendRedirect("ChangeInfoController?param=loadInfoEmployee&employeeID=" + employeeID);

					} else {
						
						if(!password.equals(session.getAttribute("passEmpSave"))) {
							password = MD5Library.md5(password);
							session.removeAttribute("passEmpSave");
						}
						
						
						if (role.equals("2") && ("".equals(userName) || userName == null || "".equals(password)
								|| password == null)) {
							request.getSession().setAttribute("errorEditEmp", "Error: Seller must have username and password");
							response.sendRedirect("ChangeInfoController?param=loadInfoEmployee&employeeID=" + employeeID);

						} else {

							Account account = new Account(userName);
							AccountDAO accountDAO = new AccountDAOImpl();

							account = accountDAO.getUserNameByUserName(account, (String) session.getAttribute("usernameSave"));

							if (role.equals("2") && account.getUserName() != null) {
								request.getSession().setAttribute("errorEditEmp", "Error: User Name was exists");
								response.sendRedirect("ChangeInfoController?param=loadInfoEmployee&employeeID=" + employeeID);
							} else {
								Employee employee = new Employee(Integer.parseInt(employeeID), firstName, lastName,
										email, idNumber, Address, (int) session.getAttribute("employeeid"), userName,
										password, phonenumber, Integer.parseInt(role));

								EmployeeDAO employeeDAO = new EmployeeDAOImpl();

								int result = employeeDAO.updateEmployee(employee);

								if (result == 1) {

									request.getSession().setAttribute("success", "Update Employee Complete!");
									request.getSession().removeAttribute("errorEditEmp");
									response.sendRedirect("EmpManagement.jsp");
								} else {
									request.getSession().setAttribute("errorEditEmp", "Error: Internal Server Error, Please try again later.");
									response.sendRedirect("ChangeInfoController?param=loadInfoEmployee&employeeID=" + employeeID);
								}
							}
						}
					}
					
				} else {
					if ("loadInfoCustomerManagement".equalsIgnoreCase(request.getParameter("param"))) {
						String customerID = (String) request.getParameter("customerID");

						Customer customer = new Customer(Integer.parseInt(customerID));

						CustomerDAO customerDAO = new CustomerDAOImpl();
						customer = customerDAO.getCustomer(customer);

						request.getSession().setAttribute("customerinfo", customer);
						request.getSession().setAttribute("passCusSave", customer.getPassword());

						response.sendRedirect("UserManagement.jsp");
					} else {
						if ("changeInfoCustomerManagement".equalsIgnoreCase(request.getParameter("param"))) {
							String customerID = (String) request.getParameter("customerid");
							String password = (String) request.getParameter("password");
							String repassword = (String) request.getParameter("repassword");
							String address = (String) request.getParameter("address");

							if (!password.equals(repassword)) {
								request.getSession().setAttribute("errorEditCus", "Password is different with RePassword");
								response.sendRedirect("ChangeInfoController?param=loadInfoCustomerManagement&customerID=" + customerID);
							} else {
								
								if(!password.equals(request.getSession().getAttribute("passCusSave"))) {
									password = MD5Library.md5(password);
									request.getSession().removeAttribute("passCusSave");
								}

								Customer customer = new Customer(Integer.parseInt(customerID), password, address);

								CustomerDAO customerDAO = new CustomerDAOImpl();
								int result = customerDAO.updateCustomer(customer);
								
								if (result == 1) {
									request.getSession().removeAttribute("errorEditCus");
									response.sendRedirect("UserManagement.jsp");
								} else {
									request.getSession().setAttribute("errorUpd", "Internal Server Error, Please try again later.");
									response.sendRedirect("ChangeInfoController?param=loadInfoCustomerManagement&customerID=" + customerID);
								}
							}
						}
					}
				}
			}
		}
	}

}
