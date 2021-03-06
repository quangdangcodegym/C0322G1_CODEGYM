package com.phuxuan.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.phuxuan.model.User;

public class UserDAO implements IUserDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/px_usermanager?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Quangdv180729!!";

    private static final String INSERT_USERS_SQL = "INSERT INTO users" + "  (name, email, idcountry, urlimage) VALUES " +
            " (?, ?, ?, ?);";

    private static final String SELECT_USER_BY_ID = "select id,name,email,idcountry from users where id =?";
    private static final String SELECT_ALL_USERS = "select * from users";
    private static final String DELETE_USERS_SQL = "delete from users where id = ?;";
    private static final String UPDATE_USERS_SQL = "update users set name = ?,email= ?, idcountry =? where id = ?;";

    private int noOfRecords;
    public UserDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }

	public void insertUser(User user) throws SQLException {
		
		
		
		System.out.println(INSERT_USERS_SQL);
		// try-with-resource statement will auto close the connection.
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
			
//			Statement // Không có tham so
//			PreparedStatement // Co tham số, bắt đầu từ 1, 2 , 3...
//			CallableStatement // Làm việc với store procedure
//			
			
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setInt(3, user.getIdcountry());
            preparedStatement.setString(4, user.getUrlImage());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
			
			

		} catch (SQLException e) {
			printSQLException(e);
		}
	}

    public User selectUser(int id) {
        User user = null;
        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();
             // Step 2:Create a statement using connection object
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID);) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                int idcountry = Integer.parseInt(rs.getString("idcountry"));
                user = new User(id, name, email, idcountry);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return user;
    }

    public List<User> selectAllUsers() {

        // using try-with-resources to avoid closing resources (boiler plate code)
        List<User> users = new ArrayList<>();
        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();

             // Step 2:Create a statement using connection object
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);) {
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                int idcountry = Integer.parseInt(rs.getString("idcountry"));
                users.add(new User(id, name, email, idcountry));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return users;
    }

    @Override
    public List<User> selectUsersPagging(int offset, int noOfRecords) {
        String query = "select SQL_CALC_FOUND_ROWS * from users limit "
                + offset + ", " + noOfRecords;
        List<User> list = new ArrayList<User>();
        User user = null;

        Connection connection = null;
        Statement stmt = null;
        try {
            connection  = getConnection();
            stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setIdcountry(rs.getInt("idcountry"));
                user.setName(rs.getString("name"));
                list.add(user);
            }
            rs.close();

            rs = stmt.executeQuery("SELECT FOUND_ROWS()");
            if(rs.next())
                this.noOfRecords = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally
        {
            try {
                if(stmt != null)
                    stmt.close();
                if(connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<User> selectUsersPagging(int offset, int noOfRecords, String q, int idCountry) {





        List<User> list = new ArrayList<User>();
        User user = null;

        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection  = getConnection();
            if(idCountry!=-1){
                String query = "select SQL_CALC_FOUND_ROWS * from users where name like ? and idcountry = ? limit "
                        + offset + ", " + noOfRecords;
                stmt = connection.prepareStatement(query);
                stmt.setString(1,'%' + q + '%');
                stmt.setInt(2, idCountry);
            }else{
                if(idCountry==-1){
                    String query = "select SQL_CALC_FOUND_ROWS * from users where name like ? limit "
                            + offset + ", " + noOfRecords;
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1,'%' + q + '%');
                }
            }

            System.out.println(stmt);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setIdcountry(rs.getInt("idcountry"));
                user.setName(rs.getString("name"));
                list.add(user);
            }
            rs.close();

            rs = stmt.executeQuery("SELECT FOUND_ROWS()");
            if(rs.next())
                this.noOfRecords = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally
        {
            try {
                if(stmt != null)
                    stmt.close();
                if(connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }
    public boolean deleteUser(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_USERS_SQL);) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_USERS_SQL);) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setInt(3, user.getIdcountry());
            statement.setInt(4, user.getId());

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

}
