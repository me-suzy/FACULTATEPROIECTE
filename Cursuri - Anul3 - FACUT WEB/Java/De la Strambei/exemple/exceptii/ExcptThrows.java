/*
 * ExcptThrows.java
 *
 * Created on 07 aprilie 2003, 12:14
 */

package exemple.exceptii;

/**
 *
 * @author  strimbeic
 */
public class ExcptThrows {
    
    /** Creates a new instance of ExcptThrows */
    public ExcptThrows() {
    }
    static void creareTablou() throws Exception {
        int[] tablou = new int[100];
        tablou[100] = 100;        
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            creareTablou();
        }catch(Exception e){
            System.out.println("Eroare la executie" + e.getLocalizedMessage());
            e.printStackTrace();
        }
    }
    
}
