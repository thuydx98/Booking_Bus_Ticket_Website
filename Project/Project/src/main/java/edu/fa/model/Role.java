package edu.fa.model;

public class Role {
	private int Role_ID;
	private String Role_Name;

	public int getRole_ID() {
		return Role_ID;
	}

	public void setRole_ID(int role_ID) {
		Role_ID = role_ID;
	}

	public String getRole_Name() {
		return Role_Name;
	}

	public void setRole_Name(String role_Name) {
		Role_Name = role_Name;
	}

	public Role() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Role(String role_Name) {
		super();
		Role_Name = role_Name;
	}

	public Role(int role_ID, String role_Name) {
		super();
		Role_ID = role_ID;
		Role_Name = role_Name;
	}

}
