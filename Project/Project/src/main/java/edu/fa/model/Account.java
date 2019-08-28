package edu.fa.model;

public class Account {
	private String UserName;
	private String Password;
	private int Employee_ID;

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public int getEmployee_ID() {
		return Employee_ID;
	}

	public void setEmployee_ID(int employee_ID) {
		Employee_ID = employee_ID;
	}

	public Account() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Account(String userName) {
		super();
		UserName = userName;
	}

	public Account(String userName, String password) {
		super();
		UserName = userName;
		Password = password;
	}

	public Account(String userName, String password, int employee_ID) {
		super();
		UserName = userName;
		Password = password;
		Employee_ID = employee_ID;
	}
}
