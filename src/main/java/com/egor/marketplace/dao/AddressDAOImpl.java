package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Address;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AddressDAOImpl implements AddressDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Address> getAddressesByUserId(int userId) {
        return entityManager.createQuery(
                "SELECT a FROM Address a WHERE a.user.id = :userId ORDER BY a.isDefault DESC, a.id", Address.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public Address getAddressById(int id) {
        return entityManager.find(Address.class, id);
    }

    @Override
    public void saveAddress(Address address) {
        entityManager.persist(address);
    }

    @Override
    public void updateAddress(Address address) {
        entityManager.merge(address);
    }

    @Override
    public void deleteAddress(int id) {
        Address address = getAddressById(id);
        if (address != null) {
            entityManager.remove(address);
        }
    }

    @Override
    public void setDefaultAddress(int userId, int addressId) {
        entityManager.createQuery("UPDATE Address a SET a.isDefault = false WHERE a.user.id = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
        
        entityManager.createQuery("UPDATE Address a SET a.isDefault = true WHERE a.id = :addressId")
                .setParameter("addressId", addressId)
                .executeUpdate();
    }
}
