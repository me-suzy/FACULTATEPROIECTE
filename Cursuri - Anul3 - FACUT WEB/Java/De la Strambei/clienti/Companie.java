package clienti;

/*
 * Companie.java
 *
 * Created on 07 martie 2003, 09:54
 */
import salariati.Departament;
import banci.Cont;
import banci.Client;
/**
 *
 * @author  strimbeic
 */
public class Companie implements Client{ // -> început definitie
  public String codFiscal;
  public String nume;
  public String sediu;
  public Departament[] departamente;
  private int formaJuridica;

  public Companie(String pCodFiscal, String pNume, String pSediu){
/*declaratie companie*/
  }
/*  public double calculFondSalarii(){
    return fondSalarii;
  }*/
  public String getformaJuridica(){
	   if (formaJuridica == SA) return "Societate pe actiuni";
	   if (formaJuridica == SRL) return "Societate cu raspundere limitata";
		else return null;
	 }

  public String aflaID() {
      return null;
  }
  
  public String aflaNume() {
      return null;
  }
  
  public Cont deschideCont(String pBanca, String pNume, Client pidClient) {
      return null;
  }
  
  public String pidClient() {
      return null;
  }
  
  public static final int SA = 1; //Societate pe actiuni
  public static final int SRL = 2; //Societate cu raspundere limitata
} // -> sfârºit definiþie
