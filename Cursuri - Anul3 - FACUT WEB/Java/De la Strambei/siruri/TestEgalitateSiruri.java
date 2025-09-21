/*
 * TestEgalitateSiruri.java
 * * Created on 18 aprilie 2003, 14:55
 */

package siruri;

/**
 *
 * @author  strimbeic
 */
public class TestEgalitateSiruri {
    
    /** Creates a new instance of TestEgalitateSiruri */
    public TestEgalitateSiruri() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String sir1 = "Primul";
        String sir2 = "Altul";
        String sir3 = sir2;
        String sir4 = "Altul";
        String sir5 = "primul";
        String sir6 = new String("Primul");
        
        System.out.println("Identitate: sir1==sir3 --> " + (sir1==sir3));
        System.out.println("Egalitate: sir1.equals(sir3) --> " + (sir1.equals(sir3)));
        System.out.println("Identitate: sir2==sir4 --> " + (sir2==sir4));
        System.out.println("Egalitate: sir2.equals(sir4) --> " + (sir2.equals(sir4)));
        System.out.println("Identitate: sir1==sir5 --> " + (sir1==sir5));
        System.out.println("Egalitate: sir1.equalsIgnoreCase(sir5) --> " + (sir1.equalsIgnoreCase(sir5)));
        System.out.println("Identitate: sir1==sir6 --> " + (sir1==sir6));
        System.out.println("Egalitate: sir1.equals(sir6) --> " + (sir1.equals(sir6)));        
    }
    
}
