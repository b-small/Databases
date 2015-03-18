package model;

import java.util.*;
import javax.persistence.*;

@Entity
@DiscriminatorValue("P")
public class Professor extends Person {

    @Column(name = "TITLE")
    private String title;

    @ManyToMany(mappedBy = "professors")
    private Set<Department> departments = new HashSet<Department>();

    @OneToMany(mappedBy = "professor")
    private Set<Course> courses = new HashSet<Course>();

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }

    public Set<Department> getDepartments() {
        return departments;
    }

    public void setDepartments(Set<Department> departments) {
        this.departments = departments;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
