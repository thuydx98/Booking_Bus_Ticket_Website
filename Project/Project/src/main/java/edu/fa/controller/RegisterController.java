package edu.fa.controller;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.fa.dao.AccountDAO;
import edu.fa.dao.AccountDAOImpl;
import edu.fa.dao.BookingDAO;
import edu.fa.dao.BookingDAOImpl;
import edu.fa.dao.CustomerDAO;
import edu.fa.dao.CustomerDAOImpl;
import edu.fa.dao.EmployeeDAO;
import edu.fa.dao.EmployeeDAOImpl;
import edu.fa.jdbc.MD5Library;
import edu.fa.model.Account;
import edu.fa.model.Booking;
import edu.fa.model.Customer;
import edu.fa.model.Employee;

public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		if ("register".equalsIgnoreCase(request.getParameter("param"))) {
			HttpSession session = request.getSession();
			request.getSession().removeAttribute("error");

			String email = request.getParameter("email");
			String phoneNum = request.getParameter("phonenumber");

			String password = MD5Library.md5(request.getParameter("password"));
			String repassword = MD5Library.md5(request.getParameter("repassword"));

			String fullName = request.getParameter("fullname");
			String address = request.getParameter("address");

			Customer customer = new Customer(email, phoneNum, password, fullName, address);

			CustomerDAO customerDAO = new CustomerDAOImpl();

			if (!password.equals(repassword)) {
				request.getSession().setAttribute("errorReg", "Password is different with RePassword");

			} else {

				int result = customerDAO.insertCustomer(customer);

				if (result == -1) {
					request.getSession().setAttribute("errorReg", "Email was exists");

				} else {
					if (result == -2) {
						request.getSession().setAttribute("errorReg", "Phone Number was exists");

					} else {
						if (result == 1) {
							if (request.getParameter("button") == null) {
								customerDAO = new CustomerDAOImpl();
								customer = customerDAO.getCustomer(customer);
								session.setAttribute("customername", customer.getFullName());
								session.setAttribute("customerid", customer.getCustomer_ID());
								session.setAttribute("email", customer.getEmail());
								session.setAttribute("password", customer.getPassword());
							}

							request.getSession().removeAttribute("errorReg");
						} else {
							request.getSession().setAttribute("errorReg",
									"Internal Server Error, Please try again later.");
						}
					}
				}
			}

			if (request.getParameter("button") == null) {
				response.sendRedirect("HomePage.jsp");
			} else {

				if (request.getParameter("button").equals("AvailableSeats")) {

					if (request.getSession().getAttribute("errorReg") == null) {
						customerDAO = new CustomerDAOImpl();
						customer = customerDAO.getCustomer(customer);

						BookingDAO bookingDAO = new BookingDAOImpl();
						Booking booking = new Booking(
								Integer.parseInt((String) request.getSession().getAttribute("schedule_id")),
								customer.getCustomer_ID(), (String) request.getSession().getAttribute("datestart"), "");

						booking.getSeatList()
								.add(Integer.parseInt((String) request.getSession().getAttribute("SeatEmpty")));
						bookingDAO.insertBooking(booking);

						request.getSession().removeAttribute("SeatEmpty");
					}

					response.sendRedirect(
							"BookingTicketsController?param=getBookedSeatsByPlaceTimeDate&button=abc&schedule_id="
									+ request.getSession().getAttribute("schedule_id") + "&datestart="
									+ request.getSession().getAttribute("datestart"));
				} else {
					if (request.getParameter("button").equals("manager")) {
						response.sendRedirect("UserManagement.jsp");
					}
				}

			}

		} else {

			if ("registerEmployee".equalsIgnoreCase(request.getParameter("param"))) {
				HttpSession session = request.getSession();

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
					request.getSession().setAttribute("errorRegEmp", "Error: Password is different with RePassword");

				} else {
					if (role.equals("2")
							&& ("".equals(userName) || userName == null || "".equals(password) || password == null)) {
						request.getSession().setAttribute("errorRegEmp",
								"Error: Seller must have username and password");

					} else {

						Account account = new Account(userName);
						AccountDAO accountDAO = new AccountDAOImpl();

						account = accountDAO.getUserNameByUserName(account);

						if (role.equals("2") && account.getUserName() != null) {
							request.getSession().setAttribute("errorRegEmp", "Error: User Name was exists");
						} else {
							Employee employee = new Employee(firstName, lastName, email, idNumber, Address,
									(int) session.getAttribute("employeeid"), phonenumber, Integer.parseInt(role));

							account = new Account(userName, MD5Library.md5(password));

							EmployeeDAO employeeDAO = new EmployeeDAOImpl();

							int result = employeeDAO.insertEmployee(employee, account);

							if (result == 1) {

								request.getSession().setAttribute("success", "Create Employee Complete!");
								request.getSession().removeAttribute("errorRegEmp");
							} else {
								request.getSession().setAttribute("errorRegEmp",
										"Error: Internal Server Error, Please try again later.");
							}
						}
					}
				}

				response.sendRedirect("EmpManagement.jsp");
			}

		}
	}

}
