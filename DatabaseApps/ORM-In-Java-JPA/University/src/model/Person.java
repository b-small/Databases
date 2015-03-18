package model;

import javax.persistence.*;

@Entity
@Inheritance
@DiscriminatorColumn(name = "PERSON_TYPE")
@Table(name = "PROJECT")
public abstract class Person {

    @Id
    @GeneratedValue
    @Column(name = "ID")
    private long personId;

    @Column(name = "FIRST_NAME")
    private String firstName;

    @Column(name = "LAST_NAME")
    private String lastName;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public long getPersonId() {
        return personId;
    }

    public void setPersonId(long personId) {
        this.personId = personId;
    }
}
