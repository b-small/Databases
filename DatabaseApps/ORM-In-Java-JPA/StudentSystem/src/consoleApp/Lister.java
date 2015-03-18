package consoleApp;

import model.*;

import java.util.*;
import java.util.stream.*;
import javax.persistence.*;


/**
 * Created by bas on 3/18/2015.
 */
public class Lister {

    public static void printStudents(EntityManager entityManager) {
        Query queryStudents = entityManager.createQuery("select s from Student s");

        List<Student> students = queryStudents.getResultList();
        for (Student stud : students) {
            Set<Course> courses = stud.getCourses();
            Set<Homework> hws = stud.getHomeworkSubmissions();

            String coursesStr = courses.stream().map(c -> c.getName())
                    .collect(Collectors.joining("; "));
            String hwStr = hws.stream().map(hw -> hw.getContent())
                    .collect(Collectors.joining("; "));

            System.out.printf(" - Id: %d, Name: %s\n" +
                    "   Courses: %s\n   Homework: %s\n", stud.getId(), stud
                    .getName(), coursesStr, hwStr);
        }
    }

    public static void printCourses(EntityManager entityManager) {
        Query queryCourses = entityManager.createQuery("select c from Course c");

        List<Course> courses = queryCourses.getResultList();
        for (Course course : courses) {

            Set<Resource> resources = course.getResources();

            String resourcesStr = resources.stream().map(r -> r.getName())
                    .collect(Collectors.joining("; "));

            System.out.printf(" > Id: %d, Name: %s\n" +
                    "   Resources: %s\n", course.getId(), course.getName(), resourcesStr);
        }
    }

    public static void printHomework(EntityManager entityManager) {
        Query queryHomework = entityManager.createQuery("select h from Homework h");
        List<Homework> hw = queryHomework.getResultList();

        for (Homework h : hw) {
            System.out.printf("--> %s, Student: %s, Course: %s\n",
                    h.getContent(), h.getStudent().getName(), h.getCourse().getName());
        }
    }
}



