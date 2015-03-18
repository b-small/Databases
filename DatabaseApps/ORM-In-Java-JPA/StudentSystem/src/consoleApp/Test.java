package consoleApp;

import model.*;

import java.text.*;
import java.util.*;
import javax.persistence.*;

/**
 * Created by bas on 3/18/2015.
 */
public class Test {

    public static void main(String[] args) {

        EntityManagerFactory factory = Persistence.createEntityManagerFactory("model");

        try {

            EntityManager eManager = factory.createEntityManager();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

            Student student1 = new Student("Pesho", "0886908291", new Date(), dateFormat.parse("27/09/1990"));
            Student student2 = new Student("Milko", "0886934691", new Date(), dateFormat.parse("27/09/1970"));
            Student student3 = new Student("Jivka", "08824411", new Date(), dateFormat.parse("27/09/1983"));

            Course course1 = new Course("JavaSE", "JavaSE Introduction", new Date(), dateFormat.parse("27/09/2015"), 200);
            Course course2 = new Course("Python", "Python Introduction", new Date(), dateFormat.parse("23/09/2015"), 210);
            Course course3 = new Course("Obj C", "", new Date(), dateFormat.parse("27/09/2015"), 250);

            Homework hw1 = new Homework("Define a datatype blabla", ContentType.PDF);

            Resource resource1 = new Resource("Python book", ResourceType.Document);
            Resource resource2 = new Resource("Obj C fundamentals", ResourceType.Presentation);

            hw1.setStudent(student1);

            course2.setResources(new HashSet<Resource>() {{
                add(resource1);
            }});
            course3.setResources(new HashSet<Resource>() {{
                add(resource2);
            }});


            course1.setHomeworkSubmissions(new HashSet<Homework>() {{
                add(hw1);
            }});
            hw1.setCourse(course1);
            hw1.setStudent(student1);

            student1.setHomeworkSubmissions(new HashSet<Homework>() {{
                add(hw1);
            }});

            course1.setStudents(new HashSet<Student>() {{
                add(student1);
            }});
            course2.setStudents(new HashSet<Student>() {{
                add(student1);
                add(student2);
            }});
            course3.setStudents(new HashSet<Student>() {{
                add(student1);
                add(student2);
                add(student3);
            }});

            student3.setCourses(new HashSet<Course>() {{
                add(course3);
            }});
            student2.setCourses(new HashSet<Course>() {{
                add(course2);
                add(course3);
            }});
            student1.setCourses(new HashSet<Course>() {{
                add(course1);
                add(course2);
                add(course3);
            }});

            Importer.addItem(hw1, eManager);
            Importer.addItem(student1, eManager);
            Importer.addItem(student2, eManager);
            Importer.addItem(student3, eManager);
            Importer.addItem(course1, eManager);
            Importer.addItem(course2, eManager);
            Importer.addItem(course3, eManager);

            System.out.println("<< Students >>");
            Lister.printStudents(eManager);
            System.out.println("\n<< Courses >>");
            Lister.printCourses(eManager);
            System.out.println("\n<< Homework >>");
            Lister.printHomework(eManager);

            eManager.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            factory.close();
        }
    }
}
