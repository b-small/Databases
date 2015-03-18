package consoleApp;

import javax.persistence.*;


/**
 * Created by bas on 3/18/2015.
 */
public class Importer {

    public static void addItem(Object t, EntityManager entityManager) {
        entityManager.getTransaction().begin();

        entityManager.persist(t);
        entityManager.getTransaction().commit();

    }
}

