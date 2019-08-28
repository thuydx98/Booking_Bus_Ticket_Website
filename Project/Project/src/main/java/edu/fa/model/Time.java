package edu.fa.model;

import java.time.LocalDate;

public class Time {
	private int schedule_ID;
	private String typeBus;
	private int amount;
	private int startPlace;
	private int finishPlace;
	private LocalDate dateStart;
	private String timeStart;

	public int getSchedule_ID() {
		return schedule_ID;
	}

	public void setSchedule_ID(int schedule_ID) {
		this.schedule_ID = schedule_ID;
	}

	public String getTypeBus() {
		return typeBus;
	}

	public void setTypeBus(String typeBus) {
		this.typeBus = typeBus;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getStartPlace() {
		return startPlace;
	}

	public void setStartPlace(int startPlace) {
		this.startPlace = startPlace;
	}

	public int getFinishPlace() {
		return finishPlace;
	}

	public void setFinishPlace(int finishPlace) {
		this.finishPlace = finishPlace;
	}

	public LocalDate getDateStart() {
		return dateStart;
	}

	public void setDateStart(LocalDate dateStart) {
		this.dateStart = dateStart;
	}

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public Time() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Time(int amount, int startPlace, int finishPlace, LocalDate dateStart) {
		super();
		this.amount = amount;
		this.startPlace = startPlace;
		this.finishPlace = finishPlace;
		this.dateStart = dateStart;
	}

	public Time(int schedule_ID, String typeBus, String timeStart) {
		super();
		this.schedule_ID = schedule_ID;
		this.typeBus = typeBus;
		this.timeStart = timeStart;
	}

	public Time(int Schedule_ID, LocalDate dateStart) {
		super();
		this.schedule_ID = Schedule_ID;
		this.dateStart = dateStart;
	}

}
