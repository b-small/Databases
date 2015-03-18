import model.*;

import java.util.*;
import java.util.stream.*;
import javax.persistence.*;

public class HibernateDemo {

    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("university");

        try {
            EntityManager entityManager = factory.createEntityManager();

            Department dept1 = new Department("CS");

            Student student = new Student();
            student.setFirstName("Ivan");
            student.setLastName("Ivanov");
            student.setFacultyNumber("123");
            addItem(student, entityManager);
            addItem(dept1, entityManager);

            listDepartments(entityManager);
            listStudents(entityManager);

            entityManager.close();
        } finally {
            factory.close();
        }
    }

    public static void addItem(Object t, EntityManager entityManager) {
        entityManager.getTransaction().begin();

        entityManager.persist(t);
        entityManager.getTransaction().commit();
    }

    private static void listDepartments(EntityManager entityManager) {
        System.out.println("Departments:");

        Query departmentQuery = entityManager.createQuery(
                "Select d from Department d");

        List<Department> departments = departmentQuery.getResultList();

        for (Department dept : departments) {
            Set<Course> courses = dept.getCourses();

            String coursesStr = courses.stream().map(c -> c.getName())
                    .collect(Collectors.joining("; "));

            Set<Professor> professors = dept.getProfessors();
            String profStr = professors.stream().map(p -> p.getFirstName() + " " + p.getLastName())
                    .collect(Collectors.joining("; "));

            System.out.printf(" - Id=%d, Name=%s, \n" +
                            "   Courses: %s\n   Professors: %s",
                    dept.getDeptId(), dept.getName(),
                    coursesStr, profStr);
        }
    }

    private static void listStudents(EntityManager entityManager) {
        System.out.println("Students with courses:");

        Query studentsQuery = entityManager.createQuery(
                "Select s from Student s");

        List<Student> students = studentsQuery.getResultList();

        for (Student stud : students) {
            Set<Course> courses = stud.getCourses();
            String coursesStr = courses.stream().map(c -> c.getName())
                    .collect(Collectors.joining("; "));
            System.out.printf(" - Id=%d, FirstName=%s, LastName=%s, FN=%s\n" +
                    "   Courses: %s\n", stud.getPersonId(), stud
                    .getFirstName(), stud.getLastName(), stud
                    .getFacultyNumber(), coursesStr);
        }
    }
}
