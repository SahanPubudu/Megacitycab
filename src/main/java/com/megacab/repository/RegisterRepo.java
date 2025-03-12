package com.megacab.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.megacab.model.RegisterModel;

public class RegisterRepo {
    
    public String saveUser(RegisterModel registerModel) {
        Connection con = null;  // Declare inside the method to avoid potential reuse issues
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/?user=root", "root", "root");

            String sql = "INSERT INTO registered_user_details (name,nic,address, password) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, registerModel.getUserType());
            pst.setString(2, registerModel.getUserEmail());
            pst.setString(3, registerModel.getUserTel());
            pst.setString(4, registerModel.getuPass());

            int rowCount = pst.executeUpdate();
            return (rowCount > 0) ? "Registration Successful" : "Registration Unsuccessful";

        } catch (Exception e) {
            return "Error Occurred in RegisterRepo.saveUser: " + e.getMessage();
        } finally {
            // Check if the connection is not null before closing
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
