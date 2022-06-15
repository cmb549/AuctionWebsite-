
package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

	public ApplicationDB() {

	}

	public static Connection getConnection() {

		// Create a connection string
		String connectionUrl = "jdbc:mysql://localhost:3306/BuyMe";
		Connection connection = null;

		try {
			// Load JDBC driver - the interface standardizing the connection procedure. Look
			// at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			// Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl, "root", "pass@123");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return connection;

	}

	public static void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection =getConnection();

		System.out.println(connection);
		closeConnection(connection);
	}

}
