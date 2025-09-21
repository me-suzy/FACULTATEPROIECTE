/*
 * MainFormPane.java
 *
 * Created on 10 mai 2003, 18:34
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
public class FormPane extends JPanel{
    
    /** Creates a new instance of MainFormPane */
    public FormPane() {
        this.setLayout(new FlowLayout());
        this.add(new JButton("Continut Formular"));
    }
    
}
