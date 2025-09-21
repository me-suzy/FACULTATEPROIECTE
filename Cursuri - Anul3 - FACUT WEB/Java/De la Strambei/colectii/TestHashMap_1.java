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
public class TestHashMap_1 {

    public static void main(String[] args) {
        Cod[] coduri = {new Cod(232, "IS"), new Cod(234,"BC"), new Cod(233, "PN")
            , new Cod(231, "BT"), new Cod(230, "SV")};
        Judet[] judete = {new Judet("Iasi", "Iasi"), new Judet("Bacau", "Bacau"), 
            new Judet("Piatra", "Piatra-Neamt"), new Judet("Botosani", "Botosani"),
            new Judet("Suceava", "Suceava")};
        Map indicative = new HashMap();
        
        // populez indicative
        for (int i=0; i<coduri.length; i++)
            indicative.put(coduri[i], judete[i]);
        
       // extrag o valoare cunoscindu-i cheia
       Cod cod = new Cod(232, "IS");
       if (indicative.containsKey(cod))
            System.out.println("Indicativul " + cod + 
            " corespunde judetului " + indicative.get(cod));
       else
           System.out.println("Nu gasesc cheia " + cod);
    }   
}
class Cod{
    private int nrCod;
    private String sirCod;
    public Cod(int pNrCod, String pSirCod){
        nrCod = pNrCod;
        sirCod = pSirCod;
    }
    public String toString(){
        return sirCod;
    }
    public Integer indicativNumeric(){
        return new Integer(nrCod);
    }
    
    public int hashCode(){
        return indicativNumeric().intValue();
    }
    
    public boolean equals(Object o){
        return (o instanceof Cod)&&
            (this.indicativNumeric().intValue() == ((Cod)o).indicativNumeric().intValue());
    }
    
}
class Judet{
    private String nume;
    private String resedinta;
    public Judet(String pNume, String pResedinta){
        nume = pNume;
        resedinta = pResedinta;
    }
    public String toString(){
        return nume;
    }
    public String getResedinta(){
        return resedinta;
    }
}