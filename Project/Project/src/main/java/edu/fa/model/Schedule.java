package edu.fa.model;

public class Schedule {

	private int schedule_ID;
	private String timeStart;
	private String startPlace;
	private String finishPlace;
	private String numberPlate;
	private String busType;
	private double price;

	public int getSchedule_ID() {
		return schedule_ID;
	}

	public void setSchedule_ID(int schedule_ID) {
		this.schedule_ID = schedule_ID;
	}

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getStartPlace() {
		return startPlace;
	}

	public void setStartPlace(String startPlace) {
		this.startPlace = startPlace;
	}

	public String getFinishPlace() {
		return finishPlace;
	}

	public void setFinishPlace(String finishPlace) {
		this.finishPlace = finishPlace;
	}

	public String getNumberPlate() {
		return numberPlate;
	}

	public void setNumberPlate(String numberPlate) {
		this.numberPlate = numberPlate;
	}

	public String getBusType() {
		return busType;
	}

	public void setBusType(String busType) {
		this.busType = busType;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Schedule() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Schedule(int schedule_ID, String timeStart, String startPlace, String finishPlace, String numberPlate, String busType) {
		super();
		this.schedule_ID = schedule_ID;
		this.timeStart = timeStart;
		this.startPlace = startPlace;
		this.finishPlace = finishPlace;
		this.numberPlate = numberPlate;
		this.busType = busType;
	}

}
