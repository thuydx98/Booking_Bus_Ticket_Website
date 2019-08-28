package edu.fa.model;

import java.util.ArrayList;
import java.util.List;

public class Employee {

	private int employee_ID;
	private String firstName;
	private String lastName;
	private String email;
	private String idNumber;
	private String address;
	private String userName;
	private String password;
	private int manager_ID;
	private String managerName;
	private String status;
	private List<String> phoneList;
	private List<Integer> roleList;
	private String roleName;
	private int pageNumber;

	public int getEmployee_ID() {
		return employee_ID;
	}

	public void setEmployee_ID(int employee_ID) {
		this.employee_ID = employee_ID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getManager_ID() {
		return manager_ID;
	}

	public void setManager_ID(int manager_ID) {
		this.manager_ID = manager_ID;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<String> getPhoneList() {
		return phoneList;
	}

	public void setPhoneList(List<String> phoneList) {
		this.phoneList = phoneList;
	}

	public List<Integer> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Integer> roleList) {
		this.roleList = roleList;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Employee() {
		super();
		this.phoneList = new ArrayList<>();
		this.roleList = new ArrayList<>();
	}

	public Employee(int employee_ID) {
		super();
		this.employee_ID = employee_ID;
		this.phoneList = new ArrayList<>();
		this.roleList = new ArrayList<>();
	}

	public Employee(int employee_ID, String firstName, String lastName, String email, List<Integer> roleList) {
		super();
		this.employee_ID = employee_ID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.roleList = roleList;
	}

	public Employee(int employeeid, String firstName, String lastName, String idNumber, String userName,
			String managerName, String status, String roleName) {
		super();
		this.employee_ID = employeeid;
		this.firstName = firstName;
		this.lastName = lastName;
		this.idNumber = idNumber;
		this.userName = userName;
		this.managerName = managerName;
		this.status = status;
		this.roleName = roleName;
	}

	public Employee(String firstName, String lastName, String email, String iDNumber, String address, int manager_ID,
			String phoneNumber, int role) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.idNumber = iDNumber;
		this.address = address;
		this.manager_ID = manager_ID;
		this.phoneList = new ArrayList<>();
		this.phoneList.add(phoneNumber);
		this.roleList = new ArrayList<>();
		this.roleList.add(role);
	}

	public Employee(int employee_ID, String firstName, String lastName, String email, String idNumber, String address,
			String userName, String password, String phoneNumber, int roleID) {
		super();
		this.employee_ID = employee_ID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.idNumber = idNumber;
		this.address = address;
		this.userName = userName;
		this.password = password;
		this.phoneList = new ArrayList<>();
		this.phoneList.add(phoneNumber);
		this.roleList = new ArrayList<>();
		this.roleList.add(roleID);
	}

	public Employee(int employee_ID, String firstName, String lastName, String email, String idNumber, String address,
			int manager_ID, String userName, String password, String phoneNumber, int roleID) {
		super();
		this.employee_ID = employee_ID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.idNumber = idNumber;
		this.address = address;
		this.manager_ID = manager_ID;
		this.userName = userName;
		this.password = password;
		this.phoneList = new ArrayList<>();
		this.phoneList.add(phoneNumber);
		this.roleList = new ArrayList<>();
		this.roleList.add(roleID);
	}

}
