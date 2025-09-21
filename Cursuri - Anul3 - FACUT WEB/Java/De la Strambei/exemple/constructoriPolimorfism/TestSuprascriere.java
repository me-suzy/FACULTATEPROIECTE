/*
 * Test.java
 *
 * Created on 24 martie 2003, 11:20
 */

package exemple.constructoriPolimorfism;
import clienti.Persoana;
/**
 *
 * @author  strimbeic
 */
public class TestSuprascriere {
    
    /** Creates a new instance of Test */
    public TestSuprascriere() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Persoana p1 = new Persoana("CNP1", "O persoana", null);
        Salariat s1 = new Salariat("CNP2", "Un salariat", null);
        Object x1 = new Object();

        System.out.println("s1= obiectul x1");
        s1.equals(x1);
        System.out.println("");

        System.out.println("s1= persoana p1");
        s1.equals(p1);
        System.out.println("");

        System.out.println("s1= salariatul x1");
        s1.equals(s1);
    }
}
