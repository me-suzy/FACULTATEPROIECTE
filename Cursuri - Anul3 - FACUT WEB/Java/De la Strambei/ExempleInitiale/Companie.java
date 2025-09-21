/*
 * Companie2.java
 *
 * Created on 03 martie 2004, 09:06
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
class Departament {
  public String nume;
  public int nrMembri;

  public Departament(String pNume, int pNrMembri){
    nume = pNume;
    nrMembri = pNrMembri;
  }
}

public class Companie {
  public String codFiscal;
  public String nume;
  public String sediu;
  public Departament[] departamente;

// constructorul default
  public Companie(){
    System.out.println("Instantiere Companie prin constructor fara parametri");
    System.out.println(nume);
  }
// primul constructor parametrizat
  public Companie(String pCodFiscal, String pNume, String pSediu){
    System.out.println("Instantiere Companie - primul constructor cuparametri");
    codFiscal = pCodFiscal;
    nume = pNume;
    sediu = pSediu;
    System.out.println(nume);
  }
// al doilea constructor parametrizat
  public Companie(String pCodFiscal, String pNume, 
   String pSediu, int nrDepartamente){
    System.out.println("Instantiere Companie - al doilea constructor cu parametri");
    codFiscal = pCodFiscal;
    nume = pNume;
    sediu = pSediu;
    departamente = new Departament[nrDepartamente];
    System.out.println(nume);
  }
}

