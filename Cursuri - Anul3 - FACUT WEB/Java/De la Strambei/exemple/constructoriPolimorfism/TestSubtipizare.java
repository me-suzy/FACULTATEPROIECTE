/*
 * TestSubtipizare.java
 *
 * Created on 17 martie 2004, 09:26
 */

package exemple.constructoriPolimorfism;

import clienti.Persoana;
/**
 *
 * @author  strimbeic
 */
public class TestSubtipizare {
    
    public static void main(String args[]) {
        Salariat s = new Salariat();
        Persoana p;
        p = s;
        if (s instanceof Persoana)
            ((Persoana)s).stabContBanca(null, null);
        
    }
    
}
