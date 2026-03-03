package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDAOImpl implements ProductDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Product> getAllProducts() {
        return entityManager.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.user WHERE p.quantity > 0", Product.class)
                .getResultList();
    }

    @Override
    public List<Product> getAllProductsByUserId(int userId) {
        return entityManager.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.user WHERE p.user.id = :userId", Product.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public List<Product> searchAndFilterProducts(String search, String sortBy, Integer excludeUserId) {
        StringBuilder jpql = new StringBuilder("SELECT p FROM Product p LEFT JOIN FETCH p.user LEFT JOIN FETCH p.reviews WHERE p.quantity > 0");
        
        // Исключаем товары конкретного пользователя (для продавца)
        if (excludeUserId != null) {
            jpql.append(" AND (p.user IS NULL OR p.user.id != :excludeUserId)");
        }
        
        // Поиск по названию (case-insensitive)
        if (search != null && !search.trim().isEmpty()) {
            jpql.append(" AND LOWER(p.name) LIKE :search");
        }
        
        // Сортировка
        if (sortBy != null) {
            switch (sortBy) {
                case "date_desc":
                    jpql.append(" ORDER BY p.id DESC");
                    break;
                case "date_asc":
                    jpql.append(" ORDER BY p.id ASC");
                    break;
                case "price_asc":
                    jpql.append(" ORDER BY p.price ASC");
                    break;
                case "price_desc":
                    jpql.append(" ORDER BY p.price DESC");
                    break;
                default:
                    jpql.append(" ORDER BY p.id DESC");
            }
        } else {
            jpql.append(" ORDER BY p.id DESC");
        }
        
        var query = entityManager.createQuery(jpql.toString(), Product.class);
        
        if (excludeUserId != null) {
            query.setParameter("excludeUserId", excludeUserId);
        }
        
        if (search != null && !search.trim().isEmpty()) {
            query.setParameter("search", "%" + search.toLowerCase() + "%");
        }
        
        List<Product> products = query.getResultList();
        
        // Сортировка по рейтингу выполняется в Java, т.к. это вычисляемое поле
        if ("rating_desc".equals(sortBy) || "rating_asc".equals(sortBy)) {
            products.sort((p1, p2) -> {
                double avg1 = calculateAverageRating(p1);
                double avg2 = calculateAverageRating(p2);
                return "rating_desc".equals(sortBy) ? Double.compare(avg2, avg1) : Double.compare(avg1, avg2);
            });
        }
        
        return products;
    }
    
    private double calculateAverageRating(Product product) {
        if (product.getReviews() == null || product.getReviews().isEmpty()) {
            return 0.0;
        }
        return product.getReviews().stream()
                .mapToInt(review -> review.getRating())
                .average()
                .orElse(0.0);
    }

    @Override
    public Product getProductById(int id) {
        return entityManager.find(Product.class, id);
    }

    @Override
    public boolean hasOrderItems(int productId) {
        Long count = entityManager.createQuery(
                "SELECT COUNT(oi) FROM OrderItem oi WHERE oi.product.id = :productId", Long.class)
                .setParameter("productId", productId)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public void saveProduct(Product product) {
        entityManager.persist(product);
    }

    @Override
    public void updateProduct(Product product) {
        entityManager.merge(product);
    }

    @Override
    public void deleteProduct(int id) {
        Product product = getProductById(id);
        entityManager.remove(product);
    }
}
