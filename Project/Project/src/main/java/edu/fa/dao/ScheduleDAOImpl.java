package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Schedule;

public class ScheduleDAOImpl implements ScheduleDAO {

	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public ScheduleDAOImpl() {
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
	public List<Schedule> getSchedule() {
		List<Schedule> scheduleList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetSchedule()}");

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {

				Schedule schedule = new Schedule(rs.getInt("Schedule_ID"), rs.getString("TimeStart"),
						rs.getString("StartPlace"), rs.getString("FinishPlace"), rs.getString("NumberPlate"), rs.getString("TypeName"));
				scheduleList.add(schedule);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return scheduleList;
	}

}
