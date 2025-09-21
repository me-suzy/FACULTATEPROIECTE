/*
 * TestInnerClasses1.java
 *
 * Created on 31 martie 2003, 12:27
 */

package exemple.claseinterne;

class ClasaExterna1{
  // clasa interna inclusa in ClasaExterna
  class ClasaInterna1 {
    private String m1 = "Valoare interna 1";
    // metoda de acces la membrul clasei interne
    public String getm1() {return m1;}
  }
  // metoda a clasei externe de acces la membrul clasei interne
  public String getMembruIntern(ClasaInterna1 obj_int){
    return obj_int.getm1();
  }
}

// Clasa de test prin care va fi accesata clasa interna prin
// intermediul clasei externe care o include
public class TestInnerClasses1 {
  public static void main(String[] args) {
  // creez o instanta a clasei externe
    ClasaExterna1 o = new ClasaExterna1();
 // creez o referinta la clasa interna
    ClasaExterna1.ClasaInterna1 obj_intern = o.new ClasaInterna1();
// apelez o metoda a clasei interne
    System.out.println(obj_intern.getm1());
  }
}

