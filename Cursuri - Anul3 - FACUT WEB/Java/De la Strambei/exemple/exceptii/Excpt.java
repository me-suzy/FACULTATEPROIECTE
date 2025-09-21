/*
 * Excpt.java
 *
 * Created on 07 aprilie 2003, 12:10
 */

package exemple.exceptii;

/**
 *
 * @author  strimbeic
 */
public class Excpt {
    
    /** Creates a new instance of Excpt */
    public Excpt() {
    }
    public static void main(String[] args){
        try{
            int[] tablou = new int[100];
            tablou[100] = 100;
        }catch(ArrayIndexOutOfBoundsException e){
            System.out.println("Eroare la executie: index invalid pentru un element de tablou");
            e.printStackTrace();
        }
    }
}
