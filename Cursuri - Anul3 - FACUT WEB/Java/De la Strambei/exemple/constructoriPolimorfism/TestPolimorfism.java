/*
 * TestMostenireC1.java
 *
 * Created on 24 martie 2003, 11:36
 */

package exemple.constructoriPolimorfism;

import clienti.Persoana;
/**
 *
 * @author  strimbeic
 */
public class TestPolimorfism {
    
  public static void main(String[] args) {
    Persoana[] angajati = {new Salariat("CNP1", "Salariat 1", "10001"),
                new Colaborator("CNP2", "Colaborator 1", "20001"),
                new Salariat("CNP2", "Salariat 2", "10002"),
                new Persoana("CNP3", "Persoana 1", null)} ;
    for (int i=0 ; i < angajati.length ; i++ )
      System.out.println(angajati[i].getNume());
  } 
}
