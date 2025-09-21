/*
 * OraConnect.java
 *
 * Created on 18 aprilie 2003, 11:50
 */

package siruri;

/**
 *
 * @author  strimbeic
 */
public class OraConnect {
    private String sirConectare;
    private String utilizator;
    private String parola;
    private String serviciuBD;
    /** Creates a new instance of OraConnect */
    public OraConnect(String conect) {
        sirConectare = conect;
        parseSirConectare();
    }
    private void parseSirConectare(){
        //format sir conectare user/parola@serviciu
        int pozitieDel1 = sirConectare.indexOf('/');
        int pozitieDel2 = sirConectare.indexOf('@');
        utilizator = sirConectare.substring(0, pozitieDel1);
        parola = sirConectare.substring(pozitieDel1 + 1, pozitieDel2);
        serviciuBD = sirConectare.substring(pozitieDel2 + 1);
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
    
    public static void main(String[] args){
        OraConnect sir = new OraConnect("scott/tiger@BDSTUD");
        String s;
        System.out.println("User: " + sir.getUtilizator());
        System.out.println("Password: " + sir.getParola());
        System.out.println("Serviciu: " + sir.getServiciu());
        String v1 = "c";
        String v2 = "a";
        String v3 = v2;
        System.out.println(v1==v3);
        Comparativ c1 = new Comparativ();
        c1.comparator = 20;
        Comparativ c2 = new Comparativ();
        c2.comparator = 20;
        System.out.println(c1==c2);
        System.out.println(c1.equals(c2));
        System.out.println(v1.compareTo(v2));
    }
}

class Comparativ{
    int comparator = 1;
    public boolean equals(Object obj){
        if (comparator == ((Comparativ)obj).comparator)
            return true;
        else
            return false;
    }
}
