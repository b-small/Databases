package model;

import java.util.*;
import javax.persistence.*;

/**
 * Created by bas on 3/17/2015.
 */

@Entity
@Table(name = "RESOURCES")
public class Resource {

    @Id
    @GeneratedValue
    @Column(name ="RESOURCE_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "TYPE")
    private ResourceType resourceType;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinColumn(name="COURSE_ID")
    private Set<Course> courses = new HashSet<Course>();

    public Resource() {
    }

    public Resource(String name, ResourceType type) {
        this.name = name;
        this.resourceType = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ResourceType getResourceType() {
        return resourceType;
    }

    public void setResourceType(ResourceType resourceType) {
        this.resourceType = resourceType;
    }

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }
}
