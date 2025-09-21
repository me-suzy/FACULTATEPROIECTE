package exemple;

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
  String titlu;
  Titlu(String pautor, String ptitlu){
      autor = pautor;
      titlu = ptitlu;
      System.out.println("Am initializat titlul "+autor+" "+titlu);
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
  public static void main(String[] args) {
    //System.out.println(pagini);
    System.out.println("1: CarteInfo.Pagini = "+ nrPagini);
    CarteInfo o_carte = new CarteInfo(2);
    System.out.println("2: CarteInfo.nrPagini = "+ nrPagini);
    }
}
