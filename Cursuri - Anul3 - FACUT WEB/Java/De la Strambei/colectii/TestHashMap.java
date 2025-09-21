/*
 * TestHashMap.java
 *
 * Created on 29 mai 2003, 13:20
 */

package colectii;
import java.util.*;
/**
 *
 * @author  strimbeic
 */
public class TestHashMap {
    
    /** Creates a new instance of TestHashMap */
    public TestHashMap() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String[] coduri = {"IS", "BC", "PN", "BT", "SV"};
        String[] judete = {"Iasi", "Bacau", "Piatra-Neamt", "Botosani", "Suceava"};
        Map indicative = new HashMap();
        
        // populez indicative
        for (int i=0; i<coduri.length; i++)
            indicative.put(coduri[i], judete[i]);

       // parcurg cele trei perspective ale containerului
       // mai intai cheile
       Set chei = indicative.keySet();
       Iterator iterator = chei.iterator();
       System.out.println("Cheile:");
       while(iterator.hasNext())
           System.out.println(iterator.next());
       // apoi valorile
       Collection valori = indicative.values();
       iterator = valori.iterator();
       System.out.println("Valorile:");
       while(iterator.hasNext())
           System.out.println(iterator.next());
       // in fine setul de perechi chei-valoare
       Set intrari = indicative.entrySet();
       iterator = intrari.iterator();
       System.out.println("Perechile cheie-valoare:");
       while(iterator.hasNext()){
           java.util.Map.Entry intrare = (java.util.Map.Entry) iterator.next();
           System.out.println(intrare.getKey() + "-" + intrare.getValue());
       }
       // extrag o valoare cunoscindu-i cheia
       String id = "IS";
       System.out.println("Indicativul " + id + " corespunde judetului " + indicative.get(id));
    }
    
}
