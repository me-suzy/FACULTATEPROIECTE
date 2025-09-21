/*
 * TestSet.java
 *
 * Created on 29 mai 2003, 11:33
 */

package colectii;
import java.util.*;
/**
 *
 * @author  strimbeic
 */
public class TestSet {
    
    /** Creates a new instance of TestSet */
    public TestSet() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Collection c = new TreeSet();
        c.add("A");
        c.add("X");
        c.add("x");
        c.add("a");
        c.add("A");
        c.add("X");
        c.add("x");
        c.add("a");        
        Iterator iterator = c.iterator();
        while (iterator.hasNext()){
            System.out.println(iterator.next());
        }
    }
    
}
