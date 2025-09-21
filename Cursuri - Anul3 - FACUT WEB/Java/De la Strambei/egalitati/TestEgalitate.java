/*
 * TestEgalitate.java
 *
 * Created on 21 aprilie 2003, 09:30
 */

package egalitati;

/**
 *
 * @author  strimbeic
 */
public class TestEgalitate {
    public static void main(String[] args) {
        // var 1 - Persoane
        /*Persoana p1 = new Persoana("CNP001", "Ion", "Viorel");
        Persoana p2 = new Persoana("CNP001", "Ion", "Viorel");
        System.out.println("p1==p2 --> " + (p1 == p2));
        System.out.println("p1.equals(p2) --> " + p1.equals(p2));*/
        // var 2 - Studenti
        Student s1 = new Student("CNP001", "MT001", "Ion", "Viorel", "Spec1");
        Student s2 = new Student("CNP001", "MT002", "Ion", "Viorel", "Spec2");
        
        System.out.println("s1.equals((Persoana)s2) -->" + s1.equals((Persoana)s2));
        System.out.println("s1.equals(s2) --> " + s1.equals(s2));
    }
}

class Persoana{
    public String cnp;
    public String nume;
    public String prenume;
    public Persoana(String pCnp, String pNume, String pPrenume){
        cnp = pCnp;
        nume = pNume;
        prenume = pPrenume;
    }
    public boolean equals(Object obj){
        if (obj instanceof Persoana)
            return (cnp == ((Persoana)obj).cnp);
        else
            return false;
    }    
}
class Student extends Persoana{
    public String matricol;
    public String specializare;
    
    public Student(String pCnp, String pMatricol, String pNume, 
    String pPrenume, String pSpecializare){
        super(pCnp, pNume, pPrenume);
        matricol = pMatricol;
        specializare = pSpecializare;
    }
    public boolean equals(Student stud){
        return (matricol == stud.matricol);
   }
}