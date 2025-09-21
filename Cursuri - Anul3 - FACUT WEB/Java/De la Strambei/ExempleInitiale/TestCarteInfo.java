/*
 * TestCarteInfo.java
 *
 * Created on 10 martie 2004, 09:26
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
public class TestCarteInfo {
    
  public static void main(String[] args) {
    System.out.println("1: CarteInfo.nrPagini = "+ CarteInfo.nrPagini); //mesaj 1
    CarteInfo o_carte = new CarteInfo(2);
    System.out.println("2: CarteInfo.nrPagini = "+ CarteInfo.nrPagini);
    }
}
/*
 *incarcare clasa CarteInfo.Java
 *initializare membri statici CarteInfo: CarteInfo.Titlu, CarteInfo.nrPagini
 *incarcare clasa Titlu
 *initializare membri statici Titlu: -
 *instantiere clasa Titlu
 *apel constructor Titlu (String, String)
 *afisare mesaj 1: acces la membrul static CarteInfo.nrPagini inainte de instantierea clasei
 *instantiere clasa CarteInfo
 *apel constructor CarteInfo (int)
 *incarcare clasa Pagina
 *initializare membri statici Pagina: Pagina.antet, Pagina.nrPaginiCarte
 *instantiere clasa Pagina
 *apel constructor Pagina(int) - pentru fiecare element din membrul-array pagini al CarteInfo
 *afisare mesaj din constructor Pagina(int)
 *afisare mesaj 2: dupa initializarea membrului non-static pagini al CarteInfo
 */
