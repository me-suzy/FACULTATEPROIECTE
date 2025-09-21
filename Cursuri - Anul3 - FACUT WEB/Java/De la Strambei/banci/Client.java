/*
 * Client.java
 *
 * Created on 24 martie 2003, 12:24
 */

package banci;

/**
 *
 * @author  strimbeic
 */
public interface Client {
      Cont deschideCont(String pBanca, String pNume, Client pidClient);
      String pidClient();
      String aflaNume();
      String aflaID();
}
