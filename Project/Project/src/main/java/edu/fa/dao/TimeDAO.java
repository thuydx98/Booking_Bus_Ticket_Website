package edu.fa.dao;

import java.util.List;

import edu.fa.model.Booking;
import edu.fa.model.Time;

public interface TimeDAO {
	List<Time> getTimeByPlaceDateAmount(Time time);

	Booking getBusTypeBookedSeatsByPlaceTimeDate(Time time);
}
