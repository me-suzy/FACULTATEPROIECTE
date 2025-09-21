/*
 * ProblemaJava1.java
 *
 * Created on 13 iunie 2003, 16:03
 */

package FormaGeometrica;

/**
 *
 * @author  strimbeic
 */
abstract class FormaGeometrica{
  abstract void deseneaza();
  FormaGeometrica(){
      System.out.println(" Creez o forma geometrica ");
  }
}
class Cerc extends FormaGeometrica{
  void deseneaza(){System.out.println(" Deseneaza cerc ");}
}
class Patrulater extends FormaGeometrica{
  void deseneaza(){
      System.out.println(" Deseneaza patrulater ");
  }
}
class Patrat extends Patrulater{
  void deseneaza(){
      super.deseneaza();
      //System.out.println(" Deseneaza patrulater ");
      System.out.println(" Deseneaza patrat ");
  }  
}
public class ProblemaJava1 {
  static FormaGeometrica [] forme = {new Cerc(), new Patrat()};
  public static void main(String[] args) {
   forme[0].deseneaza();
   forme[1].deseneaza();
  }
}

