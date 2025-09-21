/*
 * Persoana.java
 *
 * Created on 17 martie 2003, 11:35
 */

package clienti;

import banci.Cont;
import banci.Banca;
/**
 *
 * @author  strimbeic
 */
public class Persoana implements banci.Client{
  //iniþializare în constructor
  public String cnp;
  public String numePren;
  public String domiciliu;
  public Cont contBanca;
    protected Persoana(){
    }
    public Persoana(String pCnp, String pNumePren, String pDomiciliu){
        cnp = pCnp;
        numePren = pNumePren;
        domiciliu = pDomiciliu;
    }
    public void stabContBanca(String pNrCont, Banca pBanca){
        // iniþializare în momentul folosirii
        contBanca = new Cont();
        contBanca.nrCont = pNrCont;
        contBanca.banca = pBanca;
        contBanca.tipCont = new String("PersoanaFizica");
        //contBanca.titularCont = this.numePren;
    }
    public boolean equals (Object o){
        System.out.println("Apel Persoana.equals(Object)");
        if (o instanceof Persoana)
          return this.cnp == ((Persoana)o).cnp ;
        else
          return false ;
    }
    public String getNume(){
        return numePren;
    }
    
    public String aflaID() {
        return null;
    }
    
    public String aflaNume() {
        return null;
    }
    
    public Cont deschideCont(String pBanca, String pNume, banci.Client pidClient) {
        return null;
    }
    
    public String pidClient() {
        return null;
    }
    
}

