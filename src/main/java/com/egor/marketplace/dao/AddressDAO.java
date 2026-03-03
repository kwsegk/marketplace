package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Address;

import java.util.List;

public interface AddressDAO {
    List<Address> getAddressesByUserId(int userId);
    Address getAddressById(int id);
    void saveAddress(Address address);
    void updateAddress(Address address);
    void deleteAddress(int id);
    void setDefaultAddress(int userId, int addressId);
}
