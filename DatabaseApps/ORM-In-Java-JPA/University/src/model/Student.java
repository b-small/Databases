package model;

import java.util.*;
import javax.persistence.*;

@Entity
@DiscriminatorValue("S")
public class Student extends Person {

    @Column(name = "FAC_NR")
    private String facultyNumber;

    @ManyToMany(mappedBy = "students")
    private Set<Course> courses = new HashSet<Course>();

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }

    public String getFacultyNumber() {
        return facultyNumber;
    }

    public void setFacultyNumber(String facultyNumber) {
        this.facultyNumber = facultyNumber;
    }

}
