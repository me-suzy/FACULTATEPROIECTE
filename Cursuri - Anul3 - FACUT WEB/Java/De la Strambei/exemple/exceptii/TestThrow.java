/*
 * TestThrow.java
 *
 * Created on 07 aprilie 2003, 12:20
 */

package exemple.exceptii;

/**
 *
 * @author  strimbeic
 */
public class TestThrow {
    
    /** Creates a new instance of TestThrow */
    public TestThrow() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            System.out.println("Inainte de generarea unei exceptii");
            throw new Exception();
            //System.out.println("Local: dupa generarea unei exceptii");
        }catch(Exception e){
            System.out.println("Din contextul exceptiei generate explicit");
        }
        System.out.println("Dupa generarea-tratarea unei exceptii");
    }
    
}
