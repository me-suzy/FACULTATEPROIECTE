/*
 * FormIntern.java
 *
 * Created on 10 mai 2003, 15:41
 */

package javaGUI;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
/**
 *
 * @author  strimbeic
 */
public class FormIntern extends JInternalFrame{
    
    /** Creates a new instance of FormIntern */
    public FormIntern() {          
        getContentPane().setLayout(new FlowLayout());
        getContentPane().add(new JLabel("Cadru intern dialog"));
        this.setMaximizable(true);
        this.setIconifiable(true);
        this.setDefaultCloseOperation(JInternalFrame.EXIT_ON_CLOSE);
        this.setSize(200, 200);     
    }
    
}
