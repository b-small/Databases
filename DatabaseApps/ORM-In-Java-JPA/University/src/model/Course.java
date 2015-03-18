package model;

import java.util.*;
import javax.persistence.*;

@Entity
@Table(name = "COURSES")
public class Course {

    @Id
    @GeneratedValue
    private long courseId;

    @Column(name = "NAME")
    private String name;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ID")
    private Professor professor;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "DEPARTMENT_ID")
    private Department department;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "ID")
    private Set<Student> students = new HashSet<Student>();

    public long getCourseId() {
        return courseId;
    }

    public void setCourseId(long courseId) {
        this.courseId = courseId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Professor getProfessor() {
        return professor;
    }

    public void setProfessor(Professor professor) {
        this.professor = professor;
    }

    public Set<Student> getStudents() {
        return students;
    }

    public void setStudents(Set<Student> students) {
        this.students = students;
    }
}
