/*
 * TestCompanie_.java
 *
 * Created on 10 martie 2004, 09:13
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
public class TestCompanie_ {

    public static void main(String[] args) {
        Companie_ firma = new Companie_("R0001","o firma", "o adresa");
        System.out.println("Am creat " + firma.nume + " cu sediu la " + firma.sediu);
    }
    
}
