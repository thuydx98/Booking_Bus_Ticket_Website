package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Booking;
import edu.fa.model.Time;

public class TimeDAOImpl implements TimeDAO {

	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public TimeDAOImpl() {
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
	public List<Time> getTimeByPlaceDateAmount(Time time) {

		List<Time> timeList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetTimeByPlaceDateAmount(?, ?, ?, ?)}");
			cStmt.setInt(1, time.getStartPlace());
			cStmt.setInt(2, time.getFinishPlace());
			cStmt.setString(3, String.valueOf(time.getDateStart()));
			cStmt.setInt(4, time.getAmount());

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {

				Time timeResult = new Time(rs.getInt("Schedule_ID"), rs.getString("TypeName"), rs.getString("TimeStart"));
				timeList.add(timeResult);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return timeList;
	}

	@Override
	public Booking getBusTypeBookedSeatsByPlaceTimeDate(Time time) {

		Booking booking = new Booking();

		try {
			cStmt = dbConnection.prepareCall("{call spGetBusTypeBookedSeatsByPlaceTimeDate(?, ?)}");
			cStmt.setInt(1, time.getSchedule_ID());
			cStmt.setString(2, String.valueOf(time.getDateStart()));


			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {
				booking.setBusType(rs.getString("Bus_ID"));
				booking.getSeatList().add(rs.getInt("Seat"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return booking;

	}

}
