/*
 * TestStatic.java
 *
 * Created on 02 martie 2004, 19:39
 */

package ExempleInitiale;

/**
 *
 * @author  strimbeic
 */
public class TestStatic {
  static void metodaStatica(){
    //metodaNonStatica();
    System.out.println("Static Success");
  }
  void metodaNonStatica(){
    System.out.println("NonStatic Success");
  }
  public static void main(String[] args) {
    TestStatic t = new TestStatic ();
    t.metodaNonStatica();
  }
}

