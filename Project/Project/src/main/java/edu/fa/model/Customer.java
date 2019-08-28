package edu.fa.model;

public class Customer {

	private int customer_ID;
	private String email;
	private String phoneNumber;
	private String password;
	private String fullName;
	private String address;
	private int pageNumber;

	public int getCustomer_ID() {
		return customer_ID;
	}

	public void setCustomer_ID(int customer_ID) {
		this.customer_ID = customer_ID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Customer(int customer_ID) {
		super();
		this.customer_ID = customer_ID;
	}

	public Customer(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}

	public Customer(String email, String password, int customer_ID) {
		super();
		this.customer_ID = customer_ID;
		this.email = email;
		this.password = password;
	}

	public Customer(int customer_ID, String password, String address) {
		super();
		this.customer_ID = customer_ID;
		this.password = password;
		this.address = address;
	}

	public Customer(String email, String phoneNumber, String password, String fullName, String address) {
		super();
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
		this.fullName = fullName;
		this.address = address;
	}

	public Customer(int customer_ID, String email, String phoneNumber, String fullName, String address) {
		super();
		this.customer_ID = customer_ID;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.fullName = fullName;
		this.address = address;
	}

}
