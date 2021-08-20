package io.github.hmasum18.sysmat.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.Set;
import java.util.stream.Collectors;

@Entity
@Table(schema = "public", name = "user")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //auto increment id
    private int id;

    @Column(columnDefinition = "text", nullable = false, unique = true)
    private String username;

    @Column(name = "login", columnDefinition = "text", nullable = false, unique = true)
    private String email; // email or phone number

    @Column(columnDefinition = "text", nullable = false)
    private String password;

    @Column(columnDefinition = "text")
    private String verificationCode;

    @Column(columnDefinition = "boolean", nullable = false)
    private boolean verified;

    @Column(columnDefinition = "text", nullable = false)
    private String roles; //comma separated roles

    @Version
    private int version;


    @CreationTimestamp
    private Date created;


    @UpdateTimestamp
    private Date updated;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }

    @Transient
    public UserDetails buildUserDetails(){
        Set<GrantedAuthority> grantedAuthorities = Arrays.stream(roles.split(","))
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toSet());

        org.springframework.security.core.userdetails.User.UserBuilder userBuilder = org.springframework.security.core.userdetails.User.builder();
        userBuilder.username(username)
                .password(password)
                .disabled(false)
                .authorities(grantedAuthorities);

        return userBuilder.build();
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", login='" + email + '\'' +
                /*", password='" + password + '\'' +*/
                ", verified=" + verified +
                ", roles='" + roles + '\'' +
                ", version=" + version +
                ", created=" + created +
                ", updated=" + updated +
                '}';
    }
}
