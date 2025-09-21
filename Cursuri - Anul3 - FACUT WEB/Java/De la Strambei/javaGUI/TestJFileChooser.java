/*
 * TestJFileChooser.java
 *
 * Created on May 13, 2004, 8:44 AM
 */

package javaGUI;

/**
 *
 * @author  strimbeic
 */
public class TestJFileChooser {
    
    /** Creates a new instance of TestJFileChooser */
    public TestJFileChooser() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception{
        // TODO code application logic here
        javax.swing.UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new javax.swing.JFileChooser().showOpenDialog(null);
    }
    
}
