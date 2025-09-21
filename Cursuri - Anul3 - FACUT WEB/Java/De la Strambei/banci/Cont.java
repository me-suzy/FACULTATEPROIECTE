/*
 * Cont.java
 *
 * Created on 17 martie 2003, 10:47
 */

package banci;

/**
 *
 * @author  strimbeic
 */
public class Cont{
  public String nrCont;
  
  //iniþializare în momentul definirii
  public String tipClient = new String("Persoana Fizica");
  
  //public String titularCont;
  public Client titularCont;

  //iniþializare în momentul definirii
  public String tipCont = new String("Debit");

  public Banca banca;

  private float debitCont;
  private float creditCont;
  private float limitaCreditare;
  private float disponibil;
  private float soldCont;

  public float depune(float sumaDepusa){
    debitCont = (creditCont > sumaDepusa) ? 0 : debitCont + 
        (sumaDepusa - creditCont);
    creditCont = (creditCont > sumaDepusa) ? creditCont - sumaDepusa : 0;
    soldCont = debitCont - creditCont;
    disponibil = limitaCreditare + soldCont;
    System.out.println("Varsat in cont pentru " + titularCont + " suma de "
    + sumaDepusa + " Sold cont " + soldCont + " Disponibil " + disponibil);
    return soldCont;
  }
  public float retrage(float sumaRetrasa) throws DisponibilContInsuficient{
    if (sumaRetrasa > disponibil){
      //System.out.println("Fonduri insuficiente. Poate fi retrasa o suma maxima de "
      //  + disponibil);
      throw new DisponibilContInsuficient("Fonduri insuficiente. Poate fi retrasa o suma maxima de "
      + disponibil);
    }
    else {
      debitCont = (sumaRetrasa >= debitCont) ? 0 : debitCont - sumaRetrasa;
      creditCont = (sumaRetrasa > debitCont) ? creditCont + 
(sumaRetrasa - debitCont) : 0;
      disponibil = disponibil + debitCont - creditCont;
      soldCont = debitCont - creditCont;
      System.out.println("Retras din contul " + titularCont + " suma de "
        + sumaRetrasa + " Sold cont " + soldCont + " Disponibil " + disponibil);
      }
    return soldCont;
  }
  public void stabLimitaCreditare (float suma) {
    if (tipCont == "Credit") {
      limitaCreditare = suma;
      disponibil = limitaCreditare + soldCont;
      System.out.println("Am creditat contul " + titularCont + " cu suma de "
        + suma + " Sold cont " + soldCont + " Disponibil " + disponibil);
    }
  }
  public Cont(Banca pBanca, String pNrCont, Client pTitular) {
      banca = pBanca;
      nrCont = pNrCont;
      titularCont = pTitular;
  }
  public Cont(){}
}

