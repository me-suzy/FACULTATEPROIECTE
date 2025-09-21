/*
 * SalariatAcord.java
 *
 * Created on 24 martie 2003, 11:07
 */

package exemple.constructoriPolimorfism;

/**
 *
 * @author  strimbeic
 */
public class SalariatAcord extends Salariat{
   public double pct_Realizat;
   // suprascriere
   public double calculSalariu() {
    salariu = super.calculSalariu()*pct_Realizat;
    System.out.println("SalariatAcord.calculSalariu() "+ (int)salariu);
    return salariu;
   }
}
