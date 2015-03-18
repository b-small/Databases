package model;

import java.util.*;
import javax.persistence.*;

@Entity
@Table(name = "DEPARTMENTS")
public class Department {

    @Id
    @GeneratedValue
    @Column(name = "DEPARTMENT_ID")
    private long deptId;

    @Column(name = "NAME")
    private String name;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "PROFESSOR_ID")
    private Set<Professor> professors = new HashSet<Professor>();

    @OneToMany(mappedBy = "department")
    private Set<Course> courses = new HashSet<Course>();

    public Department(String name) {
        this.name = name;
    }

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }

    public long getDeptId() {
        return deptId;
    }

    public void setDeptId(long deptId) {
        this.deptId = deptId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Professor> getProfessors() {
        return professors;
    }

    public void setProfessors(Set<Professor> professors) {
        this.professors = professors;
    }
}
