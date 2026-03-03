package com.egor.marketplace.service;

import com.egor.marketplace.entity.Address;

import java.util.List;

public interface AddressService {
    List<Address> getAddressesByUserId(int userId);
    Address getAddressById(int id);
    void addAddress(Address address, int userId);
    void updateAddress(Address address);
    void deleteAddress(int id);
    void setDefaultAddress(int userId, int addressId);
}
