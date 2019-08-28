package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Account;
import edu.fa.model.Employee;

public class EmployeeDAOImpl implements EmployeeDAO {

	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public EmployeeDAOImpl() {
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
	public int insertEmployee(Employee employee, Account account) {

		try {
			cStmt = dbConnection.prepareCall("{call spInsertEmployee(?, ?, ?, ?, ?, ?)}");
			cStmt.setString(1, employee.getFirstName());
			cStmt.setString(2, employee.getLastName());
			cStmt.setString(3, employee.getEmail());
			cStmt.setString(4, employee.getIdNumber());
			cStmt.setString(5, employee.getAddress());
			cStmt.setInt(6, employee.getManager_ID());

			cStmt.executeUpdate();

			cStmt = dbConnection.prepareCall("{call spGetEmployeeIDByInfo(?, ?, ?, ?, ?, ?)}");
			cStmt.setString(1, employee.getFirstName());
			cStmt.setString(2, employee.getLastName());
			cStmt.setString(3, employee.getEmail());
			cStmt.setString(4, employee.getIdNumber());
			cStmt.setString(5, employee.getAddress());
			cStmt.setInt(6, employee.getManager_ID());

			ResultSet rs = cStmt.executeQuery();

			if (rs.next()) {
				int employee_ID = rs.getInt("Employee_ID");

				cStmt = dbConnection.prepareCall("{call spInsertPhoneNumberEmployee(?, ?)}");
				cStmt.setInt(1, employee_ID);
				for (int i = 0; i < employee.getPhoneList().size(); i++) {
					cStmt.setString(2, employee.getPhoneList().get(i));
					cStmt.executeUpdate();
				}

				if (employee.getRoleList().get(0) == 1 || employee.getRoleList().get(0) == 2) {
					cStmt = dbConnection.prepareCall("{call spInsertAccount(?, ?, ?)}");
					cStmt.setInt(1, employee_ID);
					cStmt.setString(2, account.getUserName());
					cStmt.setString(3, account.getPassword());

					cStmt.executeUpdate();
				}

				cStmt = dbConnection.prepareCall("{call spInsertRole(?, ?)}");
				cStmt.setInt(1, employee_ID);
				for (int i = 0; i < employee.getRoleList().size(); i++) {
					cStmt.setInt(2, employee.getRoleList().get(i));
					cStmt.executeUpdate();
				}
			}

			return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			finallyFunction();
		}

		return 0;
	}

	@Override
	public List<Employee> getAllEmployee(int page) {
		List<Employee> employeeList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetAllEmployee(?)}");
			cStmt.setInt(1, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {
				Employee emp = new Employee(rs.getInt("Employee_ID"), rs.getString("FirstName"), rs.getString("LastName"),
						rs.getString("IDNumber"), rs.getString("UserName"), rs.getString("ManagerName"),
						rs.getString("Status"), rs.getString("Role_Name"));
				emp.setPageNumber(rs.getInt("PageNumber"));

				employeeList.add(emp);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return employeeList;
	}

	@Override
	public List<Employee> searchEmployee(String search, int page) {
		List<Employee> employeeList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spSearchEmployee(?, ?)}");
			cStmt.setString(1, search);
			cStmt.setInt(2, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {
				Employee emp = new Employee(rs.getInt("Employee_ID"), rs.getString("FirstName"), rs.getString("LastName"),
						rs.getString("IDNumber"), rs.getString("UserName"), rs.getString("ManagerName"),
						rs.getString("Status"), rs.getString("Role_Name"));
				emp.setPageNumber(rs.getInt("PageNumber"));

				employeeList.add(emp);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return employeeList;
	}

	@Override
	public Employee getEmployee(Employee employee) {

		try {
			cStmt = dbConnection.prepareCall("{call spGetEmployeeByID(?)}");
			cStmt.setInt(1, employee.getEmployee_ID());

			ResultSet rs = cStmt.executeQuery();

			if (rs.next()) {

				int employee_id = employee.getEmployee_ID();

				employee = new Employee(employee_id, rs.getString("FirstName"), rs.getString("LastName"),
						rs.getString("Email"), rs.getString("IDNumber"), rs.getString("Address"),
						rs.getString("UserName"), rs.getString("Password"), rs.getString("PhoneNumber"),
						rs.getInt("Role_ID"));
			} else {
				employee = new Employee();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return employee;
	}

	@Override
	public int updateEmployee(Employee employee) {

		try {
			cStmt = dbConnection.prepareCall("{call spUpdateEmployee(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
			cStmt.setString(1, employee.getFirstName());
			cStmt.setString(2, employee.getLastName());
			cStmt.setString(3, employee.getEmail());
			cStmt.setString(4, employee.getIdNumber());
			cStmt.setString(5, employee.getAddress());
			cStmt.setInt(6, employee.getManager_ID());
			cStmt.setString(7, employee.getPhoneList().get(0));
			cStmt.setInt(8, employee.getRoleList().get(0));
			cStmt.setInt(9, employee.getEmployee_ID());
			cStmt.setString(10, employee.getUserName());
			cStmt.setString(11, employee.getPassword());
			cStmt.executeUpdate();

			return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			finallyFunction();
		}

		return 0;
	}

	@Override
	public int updateEmployee(int employeeID) {
		try {
			cStmt = dbConnection.prepareCall("{call spQuitEmployee(?)}");
			cStmt.setInt(1, employeeID);
			cStmt.executeUpdate();

			return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			finallyFunction();
		}

		return 0;
	}

}
