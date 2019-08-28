package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Account;
import edu.fa.model.Employee;

public class AccountDAOImpl implements AccountDAO {
	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public AccountDAOImpl() {
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
	public Employee getEmployeeByAccount(Account account) {
		Employee employee = new Employee();
		try {
			cStmt = dbConnection.prepareCall("{call spGetEmployeeByAccount(?, ?)}");
			cStmt.setString(1, account.getUserName());
			cStmt.setString(2, account.getPassword());

			ResultSet rs = cStmt.executeQuery();

			if (rs.next()) {
				employee.setEmployee_ID(rs.getInt("Employee_ID"));
				employee.setFirstName(rs.getString("FirstName"));
				employee.setLastName(rs.getString("LastName"));
				employee.setEmail(rs.getString("Email"));
				employee.getRoleList().add(rs.getInt("Role_ID"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return employee;
	}

	@Override
	public Account getUserNameByUserName(Account account) {

		try {
			cStmt = dbConnection.prepareCall("{call spGetUserNameByUserName(?)}");
			cStmt.setString(1, account.getUserName());

			ResultSet rs = cStmt.executeQuery();

			if (rs.next()) {
				account.setUserName(rs.getString("UserName"));
			}
			else {
				account = new Account();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return account;
	}

	@Override
	public Account getUserNameByUserName(Account account, String usernameSave) {
		try {
			cStmt = dbConnection.prepareCall("{call spGetUserNameByNewUserNameOldUserName(?, ?)}");
			cStmt.setString(1, account.getUserName());
			cStmt.setString(2, usernameSave);


			ResultSet rs = cStmt.executeQuery();

			if (rs.next()) {
				account.setUserName(rs.getString("UserName"));
			}
			else {
				account = new Account();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return account;
	}

}
