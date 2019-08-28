package edu.fa.dao;

import java.time.LocalDate;
import java.util.List;

import edu.fa.model.Booking;
import edu.fa.model.BookingWeb;

public interface BookingDAO {
	
	int insertBooking(Booking booking);
	
	List<BookingWeb> getTicketBookedAvailableByStartDate(LocalDate date,int page);
	
	int cancelBooking(BookingWeb bookingWeb);
	
	List<BookingWeb> getBookedByCusIDPage(int customer_ID, int page);
	
	List<BookingWeb> searchBooking(String search, int page);
	
	Booking getBookingByDateStartScheduleSeat(Booking booking);

}
