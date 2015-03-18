package model;

import java.util.*;
import javax.persistence.*;

/**
 * Created by bas on 3/17/2015.
 */

@Entity
@Table(name = "STUDENTS")
public class Student {

    @Id
    @GeneratedValue
    @Column(name="STUDENT_ID")
    private int id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "PHONE_NUMBER")
    private String phoneNumber;

    @Column(name = "REG_DATE")
    private Date regDate = new Date();

    @Column(name = "BIRTHDAY")
    private Date birthday = new Date();

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinColumn(name="COURSE_ID")
    private Set<Course> courses = new HashSet<Course>();

    @OneToMany(mappedBy = "student")
    private Set<Homework> homeworkSubmissions = new HashSet<Homework>();

    public Student() {
    }

    public Student(String name, String phone, Date regDate, Date birthday) {
        this.name = name;
        this.phoneNumber = phone;
        this.regDate = regDate;
        this.birthday = birthday;
        this.courses = courses;
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

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }

    public Set<Homework> getHomeworkSubmissions() {
        return homeworkSubmissions;
    }

    public void setHomeworkSubmissions(Set<Homework> homeworkSubmissions) {
        this.homeworkSubmissions = homeworkSubmissions;
    }
}
