package edu.fa.model;

public class Bus {
	private int Bus_ID;
	private String NumberPlate;
	private int BusType_ID;
	private int SeatNum;
	private int Driver_ID;
	private int Emp_ID;
	private int Status;

	public int getBus_ID() {
		return Bus_ID;
	}

	public void setBus_ID(int bus_ID) {
		Bus_ID = bus_ID;
	}

	public String getNumberPlate() {
		return NumberPlate;
	}

	public void setNumberPlate(String numberPlate) {
		NumberPlate = numberPlate;
	}

	public int getBusType_ID() {
		return BusType_ID;
	}

	public void setBusType_ID(int busType_ID) {
		BusType_ID = busType_ID;
	}

	public int getSeatNum() {
		return SeatNum;
	}

	public void setSeatNum(int seatNum) {
		SeatNum = seatNum;
	}

	public int getDriver_ID() {
		return Driver_ID;
	}

	public void setDriver_ID(int driver_ID) {
		Driver_ID = driver_ID;
	}

	public int getEmp_ID() {
		return Emp_ID;
	}

	public void setEmp_ID(int emp_ID) {
		Emp_ID = emp_ID;
	}

	public int getStatus() {
		return Status;
	}

	public void setStatus(int status) throws Exception {
		if (status != 0 && status != 1)
			throw new Exception();
		else
			this.Status = status;
	}

	public Bus() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Bus(String numberPlate, int busType_ID, int seatNum, int driver_ID, int emp_ID, int status) {
		super();
		NumberPlate = numberPlate;
		BusType_ID = busType_ID;
		SeatNum = seatNum;
		Driver_ID = driver_ID;
		Emp_ID = emp_ID;
		Status = status;
	}

	public Bus(int bus_ID, String numberPlate, int busType_ID, int seatNum, int driver_ID, int emp_ID, int status) {
		super();
		Bus_ID = bus_ID;
		NumberPlate = numberPlate;
		BusType_ID = busType_ID;
		SeatNum = seatNum;
		Driver_ID = driver_ID;
		Emp_ID = emp_ID;
		Status = status;
	}

}
