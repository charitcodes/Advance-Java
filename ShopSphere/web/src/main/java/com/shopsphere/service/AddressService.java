package com.shopsphere.service;

import com.shopsphere.dao.AddressDAO;
import com.shopsphere.model.Address;

import java.util.List;

public class AddressService {

    private AddressDAO addressDAO;

    public AddressService() {
        addressDAO = new AddressDAO();
    }

    public List<Address> getAddressesByUserId(int userId) {
        return addressDAO.getAddressesByUserId(userId);
    }

    public void addAddress(Address address) {
        addressDAO.addAddress(address);
    }
}