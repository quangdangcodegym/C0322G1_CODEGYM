package com.phuxuan.dao;

import java.sql.SQLException;
import java.util.List;

import com.phuxuan.model.User;

public interface IUserDAO {
	public void insertUser(User user) throws SQLException;

    public User selectUser(int id);

    public List<User> selectAllUsers();

    public List<User> selectUsersPagging(int offset, int noOfRecords);

    public boolean deleteUser(int id) throws SQLException;

    public boolean updateUser(User user) throws SQLException;

}