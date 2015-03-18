package model;

import javax.persistence.*;

/**
 * Created by user on 3/17/2015.
 */

@Entity
@Table(name = "HOMEWORK")
public class Homework {

    @Id
    @GeneratedValue
    private int id;

    @Column(name = "CONTENT")
    private String content;

    @Column(name = "TYPE")
    private ContentType contentType;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "COURSE_ID")
    private Course course;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "STUDENT_ID")
    private Student student;

    public Homework() {

    }

    public Homework(String content, ContentType contentType) {
        this.content = content;
        this.contentType = contentType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public ContentType getContentType() {
        return contentType;
    }

    public void setContentType(ContentType contentType) {
        this.contentType = contentType;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }
}
