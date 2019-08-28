package edu.fa.model;

import java.util.ArrayList;
import java.util.List;

public class BookingWeb {
	private int booking_ID;
	private String numberPlate;
	private String customerName;
	private String startPlace;
	private String finishPlace;
	private String timeStart;
	private String status;
	private String bookingDate;
	private int pageNumber;

	private List<Integer> seatList;

	public int getBooking_ID() {
		return booking_ID;
	}

	public void setBooking_ID(int booking_ID) {
		this.booking_ID = booking_ID;
	}

	public String getNumberPlate() {
		return numberPlate;
	}

	public void setNumberPlate(String numberPlate) {
		this.numberPlate = numberPlate;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
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

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	public List<Integer> getSeatList() {
		return seatList;
	}

	public void setSeatList(List<Integer> seatList) {
		this.seatList = seatList;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public BookingWeb() {
		super();
		this.seatList = new ArrayList<>();
	}

	public BookingWeb(int booking_ID) {
		super();
		this.booking_ID = booking_ID;
	}

	public BookingWeb(String NumberPlate, String customerName, String startPlace, String finishPlace, String timeStart,
			int booking_ID) {
		super();
		this.booking_ID = booking_ID;
		this.numberPlate = NumberPlate;
		this.customerName = customerName;
		this.startPlace = startPlace;
		this.finishPlace = finishPlace;
		this.timeStart = timeStart;
	}

	public BookingWeb(int booking_ID, String NumberPlate, String customerName, String startPlace, String finishPlace,
			String timeStart, String status) {
		super();
		this.booking_ID = booking_ID;
		this.numberPlate = NumberPlate;
		this.customerName = customerName;
		this.startPlace = startPlace;
		this.finishPlace = finishPlace;
		this.timeStart = timeStart;
		this.status = status;
	}

	public BookingWeb(int booking_ID, String startPlace, String finishPlace, String timeStart, String bookingDate,
			String Status) {
		super();
		this.booking_ID = booking_ID;
		this.startPlace = startPlace;
		this.finishPlace = finishPlace;
		this.timeStart = timeStart;
		this.bookingDate = bookingDate;
		this.status = Status;
		this.seatList = new ArrayList<>();
	}

}
