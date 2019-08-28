package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Customer;

public class CustomerDAOImpl implements CustomerDAO {
	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public CustomerDAOImpl() {
		dbConnection = JDBCUtil.getConnection();
	}

	private void finallyFunction() {

		try {
			if (cStmt != null)
				cStmt.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (dbConnection != null)
					dbConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	}

	@Override
	public Customer getCustomer(Customer customer) {
		try {
			if (customer.getCustomer_ID() == 0) {
				cStmt = dbConnection.prepareCall("{call spGetCustomerByUserPass(?, ?)}");
				cStmt.setString(1, customer.getEmail());
				cStmt.setString(2, customer.getPassword());
			} else {
				cStmt = dbConnection.prepareCall("{call spGetCustomerByID(?)}");
				cStmt.setInt(1, customer.getCustomer_ID());
			}

			ResultSet rs = cStmt.executeQuery();

			if (rs.next()) {
				customer.setCustomer_ID(rs.getInt("Customer_ID"));
				customer.setEmail(rs.getString("Email"));
				customer.setPhoneNumber(rs.getString("PhoneNumber"));
				customer.setPassword(rs.getString("Password"));
				customer.setFullName(rs.getString("FullName"));
				customer.setAddress(rs.getString("Address"));

			} else {
				customer = new Customer();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return customer;
	}

	@Override
	public int insertCustomer(Customer customer) {

		if (checkEmail(customer) == 1) {
			return -1;
		} else {
			if (checkPhoneNumber(customer) == 1) {
				return -2;
			} else {
				try {
					cStmt = dbConnection.prepareCall("{call spInsertCustomer(?, ?, ?, ?, ?)}");
					cStmt.setString(1, customer.getEmail());
					cStmt.setString(2, customer.getPhoneNumber());
					cStmt.setString(3, customer.getPassword());
					cStmt.setString(4, customer.getFullName());
					cStmt.setString(5, customer.getAddress());

					cStmt.executeUpdate();

					return 1;

				} catch (Exception e) {
					System.err.println(e.getMessage());
				} finally {
					finallyFunction();
				}
			}

		}

		return 0;
	}

	@Override
	public int updateCustomer(Customer customer) {

		if (customer.getFullName() == null) {
			try {
				cStmt = dbConnection.prepareCall("{call spUpdateCustomer_Pass_Add(?, ?, ?)}");
				cStmt.setInt(1, customer.getCustomer_ID());
				cStmt.setString(2, customer.getPassword());
				cStmt.setString(3, customer.getAddress());

				cStmt.executeUpdate();

				return 1;

			} catch (Exception e) {
				System.err.println(e.getMessage());
			} finally {
				finallyFunction();
			}
		} else {

			if (checkEmail(customer) == 1) {
				return -1;
			} else {
				if (checkPhoneNumber(customer) == 1) {
					return -2;
				} else {
					try {
						cStmt = dbConnection.prepareCall("{call spUpdateCustomer(?, ?, ?, ?, ?, ?)}");
						cStmt.setInt(1, customer.getCustomer_ID());
						cStmt.setString(2, customer.getEmail());
						cStmt.setString(3, customer.getPhoneNumber());
						cStmt.setString(4, customer.getPassword());
						cStmt.setString(5, customer.getFullName());
						cStmt.setString(6, customer.getAddress());

						cStmt.executeUpdate();

						return 1;

					} catch (Exception e) {
						System.err.println(e.getMessage());
					} finally {
						finallyFunction();
					}
				}

			}
		}

		return 0;
	}

	private int checkEmail(Customer customer) {
		try {
			cStmt = dbConnection.prepareCall("{call spGetCustomerByEmail(?, ?)}");
			cStmt.setInt(1, customer.getCustomer_ID());
			cStmt.setString(2, customer.getEmail());

			ResultSet rs = cStmt.executeQuery();

			if (rs.next())
				return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		return 0;
	}

	private int checkPhoneNumber(Customer customer) {
		try {
			cStmt = dbConnection.prepareCall("{call spGetCustomerByPhoneNumber(?, ?)}");
			cStmt.setInt(1, customer.getCustomer_ID());
			cStmt.setString(2, customer.getPhoneNumber());

			ResultSet rs = cStmt.executeQuery();

			if (rs.next())
				return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		return 0;
	}

	@Override
	public List<Customer> getAllCustomer(int page) {
		List<Customer> customerList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetAllCustomer(?)}");
			cStmt.setInt(1, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {
				Customer cus = new Customer(rs.getInt("Customer_ID"), rs.getString("Email"),
						rs.getString("PhoneNumber"), rs.getString("FullName"), rs.getString("Address"));
				cus.setPageNumber(rs.getInt("PageNumber"));

				customerList.add(cus);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return customerList;
	}

	@Override
	public List<Customer> searchCustomer(String search, int page) {
		List<Customer> customerList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spSearchCustomer(?, ?)}");
			cStmt.setString(1, search);
			cStmt.setInt(2, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {
				Customer cus = new Customer(rs.getInt("Customer_ID"), rs.getString("Email"),
						rs.getString("PhoneNumber"), rs.getString("FullName"), rs.getString("Address"));
				cus.setPageNumber(rs.getInt("PageNumber"));

				customerList.add(cus);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return customerList;
	}

}
