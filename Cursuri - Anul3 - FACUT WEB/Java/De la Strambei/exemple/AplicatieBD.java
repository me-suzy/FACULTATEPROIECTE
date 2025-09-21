/*
 * AplicatieBD.java
 *
 * Created on 17 martie 2003, 13:06
 */

package exemple;

/**
 *
 * @author  strimbeic
 */
class Conexiune {
  private Conexiune() {};
  static Conexiune Conecteaza(){
    return new Conexiune();
  }
}
public class AplicatieBD {
  public static void main(String[] args) {
    //Conexiune cnx = new Conexiune(); nu merge
    Conexiune cnx = Conexiune.Conecteaza();
  }
}

