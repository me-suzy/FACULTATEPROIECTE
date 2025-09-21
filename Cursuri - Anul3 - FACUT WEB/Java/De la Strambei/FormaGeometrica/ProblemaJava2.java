/*
 * ProblemaJava2.java
 *
 * Created on 13 iunie 2003, 16:26
 */

package FormaGeometrica;

/**
 *
 * @author  strimbeic
 */
abstract class FormaGeometrica{
  void sterge(){System.out.println(" Sterge forma ");}
}
class Cerc extends FormaGeometrica{
  Cerc(){System.out.println(" Deseneaza cerc ");}
  void sterge(){System.out.println(" Sterge cerc ");}
}
class Patrulater extends FormaGeometrica{
  Patrulater(){
      System.out.println(" Deseneaza patrulater ");
  }
}
class Patrat extends Patrulater{
  Patrat(){
      System.out.println(" Deseneaza patrat ");
  }    
  void sterge(){
      System.out.println(" Sterge patrat ");
  }
}
public class ProblemaJava2 {
  static FormaGeometrica [] forme = {new Cerc(), new Patrulater(), new Patrat()};
  public static void main(String[] args) {
   forme[2].sterge();
   forme[2] = new Cerc();
  }
}