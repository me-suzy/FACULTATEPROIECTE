/*
 * Companie.java
 *
 * Created on 02 martie 2004, 19:32
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
public class Companie_ { // -> început definitie
  public String codFiscal;
  public String nume;
  public String sediu;
  public Departament_[] departamente;
  private int formaJuridica;

  public Companie_(String pCodFiscal, String pNume, String pSediu){
    codFiscal = pCodFiscal;
    nume = pNume;
    sediu = pSediu;      
  }
  public double calculFondSalarii(){
    int fondSalarii=0;
    /* instructiuni calcul fondSalarii */
    return fondSalarii;
  }
  public String getFormaJuridica(){
	   if (formaJuridica == SA) return "Societate pe actiuni";
	   if (formaJuridica == SRL) return "Societate cu raspundere limitata";
		else return null;
	 }

  public static final int SA = 1; //Societate pe actiuni
  public static final int SRL = 2; //Societate cu raspundere limitata
} // -> sfârºit definiþie

class Departament_{}
