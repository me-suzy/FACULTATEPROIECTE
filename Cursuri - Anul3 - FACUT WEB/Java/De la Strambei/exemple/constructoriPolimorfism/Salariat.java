
/*
 * Salariat.java
 *
 * Created on 24 martie 2003, 10:48
 */
package exemple.constructoriPolimorfism;

import clienti.*;
/**
 *
 * @author  strimbeic
 */
public class Salariat extends Persoana{
  public String marca;
  public double pct_Vechime;
  public double pct_Penalizare;
  private double salTarifar;
  private double pct_Conducere;
  private double sporVechime;
  private double sporConducere;
  protected double salariu;

  // Supraincarcare in cazul metodelor calculSalariu()
    public double calculSalariu() {
        stabVechime(false, 0);
        stabConducere(false, 0);
        salariu = (1-pct_Penalizare) * (salTarifar + sporVechime + sporConducere);
        System.out.println("Salariat.calculSalariu() "+(int)salariu);
        return salariu;
    }
    public double calculSalariu(double pVechime) {
        stabVechime(true, pVechime) ;
        salariu = (1 - pct_Penalizare)*(salTarifar + sporVechime + sporConducere) ;
        return salariu;
    };
    public double calculSalariu(double pVechime, 
            double pPenalizare) {
            pct_Penalizare = pPenalizare ;
            this.calculSalariu(pVechime) ;
            return salariu;
    };

    public void stabVechime(boolean modifica, double pVechime){
        if (modifica)
          pct_Vechime = pVechime;
        sporVechime = salTarifar * pct_Vechime;
    }
    public void stabConducere(boolean modifica, double pConducere){
        if (modifica)
          pct_Conducere = pConducere;
        sporConducere = salTarifar * pct_Conducere;
    }
    
    // supraincarcare in cazul constructorilor
    public Salariat(){}
    public Salariat(String pCnp, String pNume, String pMarca){
        super(pCnp, pNume, null) ;
        marca = pMarca ;
    }
    public Salariat(String pCnp, String pNumePren, String pMarca,
    double pSalTarifar, double pVechime, double pConducere){
        this(pCnp, pNumePren, pMarca);
        salTarifar = pSalTarifar;
        stabVechime(true, pVechime);
        stabConducere(true, pConducere);
    }
    public boolean equals (Persoana s){
        System.out.println("Apel Salariat.equals(Persoana)");
        if (s instanceof Persoana)
          return super.equals(s) && this.marca == ((Salariat)s).marca;
        else
          return false ;
    }
}
