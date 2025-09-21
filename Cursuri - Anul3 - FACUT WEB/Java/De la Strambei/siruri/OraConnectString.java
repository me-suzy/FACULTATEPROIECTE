/*
 * OraConnectString_1.java
 *
 * Created on 19 aprilie 2003, 14:01
 */

package siruri;

/**
 *
 * @author  strimbeic
 */
public class OraConnectString {
    private String sirConectare;
    private String utilizator;
    private String parola;
    private String serviciuBD;    
    /** Creates a new instance of OraConnectString_1 */
    public OraConnectString(String user, String password, String service) {
        utilizator = user;
        parola = password;
        serviciuBD = service;
        makeStringConnect();
    }
    private void makeStringConnect(){
        //sirConectare = utilizator + '/' + parola + '@' + serviciuBD;
        StringBuffer sir = new StringBuffer();
        sir.append(utilizator);
        sir.append('/');
        sir.append(parola);
        sir.append('@');
        sir.append(serviciuBD);
        sirConectare = sir.toString();
    }
    public String getSirConectare(){
        return sirConectare;
    }
    public String getUtilizator(){
        return utilizator;
    }
    public String getParola(){
        return parola;
    }
    public String getServiciu(){
        return serviciuBD;
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        System.out.println(new OraConnectString("scott", "tiger", "BDSTUD").getSirConectare());
    }
    
}
