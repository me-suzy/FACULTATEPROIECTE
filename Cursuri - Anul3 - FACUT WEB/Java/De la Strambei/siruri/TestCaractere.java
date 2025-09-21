/*
 * TestCaractere.java
 *
 * Created on 18 aprilie 2003, 10:19
 */

package siruri;

/**
 *
 * @author  strimbeic
 */
public class TestCaractere {
    
    /** Creates a new instance of TestCaractere */
    public TestCaractere() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        char caracter = 'z';
        System.out.println(caracter);
        System.out.println((int)caracter);
        int cod = 122;
        System.out.println(cod);
        System.out.println((char)cod);
        String c = new String(String.valueOf(new char[]{'a', 'b', 'c'}));
        System.out.println(c);
    }
    
    
}
