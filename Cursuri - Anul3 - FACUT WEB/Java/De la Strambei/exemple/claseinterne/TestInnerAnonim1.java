/*
 * TestInnerAnonim.java
 *
 * Created on 31 martie 2003, 12:53
 */

package exemple.claseinterne;

abstract class ClasaAbstracta1{
  private String m1 = "Valoare membru clasa interna";
  public abstract String getm1();
}
class ClasaExterna3 {
  public ClasaAbstracta1 referintaInterna(){
    return new ClasaAbstracta1(){
      private String m1 = "Valoare membru clasa interna anonima";
      // metoda de acces la membrul clasei interne
      public String getm1() {return m1;}
      {m1 = "Valoare membru clasa interna anonima preluata din constructor";}
    };
  }
}

public class TestInnerAnonim1 {
  public static void main(String[] args) {
    ClasaExterna3 obj_ext = new ClasaExterna3();
    ClasaAbstracta1 obj_abs = obj_ext.referintaInterna();
    System.out.println(obj_abs.getm1());
  }
}

