/*
 * Salariat.java
 *
 * Created on 02 martie 2004, 19:35
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
/** Salariat.java */

public class Salariat extends Persoana{ // definitie clasa Salariat
									// derivata din Persoana
    // membri-variabile publici
      public String marca;
      public double pct_Vechime;
      public double pct_Penalizare;

    // membri-variabile private
      private double salTarifar;
      private double pct_Conducere;
      private double sporVechime;
      private double sporConducere;
      protected double salariu;

    // membri-metode
      public double calculSalariu() {return salariu;}
      public void stabVechime(boolean modifica, double pVechime){}
      public void stabConducere(boolean modifica, double pConducere){}

      public Salariat(String pCnp, String pNumePren, String pMarca,
        double pSalTarifar, double pVechime, double pConducere)
            {/*constructor clasa Salariat*/}
}
