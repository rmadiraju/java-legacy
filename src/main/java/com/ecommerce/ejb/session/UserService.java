package com.ecommerce.ejb.session;

import com.ecommerce.ejb.entity.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Stateless
public class UserService {
    
    @PersistenceContext(unitName = "ecommercePU")
    private EntityManager entityManager;
    
    public User createUser(String username, String email, String password) {
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashPassword(password));
        
        entityManager.persist(user);
        return user;
    }
    
    public User findUserById(Long userId) {
        return entityManager.find(User.class, userId);
    }
    
    public User findUserByUsername(String username) {
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT u FROM User u WHERE u.username = :username", User.class);
        query.setParameter("username", username);
        
        List<User> users = query.getResultList();
        return users.isEmpty() ? null : users.get(0);
    }
    
    public User findUserByEmail(String email) {
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT u FROM User u WHERE u.email = :email", User.class);
        query.setParameter("email", email);
        
        List<User> users = query.getResultList();
        return users.isEmpty() ? null : users.get(0);
    }
    
    public boolean authenticateUser(String username, String password) {
        User user = findUserByUsername(username);
        if (user != null && user.getIsActive()) {
            return BCrypt.checkpw(password, user.getPassword());
        }
        return false;
    }
    
    public User updateUser(User user) {
        return entityManager.merge(user);
    }
    
    public void deleteUser(Long userId) {
        User user = findUserById(userId);
        if (user != null) {
            entityManager.remove(user);
        }
    }
    
    public List<User> getAllUsers() {
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT u FROM User u ORDER BY u.createdAt DESC", User.class);
        return query.getResultList();
    }
    
    public boolean isUsernameAvailable(String username) {
        return findUserByUsername(username) == null;
    }
    
    public boolean isEmailAvailable(String email) {
        return findUserByEmail(email) == null;
    }
    
    private String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }
}
