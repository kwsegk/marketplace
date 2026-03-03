package com.egor.marketplace.service;

import com.egor.marketplace.dao.AddressDAO;
import com.egor.marketplace.dao.UserDAO;
import com.egor.marketplace.entity.Address;
import com.egor.marketplace.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressDAO addressDAO;

    @Autowired
    private UserDAO userDAO;

    @Override
    @Transactional
    public List<Address> getAddressesByUserId(int userId) {
        return addressDAO.getAddressesByUserId(userId);
    }

    @Override
    @Transactional
    public Address getAddressById(int id) {
        return addressDAO.getAddressById(id);
    }

    @Override
    @Transactional
    public void addAddress(Address address, int userId) {
        User user = userDAO.getUserById(userId);
        address.setUser(user);
        addressDAO.saveAddress(address);
    }

    @Override
    @Transactional
    public void updateAddress(Address address) {
        addressDAO.updateAddress(address);
    }

    @Override
    @Transactional
    public void deleteAddress(int id) {
        addressDAO.deleteAddress(id);
    }

    @Override
    @Transactional
    public void setDefaultAddress(int userId, int addressId) {
        addressDAO.setDefaultAddress(userId, addressId);
    }
}
