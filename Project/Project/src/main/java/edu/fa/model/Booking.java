package edu.fa.model;

import java.util.ArrayList;
import java.util.List;

public class Booking {
	private int booking_ID;

	private String busType;
	private int schedule_ID;
	private int customer_ID;
	private String bookingDate;
	private String dateStart;
	private String description;
	private String status;
	private List<Integer> seatList;

	private String fullName;
	private String phoneNumber;
	private String email;
	private String address;

	public int getBooking_ID() {
		return booking_ID;
	}

	public void setBooking_ID(int booking_ID) {
		this.booking_ID = booking_ID;
	}

	public String getBusType() {
		return busType;
	}

	public void setBusType(String busType) {
		this.busType = busType;
	}

	public int getSchedule_ID() {
		return schedule_ID;
	}

	public void setSchedule_ID(int schedule_ID) {
		this.schedule_ID = schedule_ID;
	}

	public int getCustomer_ID() {
		return customer_ID;
	}

	public void setCustomer_ID(int customer_ID) {
		this.customer_ID = customer_ID;
	}

	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setStatus(String status) {
		if (!status.equals("True") && !status.equals("False"))
			try {
				throw new Exception();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		else
			this.status = status;
	}

	public List<Integer> getSeatList() {
		return seatList;
	}

	public void setSeatList(List<Integer> seatList) {
		this.seatList = seatList;
	}

	public Booking() {
		super();
		this.seatList = new ArrayList<>();
	}

	public Booking(int schedule_ID, String dateStart, int seat) {
		super();
		this.schedule_ID = schedule_ID;
		this.dateStart = dateStart;
		this.seatList = new ArrayList<>();
		this.seatList.add(seat);
	}

	public Booking(int schedule_ID, int customer_ID, String dateStart, String description) {
		super();
		this.schedule_ID = schedule_ID;
		this.customer_ID = customer_ID;
		this.dateStart = dateStart;
		this.description = description;

		this.seatList = new ArrayList<>();
	}

	public Booking(int booking_ID, String bookingDate, String description, String fullName, String phoneNumber,
			String email, String address, int seat) {
		super();
		this.booking_ID = booking_ID;
		this.bookingDate = bookingDate;
		this.description = description;
		this.fullName = fullName;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.address = address;

		this.seatList = new ArrayList<>();
		this.seatList.add(seat);
	}

}
