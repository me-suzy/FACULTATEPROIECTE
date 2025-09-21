/*
 * FormMain.java
 *
 * Created on 29 mai 2003, 17:41
 */

package Menus;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
/**
 *
 * @author  strimbeic
 */
public class FormMain extends JFrame{
    
    /** Creates a new instance of FormMain */
    public FormMain() {
        this.setJMenuBar(new MainMenuBar());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(500, 300);
        this.setVisible(true);        
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        new FormMain();
    }
    
}
