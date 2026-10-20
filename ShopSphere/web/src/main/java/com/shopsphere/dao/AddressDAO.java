package com.shopsphere.dao;

import com.shopsphere.model.Address;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {

    public List<Address> getAddressesByUserId(int userId) {

        List<Address> addresses = new ArrayList<>();

        String sql = "SELECT * FROM addresses WHERE user_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Address address = new Address();

                    address.setAddressId(rs.getInt("address_id"));
                    address.setUserId(rs.getInt("user_id"));
                    address.setAddressLine(rs.getString("address_line"));
                    address.setCity(rs.getString("city"));
                    address.setState(rs.getString("state"));
                    address.setPincode(rs.getString("pincode"));

                    addresses.add(address);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return addresses;
    }

    public void addAddress(Address address) {

        String sql = "INSERT INTO addresses " +
                     "(user_id, address_line, city, state, pincode) VALUES (?, ?, ?, ?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getAddressLine());
            ps.setString(3, address.getCity());
            ps.setString(4, address.getState());
            ps.setString(5, address.getPincode());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}