package com.nhom06.dao;

import java.sql.*;
import com.nhom06.model.*;

public class UserDao {
	private Connection con;

	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	//private Statement st;

	public UserDao(Connection con) {
		this.con = con;
	}

	public User userLogin(String email, String password) {
		User user = null;
		try {
			query = "select * from users where username=? and password=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setFullname(rs.getString("full_name"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("phone"));
			}
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		return user;
	}

	public boolean userRegister(User user) {
		try {
			query = "insert into users (username, password, full_name, address, email, phone) value (?, ?, ?, ?, ?, ?)";
			pst = this.con.prepareStatement(query);
			pst.setString(1, user.getUsername());
			pst.setString(2, user.getPassword());
			pst.setString(3, user.getFullname());
			pst.setString(4, user.getAddress());
			pst.setString(5, user.getEmail());
			pst.setString(6, user.getPhone());
			int rowCount = pst.executeUpdate();		
			
			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		return true;
	}
	
	public boolean editProfile(User user, int id) {
		try {
			query = "update users set password=?, full_name=?, address=?, email=?, phone=? where id=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, user.getPassword());
			pst.setString(2, user.getFullname());
			pst.setString(3, user.getAddress());
			pst.setString(4, user.getEmail());
			pst.setString(5, user.getPhone());
			pst.setInt(6, id);
			
			int rowCount = pst.executeUpdate();		
			
			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		return true;
	}

	public boolean userDelete(int id) {
		try {
			query = "delete from users where id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			int rowCount = pst.executeUpdate();
			if (rowCount == 0) {
				return false;
			}

		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		return true;
	}
}
