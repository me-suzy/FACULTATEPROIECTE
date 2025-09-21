package ExempleInitiale;

/*
 * CarteInfo.java
 *
 * Created on 10 martie 2003, 13:03
 */

/**
 *
 * @author  strimbeic
 */
class Pagina {
  static Titlu antet = CarteInfo.titluCarte;
  int nrPagina;
  static int nrPaginiCarte = CarteInfo.nrPagini;
  Pagina(int pageno){
      nrPagina = pageno;
      System.out.println("Pagina["+nrPagina+"].nrPaginiCarte = "+nrPaginiCarte);
  }
}
class Titlu {
  String autor;
  String numeTitlu;
  Titlu(String pautor, String pnumeTitlu){
      autor = pautor;
      numeTitlu = pnumeTitlu;
      System.out.println("Am initializat titlul "+autor+" "+numeTitlu);
  }
}

public class CarteInfo {
  static Titlu titluCarte = new Titlu("Eckel", "JAVA");
  Pagina[] pagini;
  static int nrPagini;
  CarteInfo(int pnrpagini){
      nrPagini = pnrpagini;
      pagini = new Pagina[nrPagini];
      for (int i=0; i < pnrpagini; i++)
          pagini[i] = new Pagina(i+1);
      
  }

}
