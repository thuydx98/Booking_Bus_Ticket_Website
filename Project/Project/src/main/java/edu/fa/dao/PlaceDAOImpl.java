package edu.fa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.fa.jdbc.JDBCUtil;
import edu.fa.model.Place;

public class PlaceDAOImpl implements PlaceDAO {

	private Connection dbConnection = null;
	private CallableStatement cStmt = null;

	public PlaceDAOImpl() {
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

	// Get all Places
	@Override
	public List<Place> getPlaces() {

		List<Place> placeList = new ArrayList<>();

		try {
			cStmt = dbConnection.prepareCall("{call spGetPlaces()}");

			ResultSet rs = cStmt.executeQuery();

			while (rs.next()) {

				Place place = new Place(rs.getInt("Place_ID"), rs.getString("PlaceName"));
				placeList.add(place);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			finallyFunction();
		}

		return placeList;
	}

}
