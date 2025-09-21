/*
 * TestCompanie.java
 *
 * Created on 10 martie 2004, 09:09
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
public class TestCompanie {
    
  public static void main(String[] args){
    Companie prima_firma = new Companie();
    Companie a_doua_firma = new Companie("R0001","A doua Firma", null);
    Companie a_treia_firma = new Companie("R0001","A treia Firma",null, 2);
  }
    
}
