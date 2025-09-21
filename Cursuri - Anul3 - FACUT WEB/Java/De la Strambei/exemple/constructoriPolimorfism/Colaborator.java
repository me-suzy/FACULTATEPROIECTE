/*
 * Colaborator.java
 *
 * Created on 24 martie 2003, 11:37
 */

package exemple.constructoriPolimorfism;
import clienti.Persoana;
/**
 *
 * @author  strimbeic
 */
public class Colaborator extends Persoana{
  public String nrConventie;
  public Colaborator(String pCnp, String pNumePren, String pNrConventie){
    super(pCnp, pNumePren, null);
    nrConventie = pNrConventie;
  }
}
