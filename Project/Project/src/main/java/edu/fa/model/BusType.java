package edu.fa.model;

public class BusType {
	private int Type_ID;
	private String TypeName;

	public int getType_ID() {
		return Type_ID;
	}

	public void setType_ID(int type_ID) {
		Type_ID = type_ID;
	}

	public String getTypeName() {
		return TypeName;
	}

	public void setTypeName(String typeName) {
		TypeName = typeName;
	}

	public BusType() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BusType(String typeName) {
		super();
		TypeName = typeName;
	}

	public BusType(int type_ID, String typeName) {
		super();
		Type_ID = type_ID;
		TypeName = typeName;
	}

}
