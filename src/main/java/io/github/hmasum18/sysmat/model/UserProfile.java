package io.github.hmasum18.sysmat.model;

import javax.persistence.*;

@Entity
@Table(schema = "public", name = "profile")
public class UserProfile {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //auto increment id
    private int id;

    @OneToOne(optional = false)
    private User user;

    @Column(columnDefinition = "text")
    private String address;

    @Column(columnDefinition = "text")
    private String contact;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    @Override
    public String toString() {
        return "UserProfile{" +
                "id=" + id +
                ", userName=" + (user!=null? user.getUsername():"") +
                ", address='" + address + '\'' +
                ", contact='" + contact + '\'' +
                '}';
    }
}
