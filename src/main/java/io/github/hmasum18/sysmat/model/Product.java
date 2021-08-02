package io.github.hmasum18.sysmat.model;


import io.github.hmasum18.sysmat.config.WebConfiguration;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(schema = "public", name = "product")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String description;

    @ManyToOne(optional = false)
    private Category category;

    @ManyToOne(optional = false)
    private User owner;

    @Column(nullable = false)
    private String images; //comma separated image links

    @Column(nullable = false)
    private String mobileNumbers; //comma separated numbers

    @Column(nullable = false)
    private String location;

    @CreationTimestamp
    private Date created;


    @UpdateTimestamp
    private Date updated;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public  Product(){

    }
    public Product(User user){
        this.owner = user;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public String getImages() {
        return images;
    }

    @Transient
    public List<String> makeImageList(){
        return Arrays.stream(images.split(","))
                .map(String::new)
                .collect(Collectors.toList());
    }

    public void setImages(String images) {
        this.images = images;
    }

    public void setMobileNumbers(String mobileNumbers) {
        this.mobileNumbers = mobileNumbers;
    }

    public String getMobileNumbers() {
        return mobileNumbers;
    }

    @Transient
    public List<String> makeMobileNumberList(){
        return Arrays.stream(mobileNumbers.split(","))
                .map(String::new)
                .collect(Collectors.toList());
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Id
    public String getId() {
        return id;
    }

    @Transient
    public String getLogoImagePath(){
        if(makeImageList() == null || id == null || makeImageList().size() ==0){
            return null;
        }
        return WebConfiguration.IMAGE_UPLOAD_ROOT_PATH
                +"/product/"+id+"-"+name+"/"+makeImageList().get(0);
    }

    @Transient
    public List<String> getImagePathList(){
        if(makeImageList() == null || id == null || makeImageList().size() ==0){
            return null;
        }

        List<String> imageNameList = makeImageList();
        List<String> imagePathList = new ArrayList<>();
        for (String imageName : imageNameList) {
            String path = WebConfiguration.IMAGE_UPLOAD_ROOT_PATH
                    +"/product/"+id+"-"+name+"/"+imageName;
            imagePathList.add(path);
        }

        return imagePathList;
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

    @Override
    public String toString() {
        return "Product{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", category=" + category +
                ", owner=" + owner +
                ", images='" + images + '\'' +
                ", mobileNumbers='" + mobileNumbers + '\'' +
                ", location='" + location + '\'' +
                ", created=" + created +
                ", updated=" + updated +
                '}';
    }
}
