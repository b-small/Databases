package model;

import java.util.*;
import javax.persistence.*;

/**
 * Created by bas on 3/17/2015.
 */

@Entity
@Table(name = "COURSES")
public class Course {

    @Id
    @GeneratedValue
    @Column(name="COURSE_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "START_DATE")
    private Date startDate;

    @Column(name = "END_DATE")
    private Date endDate;

    @Column(name = "PRICE")
    private double price;

    @ManyToMany(mappedBy = "courses")
    private Set<Student> students = new HashSet<Student>();

    @ManyToMany(mappedBy = "courses")
    private Set<Resource> resources = new HashSet<Resource>();

    @OneToMany(mappedBy = "course")
    private Set<Homework> homeworkSubmissions = new HashSet<Homework>();

    public Course() {
    }

    public Course(String name, String descr, Date start, Date end, double price) {
        this.name = name;
        this.description = descr;
        this.startDate = start;
        this.endDate = end;
        this.price = price;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Set<Student> getStudents() {
        return students;
    }

    public void setStudents(Set<Student> students) {
        this.students = students;
    }

    public Set<Resource> getResources() {
        return resources;
    }

    public void setResources(Set<Resource> resources) {
        this.resources = resources;
    }

    public Set<Homework> getHomeworkSubmissions() {
        return homeworkSubmissions;
    }

    public void setHomeworkSubmissions(Set<Homework> homeworkSubmissions) {
        this.homeworkSubmissions = homeworkSubmissions;
    }
}
