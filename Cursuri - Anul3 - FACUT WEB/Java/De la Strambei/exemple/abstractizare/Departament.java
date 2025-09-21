/*
 * Departament.java
 *
 * Created on 24 martie 2003, 10:32
 */

package exemple.abstractizare;

/**
 *
 * @author  strimbeic
 */
public class Departament extends BusinessUnit{
    private Departament unitateSuperioara;
    /** Creates a new instance of Departament */
    public Departament() {
    }
    
    public BusinessUnit getUnitateSuperioara() {
        return unitateSuperioara;
    }
    
}
