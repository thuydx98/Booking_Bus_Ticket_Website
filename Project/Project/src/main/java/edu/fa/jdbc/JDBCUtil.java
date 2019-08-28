package edu.fa.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
	private final static String JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private final static String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=BookingBusTicketSystem;integratedSecurity=true";
	static Connection connection = null;

	public static Connection getConnection() {
		try {
			if (connection == null || connection.isClosed()) {
				try {
					// Register JDBC Driver
					Class.forName(JDBC_DRIVER);
					// Open Connection
					connection = DriverManager.getConnection(DB_URL);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
	}
}
