package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Booking;
import edu.fa.model.BookingWeb;

public class BookingDAOImpl implements BookingDAO {
	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public BookingDAOImpl() {
		dbConnection = JDBCUtil.getConnection();
	}

	private void finallyFunction() {

		try {
			if (cStmt != null)
				cStmt.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (dbConnection != null)
					dbConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	}

	@Override
	public int insertBooking(Booking booking) {

		try {
			cStmt = dbConnection.prepareCall("{call spInsertBooking(?, ?, ?, ?)}");
			cStmt.setInt(1, booking.getSchedule_ID());
			cStmt.setInt(2, booking.getCustomer_ID());
			cStmt.setString(3, booking.getDateStart());
			cStmt.setString(4, booking.getDescription());

			cStmt.executeUpdate();

			cStmt = dbConnection.prepareCall("{call spSelectBookingIDByBookingInfo(?, ?, ?, ?)}");
			cStmt.setInt(1, booking.getSchedule_ID());
			cStmt.setInt(2, booking.getCustomer_ID());
			cStmt.setString(3, booking.getDateStart());
			cStmt.setString(4, booking.getDescription());

			ResultSet rs = cStmt.executeQuery();
			int bookingID = 0;

			if (rs.next()) {
				bookingID = rs.getInt("Booking_ID");
			}

			for (int i = 0; i < booking.getSeatList().size(); i++) {
				cStmt = dbConnection.prepareCall("{call spInsertDetail(?, ?)}");
				cStmt.setInt(1, bookingID);
				cStmt.setInt(2, booking.getSeatList().get(i));

				cStmt.executeUpdate();
			}

			return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			finallyFunction();
		}

		return 0;
	}

	@Override
	public List<BookingWeb> getTicketBookedAvailableByStartDate(LocalDate date, int page) {

		List<BookingWeb> bookingWebList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetTicketBookedAvailableByStartDate(?,?)}");
			cStmt.setString(1, String.valueOf(date));
			cStmt.setInt(2, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {

				BookingWeb bw = new BookingWeb(rs.getString("NumberPlate"), rs.getString("FullName"),
						rs.getString("StartPlace"), rs.getString("FinishPlace"), rs.getString("StartTime"),
						rs.getInt("Booking_ID"));
				bw.setPageNumber(rs.getInt("PageNumber"));

				bookingWebList.add(bw);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return bookingWebList;
	}

	@Override
	public int cancelBooking(BookingWeb bookingWeb) {
		try {
			cStmt = dbConnection.prepareCall("{call spUpdateBooking_Cancel(?)}");
			cStmt.setInt(1, bookingWeb.getBooking_ID());

			cStmt.executeUpdate();

			return 1;

		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			finallyFunction();
		}

		return 0;
	}

	@Override
	public List<BookingWeb> getBookedByCusIDPage(int customer_ID, int page) {

		List<BookingWeb> bookingWebList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetBookedByCusIDPage(?, ?)}");
			cStmt.setInt(1, customer_ID);
			cStmt.setInt(2, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {

				BookingWeb bw = new BookingWeb(rs.getInt("Booking_ID"), rs.getString("StartPlace"),
						rs.getString("FinishPlace"), rs.getString("TimeStart"), rs.getString("BookingDate"),
						rs.getString("Status"));
				bw.setPageNumber(rs.getInt("PageNumber"));
				bookingWebList.add(bw);
			}

			for (int i = 0; i < bookingWebList.size(); i++) {
				cStmt = dbConnection.prepareCall("{call spGetSeatsByBookingID(?)}");
				cStmt.setInt(1, bookingWebList.get(i).getBooking_ID());

				rs = cStmt.executeQuery();

				while (rs.next()) {
					bookingWebList.get(i).getSeatList().add(rs.getInt("Seat"));
				}
			}

		} catch (

		SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return bookingWebList;
	}

	@Override
	public List<BookingWeb> searchBooking(String search, int page) {
		List<BookingWeb> bookingWebList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spSearchBooking(?,?)}");
			cStmt.setString(1, String.valueOf(search));
			cStmt.setInt(2, page);

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {

				BookingWeb bw = new BookingWeb(rs.getInt("Booking_ID"), rs.getString("NumberPlate"),
						rs.getString("FullName"), rs.getString("StartPlace"), rs.getString("FinishPlace"),
						rs.getString("StartTime"), rs.getString("Status"));
				bw.setPageNumber(rs.getInt("PageNumber"));

				bookingWebList.add(bw);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return bookingWebList;
	}

	@Override
	public Booking getBookingByDateStartScheduleSeat(Booking booking) {

		try {
			cStmt = dbConnection.prepareCall("{call spGetBookingByDateStartScheduleSeat(?, ?, ?)}");
			cStmt.setString(1, String.valueOf(booking.getDateStart()));
			cStmt.setInt(2, booking.getSchedule_ID());
			cStmt.setInt(3, booking.getSeatList().get(0));

			ResultSet rs = cStmt.executeQuery();
			
			if (rs.next()) {

				booking = new Booking(rs.getInt("Booking_ID"), rs.getString("BookingDate"), rs.getString("Description"), 
						rs.getString("FullName"),
						rs.getString("PhoneNumber"),
						rs.getString("Email"),
						rs.getString("Address"),
						rs.getInt("Seat"));
				
				while (rs.next()) {
					booking.getSeatList().add(rs.getInt("Seat"));
				}
			} else {
				booking = new Booking();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return booking;
	}

}
