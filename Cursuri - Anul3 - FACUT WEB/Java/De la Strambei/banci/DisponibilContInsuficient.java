/*
 * DisponibilContInsuficient.java
 *
 * Created on 07 aprilie 2003, 12:44
 */

package banci;

/**
 *
 * @author  strimbeic
 */
public class DisponibilContInsuficient extends java.lang.Exception {
    
    /**
     * Creates a new instance of <code>DisponibilContInsuficient</code> without detail message.
     */
    public DisponibilContInsuficient() {
    }
    
    
    /**
     * Constructs an instance of <code>DisponibilContInsuficient</code> with the specified detail message.
     * @param msg the detail message.
     */
    public DisponibilContInsuficient(String msg) {
        super(msg);
    }
}
