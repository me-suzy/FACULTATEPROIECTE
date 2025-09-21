/*
 * ExcptNestingTry.java
 *
 * Created on 07 aprilie 2003, 12:17
 */

package exemple.exceptii;

/**
 *
 * @author  strimbeic
 */
public class ExcptNestingTry {
    
    /** Creates a new instance of ExcptNestingTry */
    public ExcptNestingTry() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            try{
                int[] tablou = new int[100];
                tablou[100] = 100;                
            }catch(ArithmeticException e){
                System.out.println("Eroare aritmetica");
            } 
        }catch(ArrayIndexOutOfBoundsException e){
            System.out.println("Eroare nested la executie");
            e.printStackTrace();
        }
    }
    
}
