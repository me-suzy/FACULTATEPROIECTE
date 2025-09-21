/*
 * Partener.java
 *
 * Created on 19 mai 2003, 12:36
 */

package UMLTranslating;

/**
 *
 * @author  strimbeic
 */
interface Client{
    String getNumeClient();
}

public abstract class Partener implements Client{
    public Partener() {
    }
    
    public abstract String getNumeClient();
}
class PersoanaFizica extends Partener{
    public String getNumeClient() {
        return null;
    }
}
class PersoanaJuridica extends Partener{
    public String getNumeClient() {
        return null;
    }
}